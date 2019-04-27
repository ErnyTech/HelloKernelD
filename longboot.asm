global longboot
extern _d_run_main

section .text
bits 64
longboot:
    mov ax, 0
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    call _d_run_main
    hlt
