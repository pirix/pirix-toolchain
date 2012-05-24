.arm
.extern main
.extern exit
.global _start

_start:
    ldr r0, [r13, #4]
    ldr r1, [r13, #8]
    push {r1, r0}
    bl main
    add r14, r14, #8
    bl exit
    bl .
