; Task 1: Spatial locality — sum 1024 contiguous 32-bit integers.
default rel
extern printf
global main
section .data
fmt db "Sum=%lld | elements=1024 | assumed 64-byte lines=64 | cold compulsory miss rate=6.25%%",10,0
section .bss
arr resd 1024
section .text
main:
    push rbp
    mov rbp, rsp
    lea rdi, [arr]
    xor ecx, ecx
.init:
    mov dword [rdi+rcx*4], ecx
    inc ecx
    cmp ecx, 1024
    jl .init
    xor eax, eax
    xor ecx, ecx
.sum:
    movsxd rdx, dword [rdi+rcx*4]
    add rax, rdx
    inc ecx
    cmp ecx, 1024
    jl .sum
    mov rdx, rax
    lea rcx, [fmt]
    call printf
    xor eax, eax
    pop rbp
    ret
