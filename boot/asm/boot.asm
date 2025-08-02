[BITS 16]
[ORG 0x7C00]

_start:
    mov si, welcome

print:
    mov al, [si]
    cmp al, 0
    je exit

    mov ah, 0xE
    mov bh, 0
    mov bl, 0xF
    int 10h

    inc si
    jmp print

exit:
    jmp $

welcome: db "Welcome to the M5OS !!", 10, 0

times 510 - ($ - $$) db 0
dw 0xAA55
