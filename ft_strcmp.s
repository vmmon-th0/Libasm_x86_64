section .text
    global  ft_strcmp

ft_strcmp:
    push    rbp
    mov     rbp, rsp
    xor     rax, rax

.ft_strcmp_loop:
    mov     r10b, BYTE [rdi + rax]
    mov     r11b, BYTE [rsi + rax]
    inc     rax
    cmp     r10b, 0x00
    je      .return
    cmp     r10b, r11b
    je      .ft_strcmp_loop
    jg      .great_case
    jl      .less_case

.great_case:
    mov     rax, 0x01
    pop     rbp
    ret

.less_case:
    mov     rax, -0x01
    pop     rbp
    ret

.return:
    cmp     r11b, 0x00
    jne     .less_case
    xor     rax, rax
    pop     rbp
    ret
