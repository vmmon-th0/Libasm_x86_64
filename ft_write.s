SYS_WRITE equ 0x01

section .text
    extern __errno_location
    global  ft_write

ft_write:
    push    rbp
    mov     rbp, rsp
    mov     rax, SYS_WRITE
    syscall
    cmp     rax, 0x00
    jl      .ft_write_error
    pop     rbp
    ret

.ft_write_error:
    neg     rax
    mov     r11, rax
    call    __errno_location
    mov     [rax], r11
    mov     rax, -0x01
    pop     rbp
    ret