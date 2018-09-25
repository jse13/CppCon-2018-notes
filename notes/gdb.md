# GDB and other Linux Tools

## GDB
- <C-x-a> for TUI mode
- `shell`: run shell command in GDB

Best to keep `.gdbinit` simple, weird stuff can cause issues; good `.gdbinit` settings:
```
set history save on // Saves commands that have been entered
set print pretty on
set pagination off
set confirm off
```

GDB is build on ptrace and signals.
- When a program being traced recieves a signal, it's suspended and the tracer is notified

`handle SIGINT stop print pass` to change the way SIGINT is handled by GDB.
    - SIGINT generated when you press <C-c>, SIGTRAP when it hits a breakpoint.

- `watch foo`: stop when foo is modified; when it goes out of scope it'll stop watching
- `watch -l foo`: watch location of foo; won't stop watching when going out of scope
- `rwatch foo`: stop when foo is read
- `watch foo thread 3`: stop when thread 3 modifies foo
- `watch foo if foo > 10`: stop when foo > 10.
- `thread apply all backtrace full`: provide backtrace of every thread in the process
    - `thread apply 1-4 print $sp`: print stack pointer for threads 1-4.

dynamic printf: add printf's in the code without having to recompile.
- Ex. `dprintf mutex_lock, "m is %p m->magic is %u\n", m, m->magic`
- Control how they happen:
    - `set dprintf-style gdb|call|agent`
    - `set dprintf-function fprintf`

Calling inferior functions:
- `call foo()` will call foo in the current interior

Multiprocess debugging
- `set detach-on-fork off`: by default GDB detaches on a fork; this disables that

- `tbreak`: temporary breakpoint
- `rbreak`: regex breakpoint
- `command`: list of commands to be executed when breakpoint hit
- `record`: useful for debugging non-deterministic bugs that only happen once in awhile
- `silent`: special command to suppress output on breakpoint hit
- save breakpoints|history`: save info from current session to a file


## Valgrind
Valgrind is a platform with many tools available. Memcheck is the default and the most used/known. There is also
`cachegrind`, `callgrind`, `helgrind`, etc.

Can be used with GDB: `valgrind --vgdb=full -vgdb-error 0 ./a.out`

## ftrace
Fast way to trace various kernel functions..

## strace
- Trace all the syscalls a program makes

### perf trace
- faster than strace
- Needs privileges

## ltrace
- Trace all library calls a program makes