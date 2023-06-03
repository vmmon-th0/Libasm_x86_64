section .text
    global  ft_list_remove_if
    extern  free

.swap_1:
    mov     r10, [rbp - 0x30]
    mov     r11, [r10 + 0x08]
    cmp     QWORD [rbp - 0x08], 0x00
    jz      .begin_case
    mov     rax, [rbp - 0x08]
    mov     [rax + 0x08], r11
    jmp     .swap_2

.begin_case:
    mov     rax, [rbp - 0x10]
    mov     [rax], r11

.swap_2:
    mov     rdi, [r10]
    call    [rbp - 0x28]
    mov     rdi, r10
    call    free
    cmp     QWORD [rbp - 0x08], 0x00
    jz      .begin_case2
    mov     rax, [rbp - 0x08]
    mov     rax, [rax + 0x08]
    mov     [rbp - 0x30], rax
    jmp     .swap_3

.begin_case2:
    mov     rax, [rbp - 0x10]
    mov     r10, [rax]
    mov     [rbp - 0x30], r10

.swap_3:
    jmp     .continue_loop

ft_list_remove_if:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x30
    cmp     rdi, 0x00
    jz      .return
    cmp     QWORD [rdi], 0x00
    jz      .return
    mov     QWORD [rbp - 0x08], 0x00
    mov     [rbp - 0x10], rdi
    mov     [rbp - 0x18], rsi
    mov     [rbp - 0x20], rdx
    mov     [rbp - 0x28], rcx
    mov     rax, [rdi]
    mov     [rbp - 0x30], rax

.ft_list_remove_if_loop:
    cmp     QWORD [rbp - 0x30], 0x00
    jz      .return
    mov     rsi, [rbp - 0x18]
    mov     rax, [rbp - 0x30]
    mov     rdi, [rax]
    call    [rbp - 0x20]
    cmp     rax, 0x00
    jz      .swap_1
    mov     rax, [rbp - 0x30]
    mov     QWORD [rbp - 0x08], rax
    mov     rax, [rbp - 0x30]
    mov     rax, [rax + 0x08]
    mov     [rbp - 0x30], rax

.continue_loop:
    jmp     .ft_list_remove_if_loop

.return:
    add     rsp, 0x30
    pop     rbp
    xor     rax, rax
    ret