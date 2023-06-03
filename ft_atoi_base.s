section .text
    global  ft_atoi_base

ft_in_base:
    xor     r11, r11
    mov     rax, rsi

.ft_in_base_loop:
    mov     cl, BYTE [rax + r11]
    test    cl, cl
    jz      .ft_in_base_return_1
    cmp     dil, cl
    je      .ft_in_base_return_2
    inc     r11
    jmp     .ft_in_base_loop

.ft_in_base_return_1:
    mov     rax, -0x01
    ret

.ft_in_base_return_2:
    mov     rax, r11
    ret

ft_base_len:
    xor     r11, r11
    mov     rax, rdi

.ft_base_len_loop:
    mov     cl, BYTE [rax + r11]
    test    cl, cl
    jz      .ft_base_len_return_2
    cmp     cl, 0x2B ; PLUS
    je      .ft_base_len_return_1
    cmp     cl, 0x2D ; MINUS
    je      .ft_base_len_return_1
    cmp     cl, 0x20 ; SPACE
    je      .ft_base_len_return_1
    cmp     cl, 0x09 ; HT
    je      .ft_base_len_return_1
    cmp     cl, 0x0A ; NL
    je      .ft_base_len_return_1
    cmp     cl, 0x0B ; VT
    je      .ft_base_len_return_1
    cmp     cl, 0x0C ; NP
    je      .ft_base_len_return_1
    cmp     cl, 0x0D ; CR
    je      .ft_base_len_return_1
    push    rax
    push    r11
    lea     rsi, [rax + r11 + 0x01]
    mov     dil, cl
    call    ft_in_base
    cmp     rax, 0x00
    pop     r11
    pop     rax
    jge     .ft_base_len_return_1
    inc     r11
    jmp     .ft_base_len_loop

.ft_base_len_return_1:
    mov     rax, 0x00
    ret

.ft_base_len_return_2:
    mov     rax, r11
    ret

ft_atoi_base:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x20
    mov     QWORD [rbp - 0x08], rdi
    mov     QWORD [rbp - 0x10], rsi
    mov     DWORD [rbp - 0x14], 0x00
    mov     DWORD [rbp - 0x18], 0x00
    mov     DWORD [rbp - 0x1C], 0x00
    mov     rdi, QWORD [rbp - 0x10]
    call    ft_base_len
    cmp     rax, 0x02
    jl      .return
    mov     DWORD [rbp - 0x14], eax
    mov     rax, QWORD [rbp - 0x08]
    jmp     .ft_atoi_base_loop_1

.continue_loop_1:
    inc rax

.ft_atoi_base_loop_1:
    mov     cl, BYTE [rax]
    cmp     cl, 0x09 ; HT
    je      .continue_loop_1
    cmp     cl, 0x0A ; NL
    je      .continue_loop_1
    cmp     cl, 0x0B ; VT
    je      .continue_loop_1
    cmp     cl, 0x0C ; NP
    je      .continue_loop_1
    cmp     cl, 0x0D ; CR
    je      .continue_loop_1
    cmp     cl, 0x20 ; SPACE
    je      .continue_loop_1

.ft_atoi_base_loop_2:
    cmp     BYTE [rax], 0x2D
    je      .negative_toggle
    cmp     BYTE [rax], 0x2B
    je      .continue_loop_2
    jmp     .ft_atoi_base_loop_3

.negative_toggle:
    mov     r11d, [rbp - 0x18]
    mov     DWORD [rbp - 0x18], 0x01
    sub     [rbp - 0x18], r11d

.continue_loop_2:
    inc     rax
    jmp     .ft_atoi_base_loop_2

.ft_atoi_base_loop_3:
    mov     rsi, [rbp - 0x10]
    mov     rdi, [rax]
    push    rax
    call    ft_in_base
    cmp     rax, 0x00
    mov     r8d, eax
    pop     rax
    jnge    .negative_convert
    mov     r11d, DWORD [rbp - 0x14]
    imul    r11d, DWORD [rbp - 0x1C]
    add     r11d, r8d
    mov     DWORD [rbp - 0x1C], r11d
    inc     rax
    jmp     .ft_atoi_base_loop_3

.negative_convert:
    cmp     DWORD [rbp - 0x18], 0x00
    je      .return
    neg     DWORD [rbp - 0x1C]

.return:
    mov     eax, DWORD [rbp - 0x1C]
    add     rsp, 0x20
    pop     rbp
    ret