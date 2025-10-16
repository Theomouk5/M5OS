[BITS 32]
extern k_main

section .text
    global _start

_start:
    call k_main
    jmp $
