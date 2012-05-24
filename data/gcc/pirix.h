#undef TARGET_OS_CPP_BUILTINS
#define TARGET_OS_CPP_BUILTINS()        \
    do {                                \
      builtin_define_std ("pirix");     \
      builtin_define_std ("unix");      \
      builtin_assert ("system=pirix");  \
      builtin_assert ("system=unix");   \
    } while(0);

#undef TARGET_VERSION
#define TARGET_VERSION fprintf(stderr, " (arm pirix)");
