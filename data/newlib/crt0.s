.arm
.extern main
.extern call_exit
.global _start

_start:
    bl main
    bl call_exit
    b .
