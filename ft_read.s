SYS_READ equ 0x00

section .text
    global  ft_read
    extern __errno_location

ft_read:
    push    rbp
    mov     rbp, rsp
    mov     rax, SYS_READ
    syscall
    cmp     rax, 0x00
    jl      .ft_read_error
    pop     rbp
    ret

.ft_read_error:
    neg     rax
    mov     r11, rax
    call    __errno_location
    mov     [rax], r11
    mov     rax, -0x01
    pop     rbp
    ret