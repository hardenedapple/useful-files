#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/mount.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <stdbool.h>
#include <signal.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <stddef.h>
#include <dirent.h>
#include <stdint.h>
#include <stdio.h>
#include <errno.h>
#include <sched.h>

#define err_exit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
                        } while (0)

// vimcmd: let &makeprg="gcc -Wall -W -g % -o %:r"
// vimcmd: !sudo chown root:root %:r
// vimcmd: !sudo chmod u+s %:r
//
// Silly little program to change a directory to read only for a shell session.
// The basic use case is for when you're poking around a machine that's quite
// important, and you're just feeling a little insecure about the pitfalls of
// unix ... "what if I get too comfortable and accidentaly type something
// stupid?".
// Have this program on your machine, run it to make the directory read-only,
// if you want to change something, then press ^D and change something before
// running this program again.
// Example:
//  ./make_readonly /home/hardenedapple /mnt/unused
// makes /home/hardenedapple  read-only
//
// Options that don't require a C program
// What I do here, but as a set of bash commands.
//  sudo unshare -m bash
//  mount --make-private /
//  mount -t overlay overlay -olowerdir=/home/hardenedapple:/mnt/usb /home/hardenedapple
//  cd ../hardenedapple
// Chroot into a new mount point.
//  sudo mount -t overlay overlay -olowerdir=/:<some empty directory> <mount point>;
//  sudo --preserve-env chroot --userspec=<user>:<group> <mount point>
//      # and to clean up
//  sudo umount <mount point>
//      // or
//  sudo mount -o rbind,ro / <mount point>
//  sudo mount --make-rprivate <mount point> # needed because systemd changed the defaults from private to shared
//  sudo --preserve-env chroot --userspec=<user>:<group> <mount point>
//      # and to clean up
//  sudo umount --recursive <mount point>
// Completely different approach, don't have to do anything special.
//  Create a new user on the machine
//  Give this user read-only access rights to everything
//  su - readonlyuser


void usage(char* command_name)
{
    printf("This command must be ran with two arguments.\n"
            "It starts a new shell session that can not modify files on the filesystem.\n"
            "Both arguments must be directories.\n"
            "The second directory given on the command line must be empty.\n"
            "Due to technical limitations, you can't use the root filesystem as the first argument.\n"
            "Usage: %s <re-mount point> <empty directory>\n", command_name);
    exit(1);
}

/*
 * Current understanding of the way things work:
 *  In order to make it so that mounts in one process don't affect mounts
 *  in another one you need to:
 *      Put them in different mount namespaces
 *      mark the mount point upon which you want to mount other things as
 *      private.
 *      then mount something on that private mount point.
 *
 *      Mark the mount point upon which you want to mount other things as
 *      private.
 *      Then mount something on that private mount point.
 *
 *      You then have to get into that mounted overlay.
 *      This can be done by a simple cd ../$(basename `pwd`)
 */

/*
 * Observations I don"t like / don"t understand / think might provide
 * useful information when trying to figure out why things aren"t working
 * the way I hope:
 *      vimcmd: r! uname --kernel-release | sed 's/^/                /'
            4.13.12-1-ARCH
 *      Man page on mount(2) says (in second paragraph of NOTES) that
 *      MS_MGC_VAL is no longer required and ignored if specified since
 *      Linux 2.4.
 *      But if I don"t include that flag I get EINVAL.
 *
 *      ls -l /proc/self/ns
 *      shows that when in the shell this command leaves you in, you have a
 *      different mount namespace to the one you started in.
 *
 *      What determines a peer group between namespaces?
 *      How would one change peer groups?
 *
 *      mount --make-private in the shell provided by this program shows
 *      that it removes the `shared:X` in the relevant line of
 *      /proc/self/mountinfo.
 *      But it doesn't remove the mount from other namespaces.
 *      In processes from other mount namespaces, the relevant line in
 *      /proc/self/mountinfo stays the same, with the `shared:X` still
 *      there.
 *      A process in one namespace changing files in the overlay fs
 *      propagates those changes to the other namespace, and unmounting the
 *      mount point in one namespace unmounts it to the other.
 */

// Documentation on overlayfs
// https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/overlayfs.txt
// Make the root mount point private.

// Option 1
//  Clone to create a new namespace.
//  child -> Lose root priviledges.
//  child -> execv('bash')
//  parent -> wait()
int mount_readonly(
        uid_t orig_uid,
        const char * const mount_point,
        const char * const empty_dir)
{
    const char * const options_format = "lowerdir=%s:%s";
    // Don't actually need the + 1 here, but it saves anyone reading it the
    // thought "are we missing the NULL character ... oh no, it"s counted in
    // the `%s` characters of the format string.
    const size_t num_chars = strlen(mount_point) + strlen(empty_dir) + strlen(options_format) + 1;
    char* const options_string = malloc(num_chars);
    snprintf(options_string, num_chars, options_format, mount_point, empty_dir);
    if (unshare(CLONE_NEWNS) == -1) { err_exit("unshare"); }
    // Make entire system privately mounted.
    if (mount("none", "/", NULL, MS_REC|MS_PRIVATE, NULL)) { err_exit("mount make private"); }
    if (mount("overlay",
           mount_point,
           "overlay",
           MS_MGC_VAL,
           // Can"t *just* mount an overlayfs with only one filesystem.
           // Hence I"m using a filesystem I happen to know to be empty so that
           // things aren"t confusing.
           options_string)) {
        err_exit("mount overlay");
    }

    // Have to change directory to the mount point so that we enter the
    // overlayfs instead of staying in the original filesystem (which is not
    // mounted read-only).
    if (chdir(mount_point)) { err_exit("chdir"); }
    if (seteuid(orig_uid)) { err_exit("uid failed"); }

    char * const argv[] = { "/bin/bash", NULL };
    // environ is defined in <unistd.h> if _GNU_SOURCE is defined.
    execve("/bin/bash", argv, environ);
    err_exit("execve returned");
    return 0;
}

bool is_directory(const char * const name)
{
    struct stat file_info;
    if (stat(name, &file_info)) { err_exit("failure in stat"); }
    bool answer = S_ISDIR(file_info.st_mode);
    return answer;
}

bool is_empty_directory(const char * const name)
{
    if (!is_directory(name)) { return false; }
    DIR * dirstream = opendir(name);
    if (dirstream == NULL) { err_exit("opendir"); }
    errno = 0;
    uint8_t num_elements = 0;
    struct dirent *cur_dirent;
    while (num_elements < 3 && (cur_dirent = readdir(dirstream))) { 
        num_elements += 1;
    }
    if (errno != 0) { err_exit("readdir"); }
    if (closedir(dirstream)) { err_exit("closedir"); }
    return num_elements == 2;
}

int main(int argc, char *argv[])
{
    // Unfortunately, because of the need to change directory out of the
    // current mount and into the new mount, overlay mounting the "/" directory
    // doesn"t work.
    // This because we can"t move out of the "/" directory to be able to move
    // back into it.
    //
    // Because of this we need the user to specify the directory to overlay
    // with itself.
    if (argc != 3) { usage(argv[0]); }
    if (!is_directory(argv[1])) { usage(argv[0]); }
    if (!is_empty_directory(argv[2])) { usage(argv[0]); }
    if (!strcmp("/", argv[1])) { usage(argv[0]); }
    uid_t real = getuid();
    if (seteuid(0)) { err_exit("seteuid to root failed"); }
    mount_readonly(real, argv[1], argv[2]);

    return 0;
}
