extern int call_exit(int);
extern int call_close(int);
extern int call_execve(int, int, int);
extern int call_fork();
extern int call_fstat(int, int);
extern int call_getpid();
extern int call_isatty(int);
extern int call_kill(int, int);
extern int call_link(int, int);
extern int call_lseek(int, int, int);
extern int call_open(int, int);
extern int call_read(int, int, int);
extern int call_write(int, int, int);
extern int call_unlink(int);
extern int call_wait(int);
