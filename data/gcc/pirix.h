#define GNU_USER_TARGET_OS_CPP_BUILTINS()       \
    do {                                        \
        builtin_define_std ("pirix");           \
        builtin_define_std ("unix");            \
        builtin_assert ("system=pirix");        \
        builtin_assert ("system=unix");         \
    } while(0);

#undef GNU_USER_DYNAMIC_LINKER
#define GNU_USER_DYNAMIC_LINKER "/lib/ld.so"

#undef CPP_SPEC
#define CPP_SPEC "%{posix:-D_POSIX_SOURCE}"
