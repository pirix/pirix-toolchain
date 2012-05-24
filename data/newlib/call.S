.arm

#include "syscalls.h"

.global call_exit
call_exit:
    swi #SYS_EXIT
    bx lr

.global call_execve
call_execve:
    swi #SYS_EXECVE
    bx lr

.global call_close
call_close:
    swi #SYS_CLOSE
    bx lr

.global call_fork
call_fork:
    swi #SYS_FORK
    bx lr

.global call_fstat
call_fstat:
    swi #SYS_FSTAT
    bx lr

.global call_getpid
call_getpid:
    swi #SYS_GETPID
    bx lr

.global call_isatty
call_isatty:
    swi #SYS_GETPID
    bx lr

.global call_kill
call_kill:
    swi #SYS_KILL
    bx lr

.global call_link
call_link:
    swi #SYS_LINK
    bx lr

.global call_lseek
call_lseek:
    swi #SYS_LSEEK
    bx lr

.global call_open
call_open:
    swi #SYS_OPEN
    bx lr

.global call_read
call_read:
    swi #SYS_READ
    bx lr

.global call_write
call_write:
    swi #SYS_WRITE
    bx lr

.global call_unlink
call_unlink:
    swi #SYS_UNLINK
    bx lr

.global call_wait
call_wait:
    swi #SYS_WAIT
    bx lr
