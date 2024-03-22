
# My asm Journey

## Introduction

### Premessa

Al momento sto ancora studiando assembly e tutto ciò che lo riguarda. Pertanto non prendete nulla come oro colato e se avete qualche dubbio fate delle ricerche sul magico mondo dell'internet. E nel possibilissimo caso in cui io abbia detto una cazzata, fatemelo sapere.

### Overview

Assembly is a low-level programming language in which there is a very strong, but often not one-to-one, correspondence between the language and the architecture’s machine code instructions.
E, secondo me, non lo utilizzerete mai per scrivere alcun tipo di programma, però sicuramente potrà aiutarvi a capire meglio come funziona un processore e, di conseguenza, un computer in generale.

### Requirements

Per poter proseguire con questa guida, se così vogliamo chiamarla, vi consiglio di lavorare su un ambiente il più possibile simile al mio, quindi:

- Sistema
    - [ ] Kernel: Linux
    - [ ] Processore: x86_64
- Software
    - [ ] [NASM](https://www.nasm.us/)
    - [ ] [GCC](https://gcc.gnu.org/)


## Assembly language

### Hello World!

This is an example of a 'Hello, World!' in asm:
```
section .data
	text db "Hello, World!",10

section .text
	global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, text
	mov rdx, 14
	syscall

	mov rax, 60
	mov rdi, 42
	syscall
```
Now you're probably wondering what the heck all of this means. Let me explain.

- With this `text db "Hello, World!",10` we're going to allocate 14 bytes of memory and fill it with the string "Hello, World!".

- Then, we declare `_start` global so it can be called from everywhere.

- `_start:` is a label and is also our main function.

- The `mov rax, 1` instruction allows you to 'move' *1* inside register **rax**, it's like `a = 1` in any high-level language.

- Lastly, we make a [syscall](#system-calls).

If you want to run this code you have to compile your .s file like this:
`nasm -f elf64 hello.s -o hello.o`
And then you have to link it, like this:
`ld hello.o -o hello`
Now you have just to run it, do this:
`./hello`

You have successfully run your first asm program, congrats.

### System Calls

I'm not gonna explain you what is a system call and how it works in detail, for this exists the internet. But, I'm just gonna say that you, as a programmer and a user, cannot directly perform some actions, like writing on the standard output. Infact, with the first syscall we asked the OS to print on the terminal our string "Hello, World!".

Briefly, in assembly you can't pass variables to functions as arguments, since there are no variables, no functions and no arguments. So, you have to put the needed values inside some predefined registers.
In **rax** we tell the OS which syscall we're calling and, in this case, we put the _stdout file descriptor_ value in **rdi**, the string we want to print in **rsi** and in **rdx** the length of the string. And with `syscall` we actually make the call to the OS.



