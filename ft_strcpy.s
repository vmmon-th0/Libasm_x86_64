section .text
    global  ft_strcpy
    extern  ft_strlen

ft_memcpy:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x20
    xor     rax, rax
    cmp     rdi, 0x00
    je      .ft_memcpy_ret
    cmp     rsi, 0x00
    je      .ft_memcpy_ret
    mov     QWORD [rbp - 0x10], rdi
    mov     QWORD [rbp - 0x18], rsi
    mov     QWORD [rbp - 0x20], rdi
    mov     rdi, rsi
    call    ft_strlen
    add     rax, 0x01
    mov     QWORD [rbp - 0x08], rax

.eight_bytes_loop:
    mov     rax, QWORD [rbp - 0x08]
    cmp     rax, 0x08
    jnge    .four_bytes_loop
    mov     rax, QWORD [rbp - 0x18]
    mov     rdx, QWORD [rax]
    mov     rax, QWORD [rbp - 0x10]
    mov     QWORD [rax], rdx
    sub     QWORD [rbp - 0x08], 0x08
    add     QWORD [rbp - 0x10], 0x08
    add     QWORD [rbp - 0x18], 0x08
    jmp     .eight_bytes_loop

.four_bytes_loop:
    mov     rax, QWORD [rbp - 0x08]
    cmp     rax, 0x04
    jnge    .one_byte_loop
    mov     rax, QWORD [rbp - 0x18]
    mov     edx, DWORD [rax]
    mov     rax, QWORD [rbp - 0x10]
    mov     DWORD [rax], edx
    sub     QWORD [rbp - 0x08], 0x04
    add     QWORD [rbp - 0x10], 0x04
    add     QWORD [rbp - 0x18], 0x04
    jmp     .four_bytes_loop

.one_byte_loop:
    mov     rax, QWORD [rbp - 0x08]
    test    rax, rax
    jz      .ft_memcpy_ret
    mov     rax, QWORD [rbp - 0x18]
    movzx   edx, BYTE [rax]
    mov     rax, QWORD [rbp - 0x10]
    mov     BYTE [rax], dl
    sub     QWORD [rbp - 0x08], 0x01
    add     QWORD [rbp - 0x10], 0x01
    add     QWORD [rbp - 0x18], 0x01
    jmp     .one_byte_loop

.ft_memcpy_ret:
    mov     rax, QWORD [rbp - 0x20]
    add     rsp, 0x20
    pop     rbp
    ret

ft_strcpy:
    push    rbp
    mov     rbp, rsp
    call    ft_memcpy

.return:
    pop     rbp
    ret
