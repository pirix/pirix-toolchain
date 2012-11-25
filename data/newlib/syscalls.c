#include <sys/stat.h>
#include <sys/types.h>
#include <sys/fcntl.h>
#include <sys/times.h>
#include <sys/errno.h>
#include <sys/time.h>
#include <stdio.h>
#include "syscalls.h"
#include "call.h"

#undef errno
extern int errno;

char *__env[1] = { 0 };
char **environ = __env;

void _exit(int rc) {
    call_exit(rc);
}

int _close(int file) {
    return call_close(file);
}

int _execve(char *name, char **argv, char **env) {
    return call_execve((int)name, (int)argv, (int)env);
}

int _fork() {
    return call_fork();
}

int _fstat(int file, struct stat* st) {
    st->st_mode = S_IFCHR;
    return call_fstat(file, (int)st);
}

int _getpid() {
    return call_getpid();
}

int _isatty(int file) {
    return call_isatty(file);
}

int _kill(int pid, int sig) {
    return call_kill(pid, sig);
}

int _link(char* old, char* new) {
    return call_link((int)old, (int)new);
}

int _lseek(int file, int ptr, int dir) {
    return call_lseek(file, ptr, dir);
}

int _open(const char *name, int flags, ...) {
    return call_open((int)name, flags);
}

caddr_t _sbrk(int incr) {
    return (caddr_t)call_sbrk(incr);
}

int _stat(const char *name, struct stat *st) {
    st->st_mode = S_IFCHR;
    return 0;
}

int _symlink(const char* path1, const char* path2) {
    errno = ENOSYS;
    return -1;
}

clock_t _times(struct tms* buf) {
    errno = ENOSYS;
    return -1;
}

int _gettimeofday(struct timeval* tp, struct timezone* tzp) {
    if(tp) {
        tp->tv_sec = 10;
        tp->tv_usec = 0;
    }
    if (tzp) {
        tzp->tz_minuteswest = 0;
        tzp->tz_dsttime = 0;
    }
    return 0;
}

int _unlink(char* name) {
    return call_unlink((int)name);
}

int _wait(int* status) {
    return call_wait((int)status);
}

int _write(int file, char* buf, int len) {
    return call_write(file, (int)buf, (int)len);
}

int _read(int file, char* buf, int len) {
    return call_read(file, (int)buf, (int)len);
}
