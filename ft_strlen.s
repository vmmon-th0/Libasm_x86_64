section .text
    global  ft_strlen

ft_strlen:
    push    rbp
    mov     rbp, rsp
    xor     rax, rax

.fr_strlen_loop:
    cmp     BYTE [rdi + rax], 0x00
    je      return
    inc     rax
    jmp     .fr_strlen_loop

return:
    pop     rbp
    ret
