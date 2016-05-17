#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
#include <errno.h>
#include <pthread.h>

/*
 * This program is a very simple wrapper around gdb.
 * Its only purpose is to unmask the SIGCHLD signal before gdb runs.
 * This is required because the 'win' command inside acme calls the
 * rcstart() function that masks SIGCHLD.
 * 
 * gdb relies heavily on this signal (as does the entire pthreads(2)
 * library), which is why I've made a wrapper for that specific
 * program.
 *
 * I'm currently looking at the feasibility of unmasking SIGCHLD in
 * win before running any other programs, so all programs running in
 * a win window will be able to receive SIGCHLD signals.
 *
 * vimcmd: !gcc -o gdb acmegdb.c -W -Wall -pthread
 */

#define handle_error_en(en, msg) \
	do { errno = en; perror(msg); exit(EXIT_FAILURE); } while (0)


int main(int argc, char *argv[])
{
	(void )argc;
	sigset_t set;
	int s;
	sigemptyset(&set);
	sigaddset(&set, SIGCHLD);
	s = pthread_sigmask(SIG_UNBLOCK, &set, NULL);
	if (s != 0)
		handle_error_en(s, "pthread_sigmask");

	argv[0] = "gdb";
	int exec_return;
	exec_return = execv("/usr/bin/gdb", argv);
	if (exec_return)
		perror("Returned from exec call");

	return 1;
}