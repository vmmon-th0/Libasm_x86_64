section .text
    global  ft_list_push_front
    extern  malloc

ft_list_push_front:
    push    rbp
    mov     rbp, rsp
    push    rdi
    push    rsi
    mov     rdi, 0x10
    call    malloc
    pop     rsi
    pop     rdi
    cmp     rax, 0x00
    je      return

push_front:
    mov     [rax], rsi
    mov     r11, [rdi]
    mov     [rax + 0x08], r11
    mov     [rdi], rax

return:
    pop     rbp
    ret