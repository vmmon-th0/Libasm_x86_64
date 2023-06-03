section .text
    global  ft_list_sort

.swap:
    mov     r8, [r14]
    mov     r9, [r14 + 0x08]
    mov     r10, [r9]
    mov     [r14], r10
    mov     [r9], r8
    jmp     .continue_loop

ft_list_sort:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x08
    push    r12
    push    r13
    push    r14
    push    r15
    push    rbx
    mov     rbx, rsi
    mov     r12, [rdi]
    mov     r13, r12

.ft_list_sort_loop:
    cmp     r13, 0x00
    je      .return
    mov     r14, r12

.ft_list_nested_loop:
    cmp     QWORD [r14 + 0x08], 0x00
    je      .ft_list_loop_done
    mov     r15, [r14 + 0x08]
    mov     rsi, QWORD [r15]
    mov     rdi, QWORD [r14]
    call    rbx
    cmp     rax, 0x00
    jg      .swap

.continue_loop:
    mov     r14, [r14 + 0x08]
    jmp     .ft_list_nested_loop

.ft_list_loop_done:
    mov     r13, [r13 + 0x08]
    jmp     .ft_list_sort_loop

.return:
    pop     rbx
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    add     rsp, 0x08
    pop     rbp
    ret
