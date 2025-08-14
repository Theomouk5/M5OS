[BITS 16]
[ORG 0x8000]

CODE_SEG equ GDT_code - GDT_start
DATA_SEG equ GDT_data - GDT_start

cli

in al, 0x92
or al, 0b00000010
out 0x92, al

lgdt [GDT_descriptor]
mov eax, cr0
or eax, 1
mov cr0, eax
jmp CODE_SEG:start_protected_mode

jmp $

%include "bootloader/print.asm"

GDT_start:
    GDT_null:
        dd 0
        dd 0
    GDT_code:
        dw 0xFFFF
        dw 0
        db 0
        db 0b10011011
        db 0b11001111
        db 0
    GDT_data:
        dw 0xFFFF
        dw 0
        db 0
        db 0b10010011
        db 0b11001111
        db 0
GDT_end:

GDT_descriptor:
    dw GDT_end - GDT_start - 1
    dd GDT_start

[BITS 32]
start_protected_mode:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov byte[0xB8000], 'N'
    mov byte[0xB8001], 0x0B

    jmp $
