global start
extern longboot
    
section .bss
align 4096
pml4:
    resb 4096
pdp:
    resb 4096
pd:
    resb 4096
stack_bottom:
    resb 64
stack_top:

section .rodata
gdt64:
    dq 0
    dq (1<<43) | (1<<44) | (1<<47) | (1<<53) 
.code: equ $ - gdt64
    dq (1<<43) | (1<<44) | (1<<47) | (1<<53) ;
.pointer:
    dw $ - gdt64 - 1
    dq gdt64
    
section .text
bits 32
set_up_page_tables:
    mov eax, pdp
    or eax, 0b11
    mov [pml4], eax
    mov eax, pd
    or eax, 0b11
    mov [pdp], eax
    mov ecx, 0

.map_pd:
    mov eax, 0x200000
    mul ecx
    or eax, 0b10000011
    mov [pd + ecx * 8], eax
    inc ecx
    cmp ecx, 512
    jne .map_pd
    ret
    mov ecx, 0         ; counter variable

.map_pd_table:
    mov eax, 0x200000
    mul ecx
    or eax, 0b10000011
    mov [p2_table + ecx * 8],
    inc ecx
    cmp ecx, 512
    jne .map_p2_table
    ret
    
enable_paging:
    mov eax, pml4
    mov cr3, eax
    mov eax, cr4
    or eax, 1 << 5
    mov cr4, eax
    mov ecx, 0xC0000080
    rdmsr
    or eax, 1 << 8
    wrmsr
    mov eax, cr0
    or eax, 1 << 31
    mov cr0, eax
    ret
    
start:
    mov esp, stack_top
    call set_up_page_tables
    call enable_paging 
    lgdt [gdt64.pointer]
    jmp gdt64.code:longboot

