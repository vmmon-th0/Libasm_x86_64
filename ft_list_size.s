section .text
	global	ft_list_size

ft_list_size:
    push    rbp
    mov     rbp, rsp
    xor     rax, rax

.ft_list_size_loop:
    cmp     rdi, 0x00
    je      return
    inc     rax
    mov     rdi, [rdi + 0x08]
    jmp     .ft_list_size_loop

return:
    pop     rbp
    ret