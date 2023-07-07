
  

# Libasm Project

  

## Introduction

  

The aim of this project is to get familiar with assembly language, while recoding glibc and libft functions in assembly (NASM 64 Bits), we will use the intel syntax. *(libasm version 5, intra.42.fr)*.

  

**<u>Glibc replicate prototypes :</u>**

  

```c
size_t	ft_strlen(char* str);
char*	ft_strcpy(char* dst, char* src);
ssize_t	ft_write(int fd, const void*, size_t);
ssize_t	ft_read(int fd, void*, size_t);
int	ft_strcmp(const char* s1, const char* s2);
char*	ft_strdup(const char* s);
```

  

**<u>Libft replicate prototypes :</u>**

  

```c
int	ft_list_size(t_list *begin_list);
void	ft_list_sort(t_list **begin_list,  int  (*cmp)());
int	ft_atoi_base(char *str, char *base);
void	ft_list_push_front(t_list **begin_list, void *data);
void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
```

  

There are severals conventions about the register manipulation, syntax and other stuff that depends on the architecture of your computer, especially the CPU. Therefore it is essential to use these manuals as a reference.

  

>  *System V Application Binary Interface AMD64 Architecture Processor Supplement* https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf

>  *Combined Volume Set of Intel® 64 and IA-32 Architectures Software Developer’s Manuals* https://cdrdv2.intel.com/v1/dl/getContent/671200

  

To make this project we assume a x86-64 architecture that refers to a 64 bits computation capability.
First of all, we have to understand all this stuff, so let's keep a little diving.

When we write code to compile it, what happens ?

  

```c
/* main.c */

int
main(void)

{
	int x =  0x01;
	x = x <<  0x08;
	return  0x00;
}
```

  

![alt text](https://cdn.nerdyelectronics.com/wp-content/uploads/2017/07/GCC_CompilationProcess.png  "Title")

  

As you can see, there are many steps before getting the executable.

  

###  <u> PHASE 1: Pre-Processing </u>

  

This step mainly consists of preparing the file before being compiled, a C Preprocessor is a text substitution tool (The C Preprocessor is ***not a part of the compiler***, but is a separate step in the compilation process.), it performs various operations listed below.

  

1) Comments Removal `/* comment */`
2) Macros Expansion `#define RANDOM 10`
3) File inclusion `#include <stdio.h>`
4) Conditional Compilation `#ifdef #else #endif`

  

To visualize the result of all theses operation you can the following command, it tells GCC to stop after the preprocessing stage :

  

``` sh
gcc  -E  main.c
```

  

###  <u> PHASE 2: Compilation </u>

  

This step aims to convert human-readable code into low-level machine code (Assembly). In this specific case, the human-readable code refers to the preprocessing done in the previous step.

First of all, what is the assembly language & what is the assembler ?

- ***Assembly language*** is a low-level programming language that uses mnemonic codes to represent individual instructions that can be executed directly by the computer's CPU.

- An ***assembler*** is a type of software that is used to convert assembly language code into machine language code. (**PHASE 4**)

  

In our case, the C program will give this in assembler :

  

``` c
section .text
	global main

main:
	push rbp
	mov rbp, rsp
	mov DWORD [rbp -  0x04], 0x01
	sal DWORD [rbp -  0x04], 0x08
	mov eax,  0x00
	pop rbp
	ret
```

This code will be processed by the ***assembler*** to translate it into machine code.

By the way during this project we will mainly deal with writing GLIBC programs in assembler, therefore we will develop at this layer.

  

###  <u> PHASE 3: Assemble </u>

  

Assembling is the process of translating low-level programming code, often written in assembly language, into machine code. Assembly language is a low-level programming language that is closely related to the architecture of a specific computer's central processing unit (CPU).

  

###  <u> PHASE 4: Linking </u>

  

Linking is the process of collecting and combining various pieces of code and data into a single file that can be loaded (copied) into memory and executed.

  

## Dissecting to assemble

  

Before understanding the mnemonic codes / assembly files, we will be interested in the sections, they represent the data segments.

  

![alt text](https://static.tumblr.com/gltvynn/tHIobhrb5/memlayout.jpg  "Title")

  

###  <u>**section**</u>

**<u>.stack</u>**: The stack is used to store local variables, function parameters, and context information for each function call. The stack gives segments themselves which are precisely called ***stack-frames***.
A ***stack-frame*** is related to a scope of the calling function, it contains the scope of this one, on the over hand, the stack have the global scope.

**<u>.heap</u>**: The heap is used to dynamically allocate memory during program execution.

**<u>.data</u>**: The data section contains initialized data that will be used in the flow of your program.

**<u>.bss</u>**: The purpose of the BSS section is to hold uninitialized data that is initialized to zero at program startup. This is useful for variables that don't have an initial value or are initialized dynamically during program execution.

**<u>.text</u>**: The text section is ***used for keeping the actual code***. This section must begin with the declaration global _start (in our case it will be _hello_world), which tells the kernel where the program execution begins.

  
  

###  <u>**label**</u>

A **label** can be placed at the beginning of a statement. During assembly, the label is assigned the current value of the active location counter and serves as an instruction operand. There are two types of lables: **symbolic** and **numeric**.

  

**<u>symbolic label:</u>** A **symbolic** label consists of an **identifier** (or **symbol**) followed by a colon (:) (ASCII 0x3A). Symbolic labels must be defined only once. Symbolic labels have **global** scope and appear in the object file's symbol table. Symbolic labels with identifiers beginning with a period (.) (ASCII 0x2E) are considered to have **local** scope and are not included in the object file's symbol table.

  

**<u>numeric label:</u>** A **numeric** label consists of a single digit in the range zero (0) through nine (9) followed by a colon (:). Numeric labels are used only for local reference and are not included in the object file's symbol table. Numeric labels have limited scope and can be redefined repeatedly.

  

###  <u>**assembly instructions**</u>

  

An assembler instruction is a low-level command or operation that can be executed by a processor. It is usually represented by a sequence of human-understandable mnemonic symbols or codes that correspond to a specific processor operation.

  

Here is an example assembly instruction that I extracted from our example:

```c
mov rax,  0x01
```

This assembly instruction is used to move the value 42 in the rax register of a processor. The mnemonic "**mov**" indicates the move operation, "rax" represents the destination register, and "**0x01**" is the value to be moved.

###  <u> mnemonic codes / assembly file </u>

Now that we have examined some nomenclatures, we can make the link with the assembler file below.

```c
section .data

msg db "Hello world",  0xA

len equ $ - msg

section .bss
	buffer resb 0x2A

section .text
	global hello_world

hello_world:
	push rbp
	mov rbp, rsp
	mov rax, 0x01
	mov rdx, len
	mov rsi, msg
	mov rdi, 0x01
	syscall

.return
	mov rsp, rbp
	pop rbp
	ret
```

  

`global hello_world` basically means that the symbol should be visible to the linker because other object files will use it. Without it, the symbol `hello_world` is considered local to the object file it's assembled to, and will not appear after the assembly file is assembled.

So when i call the function hello_world(), we will start from the "**hello_world label:**".


You can see within hello_world what is called a ***prologue***:

``` 
push 	rbp
mov 	rbp, rsp
```
  

And in the local label .return the ***epilogue***:

```
mov	rsp, rbp
; or
sub	rsp, ALLOCATED_BYTES

pop 	rbp
```
  

To understand what a prologue & epilogue is, one must understand the usefulness of the registers in question.

  

**RBP = BASE POINTER** -> It is used to point the base of a stack, this can be useful for several reasons, such as using a reference to access local content (variables, function parameters).

**RSP = STACK POINTER** -> This register points to the end of the lastest element allocated on the stack, during a program it will be incremented as well as decremented.

![alt text](https://eli.thegreenplace.net/images/2011/08/x64_frame_nonleaf.png  "Title")

Basically, see the rbp, as the beginning of the scope of a function & a reference, this reference which is in fact an address in memory, will be used to access local data & the rsp as the witness of the last element allocated on the stack.

When I push on rbp, on the stack, I save the old rbp, because at the entrance of the function, it still contains the old base pointer of the calling function.

As stated, RSP always points to the last allocated element on the stack, it is said to point to the top of the stack, don't get confused, the stack grows downwards, so the top of a stack frame of 0 a -32 will be -32.
So when I push rbp onto the stack, I modify rsp accordingly.
Let's say that initially I'm at 0, if I push rbp, I'm at -8, because an address is worth 8 bytes.

Tell yourself that a push instruction decrements the stack pointer by the number of bytes I want to store on the stack, in our case, by pushing rbp, we decrement by 8 bytes before assigning the new data which is the base pointer.


SO :
```c
push rbp

; is the same as

sub rsp, 8
mov QWORD [rsp], rbp
```
QWORD indicates this operand describes an address of quad-word size, in Intel's x86 family of processors this means 8 bytes.

Then once rbp is pushed the stack, we must indicate a new value to rbp which serves as our base pointer, we will give the value of rsp, since we have not allocated local variables or other spaces which are useful in our stack frame, rsp currently points to the beginning of the stack frame.

This is what we call the prologue, this is what we use to initialize the beginning of our stack frame.

Then we have what is called the epilogue, it simply serves to revert these processes.

Then we can observe this part of the code :

```c
mov rax, 0x01
mov rdx, len
mov rsi, msg
mov rdi, 0x01
syscall
```

The System V Application Binary Interface convention stipulates that to perform a syscall we must inject its identifier into the rax register, then rdi serves as the first argument rsi of the second and rdx of the third.

Here we will perform a sys_write, rdi contains the standard output, rsi the contents of the string, and rdx the length.
So this program is a hello world, indeed python is more efficient for this kind of operations. x)

  ## ..:: CHEATSHEET ::..

  https://web.stanford.edu/class/cs107/resources/x86-64-reference.pdf

### System Call Inputs by Register

| argument | registers |
|--|--|
|ID | rax |
|1 | rdi |
|2 | rsi |
|3 | rdx |
|4 | r10 |
|5 | r8 |
|6 | r9 |

  

### System Call List

|syscall| ID | arg1 | arg2 | arg3| arg4| arg5 | arg 6
|--|--|--|--|--|--|--|--|
| sys_read | 0 | #filedescriptor | $buffer | #count | | | |
| sys_write | 1 | #filedescriptor | $buffer | #count | | | |
| sys_open | 2 | $filename | #flags | #mode | | | |
| sys_close | 3 | #filedescriptor | | | | | |
