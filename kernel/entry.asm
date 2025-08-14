[BITS 32]

extern k_main

section .text

_start:
    call k_main
    jmp $
