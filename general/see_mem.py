#!/usr/bin/env python3
"""
Functions to find memory usage

Can run as a script to ask for total memory free, memory usage of all
programs or memory usage of single programs.

"""

# At the moment I'm not happy with how the arguments are parsed
# Seems like I've got into a mess with the options - but it works
from subprocess import Popen, PIPE
import re
import os
from collections import defaultdict


# Helper functions
def _pypgrep(pname):
    """Given process name, return pid's of all processes of that name"""
    procids = Popen(['pgrep', pname], stdout=PIPE).communicate()[0]
    procids = procids.decode('utf-8').split()
    return procids


def _choose(line):
    """Read line, search for Total, Free, Buffers and Cached in meminfo"""
    return re.findall(r'^(MemTotal|MemFree|Buffers|Cached):\s+(\d+).*', line)


def _all_pids():
    """Return iterator over all process id's"""
    return (pid for pid in os.listdir('/proc/')
            if re.match('^[0-9]+$', pid))


def _find_mem(pid, memtype):
    """Given process id and memtype, return memtype usage of process"""
    ret = 0
    with open('/proc/%s/smaps' % pid) as memfile:
        for line in memfile:
            match = re.match(r'{0}:\s+(\d+)\s*kB'.format(memtype), line)
            if match:
                ret += int(match.groups()[-1])
    # smaps gives results in units of kB
    return ret * 1000


def _get_pname(pid):
    """given pid, return the process name with it"""
    with open('/proc/%s/comm' % pid) as nam:
        return nam.read().strip()


def _try_val(pid, memtype):
    """Attempts to call _find_mem, catches PermissionError from process that
    I'm not allowed to read"""
    try:
        return (_get_pname(pid), _find_mem(pid, memtype))
    except PermissionError:
        return ('not allowed', 1)


def _pidcmd(pid, inc_non=True):
    """Given pid, return commandline that spawned it, or '?' if there wasn't
    one, or cannot open file"""
    try:
        cmd = open('/proc/%s/cmdline' % pid).read()[:-1]
        ret = cmd.replace('\0', ' ')
    except PermissionError:
        return '?'
    if inc_non and ret == '':
        return '?'
    return ret


def _is_kernel(pid, inc_non=True):
    """Tries to find out if the process pid is that of a kernel process (or at
    least one the user doesn't care about"""
    try:
        cmdline = _pidcmd(pid, inc_non)
    except PermissionError:
        return True
    if cmdline == '?':
        return True
    else:
        return False


# Usage functions
# Given a memory type, print out all different programs and their usage
def all_mem(memtype, inc_non=True):
    """Return a dictionary with keys process name and values memval
    Can ask for all processes I can read or all started with a command"""
    ret = {}
    for pid in _all_pids():
        if _is_kernel(pid, inc_non):
            continue
        pid_info = _try_val(pid, memtype)
        ret[(pid_info[0], pid)] = pid_info[1]
    # remove placeholder for those processes I don't have permission for
    # Have to make a list to iterate over (so don't modify dict while
    # iterating over it
    keylist = [key for key in ret if key[0] == 'not allowed']
    for key in keylist:
        del ret[key]
    return ret


def all_comb(memtype, inc_non=True):
    """Takes the dictionary from all_mem and returns total by each process
    name - e.g. total from 10 python instances"""
    sepdict = all_mem(memtype, inc_non)
    retdict = defaultdict(int)
    for key in sepdict:
        retdict[key[0]] += sepdict[key]
    return retdict


def swap_used():
    """Tells the total Swap percesnt used"""
    with open('/proc/meminfo') as meminf:
        for line in meminf:
            swt = re.match(r'SwapTotal:\s*(\d+).*', line)
            swf = re.match(r'SwapFree:\s*(\d+).*', line)
            if swt:
                sw_tot = int(swt.group(1))
            elif swf:
                sw_fr = int(swf.group(1))
    return 100 - (sw_fr / sw_tot * 100)


# Find total memory free
# Neater but slower than for loop
def ram_used():
    """Gives the ram used at the moment"""
    with open('/proc/meminfo') as meminf:
        chosen = [_choose(line) for line in meminf]
        ramdict = {val[0][0]: int(val[0][1]) for val in chosen if val}
    realfree = ramdict['MemFree'] + ramdict['Buffers'] + ramdict['Cached']
    realused = ramdict['MemTotal'] - realfree
    return realused / ramdict['MemTotal'] * 100

def _human_readable(num_bytes):
    suffixes = ['B', 'kB', 'mB', 'gB']
    print_num = num_bytes
    suffix_counter = 0
    while print_num >= 1000:
        print_num /= 1000
        suffix_counter += 1
    return '{:.2f} {}'.format(print_num, suffixes[suffix_counter])

# Given process name - return dict of different kinds of memory it uses
def one_program(pname):
    """Return dict - keys PID's values dicts of memtype and amount"""
    pidlist = _pypgrep(pname)
    mlist = ['Size', 'Swap', 'Rss', 'Pss']
    _memdict = lambda pid, mem: {mem: _human_readable(_find_mem(pid, mem))
                                for mem in mlist}
    return {pid: _memdict(pid, mlist) for pid in pidlist}


def print_nice(indict):
    """Takes a dict and prints it out all nice-like"""
    keys = sorted(indict)
    maxlen = max((len(str(key)) for key in keys))
    for key in keys:
        # TODO -- When running the one_program() function, this print format
        # doesn't help with the second dictionary (the dictionaries that are
        # the values of the main one).
        # Because of this, the keys of the second dictionary are printed all
        # in one column, and in a random order, making the output from this
        # script hard to automatically parse.
        #
        # I'd like to fix this on principle, but currently I have no reason to
        # automatically parse the output, and can't really be bothered to think
        # about how I'd like it.
        # Hence I'm leaving it for now.
        print('{0:<{1}} :   {2}'.format(str(key), maxlen, indict[key]))


if __name__ == '__main__':
    from argparse import ArgumentParser, RawTextHelpFormatter
    parser = ArgumentParser(description='''
    This script provides slightly more specific/nuanced information about the
    current memory usage on a machine.

    It is just a front end to viewing the /proc/PID/smaps files of different
    processes and summing the output of some elements.

    Some options take a Mem-Type argument, to specifiy what type of memory to
    display.
    Memory types are just regular expressions that we search for in
    /proc/PID/smaps, hence there are no specified options to choose from.

    The following entries are the fields currently stored on my laptop, and are
    provided as a memory aid.

    Size, Rss, Pss, Shared_Clean, Shared_Dirty, Private_Clean, Private_Dirty,
    Referenced, Anonymous, AnonHugePages, Shared_Hugetlb, Private_Hugetlb, Swap,
    SwapPss, KernelPageSize, MMUPageSize, Locked

    Be advised -- some regular expressions may give misleading results.
    For example, '(Size|Rss)' will doubly-count the memory currently resident
    in RAM.

    ''', formatter_class=RawTextHelpFormatter)
    parser.add_argument('--tot', dest='ramtot', action='store_true',
                        help='Print out total ram usage')
    parser.add_argument('--swap', action='store_true',
                        help='Show total swap usage')
    parser.add_argument('--program', dest='one_program', default=None,
                        help='Program name to get memory usage of\n\
                        (shows memory of all instances)',
                        metavar='P-name')
    parser.add_argument('--comb', nargs='*', metavar='Mem-Type',
                        help='Multiple types of memory to look at\n\
                        combine different processes into one entry.')
    parser.add_argument('--all_mem', nargs='*', metavar='Mem-Type',
                        help='Multiple types of memory to look at\n\
                        keep multiple instances of programs separate.')
    parser.add_argument('--no-capitalize', action='store_false',
                        default=True, dest='should_capitalize',
                        help='Disable automatic capitalisation of regular'
                        ' expressions')
    args = parser.parse_args()
    # In case given options like pss and sWaP
    if args.should_capitalize:
        if args.comb:
            args.comb[:] = [val.capitalize() for val in args.comb]
        if args.all_mem:
            args.all_mem[:] = [val.capitalize() for val in args.all_mem]
    # Don't like this method of giving defaults - but allows to
    # distinguish between option given with no arguments and option not
    # given
    if args.comb == []:
        args.comb = ['Pss']
    if args.all_mem == []:
        args.all_mem = ['Pss']
    altopts = any([args.all_mem, args.comb, args.one_program, args.swap])
    # If have alternative options AND ramtotal - Print a title
    if altopts and args.ramtot:
        print('Total Ram used:  ')
    # If don't have alternative options OR have ramtotal - Print ramtotal
    if not altopts or args.ramtot:
        print(ram_used())
    if args.one_program:
        print('\n{}:'.format(args.one_program))
        print_nice(one_program(args.one_program))
        print('')
    if args.comb:
        for mtype in args.comb:
            print('\nAll program names  -', mtype, end=' :\n')
            print_nice(all_comb(mtype))
            print('')
    if args.all_mem:
        for mtype in args.all_mem:
            print('\nAll programs -', mtype, end='  :\n\n')
            print_nice(all_mem(mtype))
            print('')
    if args.swap:
        print('{}%'.format(swap_used()))
