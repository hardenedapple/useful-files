#![feature(slice_patterns)]
extern crate libc;
extern crate errno;

use std::os::unix::process::CommandExt;

/*
 * N.b. has to be compiled with access to the libc and errno crates.
 * TODO???
 *  Maybe I should invoke whichever shell the user is currently running.
 *  Not something I actually want to do, but it makes sense as a functionality.
 */


#[derive(Debug)]
enum ArgumentIsNot {
    Given,
    Directory,
    Empty,
    Usable(::std::io::Error),
    Allowed,
}

// Rather than manually implement Debug to print out the enum type as well as the enum value, just
// do this.
#[derive(Debug)]
enum SillyFormattingTrick { ArgumentIsNot(ArgumentIsNot) }

fn usage(arg_problem: ArgumentIsNot) {
    let command_name = ::std::env::args().next().unwrap_or(String::from("\"Unknown Name\""));
    println!("Usage: {} <empty directory>", command_name);
    print!("Bind mounts the root filesystem read only in the given directory,");
    println!("then chroots into that directory.");
    println!("To avoid losing access to files, the argument must be an empty directory.");
    println!("Problem: {:?}", SillyFormattingTrick::ArgumentIsNot(arg_problem));
}

/// Parse the arguments so that
fn parse_args() -> Result<String, ArgumentIsNot> {
    let mut args = ::std::env::args();
    // Seeing as we have to iterate over the first argument here, we may as well check that the
    // first argument exists, and return error if it doesn't.
    // This first argument should be the name of the program.
    if args.next().is_none() { return Result::Err(ArgumentIsNot::Given) }
    match args.next() {
        None => return Result::Err(ArgumentIsNot::Given),
        Some(dirname) => {
            // We check for directory here to give nice error messages to the user.
            // We would find a problem if the given name was a file when attempting to read it as a
            // directory below, but then we would have to go backwards from the error message to
            // figure out what the problem was.
            match ::std::fs::metadata(&dirname) {
                Err(real_err) => return Result::Err(ArgumentIsNot::Usable(real_err)),
                Ok(info) => {
                    if !info.is_dir() { return Result::Err(ArgumentIsNot::Directory); }
                }
            }
            match ::std::fs::read_dir(&dirname) {
                Err(real_err) => return Result::Err(ArgumentIsNot::Usable(real_err)),
                Ok(mut dir_iter) => {
                    // It appears that the "." and ".." entries are ignored.
                    if !dir_iter.next().is_none() {
                        return Result::Err(ArgumentIsNot::Empty);
                    }
                }
            }
            if args.next().is_some() {
                Result::Err(ArgumentIsNot::Allowed)
            } else {
                Result::Ok(dirname)
            }
        }
    }
}

// If anything fails, the program exits, and because all state changes were done in a namespace
// isolating those changes everything is fine.
// Hence, no cleanup.
fn mount_with(mountpoint: String) -> String {
    let pathbuf = match std::env::current_dir() {
        Ok(x) => x,
        Err(ioerr) => return format!("{}", ioerr),
    };
    
    // Keep the CString values around so they don't get deallocated until the end of the block.
    let rootcstr = std::ffi::CString::new("/")
                            .expect("Failed to create CString from \"/\"");
    let mountcstr = std::ffi::CString::new(mountpoint)
                            .expect("Failed to create CString from given argument!!");
    let root = rootcstr.as_ptr();
    let mount = mountcstr.as_ptr();
    let unused = root;

    let orig_euid = unsafe { libc::getuid() };

    if unsafe { libc::unshare(libc::CLONE_NEWNS) } != 0 {
        return String::from("unshare error");
    }
    if unsafe { libc::mount(unused,
                            root,
                            std::ptr::null(),
                            libc::MS_REC | libc::MS_PRIVATE,
                            std::ptr::null()) } != 0 {
        return String::from("mount make private");
    }
    // n.b. running `strace mount -o rbind,ro / /mnt/usb` shows that program calls mount twice.
    // mount("/", "/mnt/usb", 0x55f6bee59480, MS_MGC_VAL|MS_RDONLY|MS_BIND|MS_REC, NULL) = 0
    // mount("none", "/mnt/usb", NULL, MS_RDONLY|MS_REMOUNT|MS_BIND|MS_REC, NULL) = 0
    //
    // While it looks to me like the first one should mount the bound mount read only (there is the
    // MS_RDONLY flag there after all) it doesn't.
    // Hence we have to make the second call too.
    if unsafe { libc::mount(root,
                            mount,
                            std::ptr::null(),
                            libc::MS_MGC_VAL | libc::MS_RDONLY | libc::MS_BIND | libc::MS_REC,
                            std::ptr::null()) } != 0 {
        return String::from("mount bind");
    }
    if unsafe { libc::mount(unused,
                            mount,
                            std::ptr::null(),
                            libc::MS_RDONLY | libc::MS_REMOUNT | libc::MS_BIND | libc::MS_REC,
                            std::ptr::null()) } != 0 {
        return String::from("mount make read only");
    }

    if unsafe { libc::chroot(mount) } != 0 { return String::from("chroot"); }
    match std::env::set_current_dir(pathbuf) {
        Ok(_) => {},
        Err(ioerr) => return format!("Error changing directory! {}", ioerr),
    }
 
    if unsafe { libc::seteuid(orig_euid) } != 0 { return String::from("seteuid back to user"); }

    format!("exec error {}", std::process::Command::new("/bin/bash").exec())
}

pub fn main() {
   match parse_args() {
        Ok(dirname) => {
            // If mount_with() returns, that's an error.
            eprintln!("Error during mount_with: {}", mount_with(dirname));
            eprintln!("{}", errno::errno());
        },
        Err(arg_problem) =>  usage(arg_problem)
    }
    ::std::process::exit(libc::EXIT_FAILURE);
}
