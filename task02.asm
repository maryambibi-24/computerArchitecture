; Task 2: Temporal locality — repeatedly increment one aligned location 10,000 times.
default rel
extern printf
global main
section .data
fmt db "Final value=%d; first access may miss, later accesses usually hit while resident.",10,0
align 16
hot dd 0
section .text
main:
    push rbp
    mov rbp, rsp
    xor ecx, ecx
.loop:
    mov eax, [hot]
    inc eax
    mov [hot], eax
    inc ecx
    cmp ecx, 10000
    jl .loop
    mov edx, [hot]
    lea rcx, [fmt]
    call printf
    xor eax, eax
    pop rbp
    ret
