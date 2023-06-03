section .text
    global  ft_strdup
    extern  __errno_location, malloc, ft_strlen, ft_strcpy

ft_strdup:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x08
    push    rdi
    call    ft_strlen
    add     rax, 0x01
    mov     rdi, rax
    call    malloc
    cmp     rax, 0x00
    je      .ft_strdup_error
    pop     rsi
    mov     rdi, rax
    call    ft_strcpy
    add     rsp, 0x08
    pop     rbp
    ret

.ft_strdup_error:
    neg     rax
    mov     rdi, rax
    call    __errno_location
    mov     [rax], rdi
    mov     rax, -0x01
    add     rsp, 0x08
    pop     rbp
    ret
