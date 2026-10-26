; Task 17: Baseline vs prefetch-hint vector reduction.
; PREFETCHT0 is a hint; CPU may ignore it. This program reports matching sums.
default rel
extern printf
global main
section .data
fmt db "baseline sum=%lld; prefetched sum=%lld (prefetch is only a hint)",10,0
section .bss
alignb 64
arr resd 262144
section .text
main:
    push rbp
    mov rbp, rsp
    lea rdi, [arr]
    xor ecx, ecx
.init:
    mov dword [rdi+rcx*4], 1
    inc ecx
    cmp ecx, 262144
    jl .init
    xor r8, r8
    xor ecx, ecx
.base:
    movsxd rax, dword [rdi+rcx*4]
    add r8, rax
    inc ecx
    cmp ecx, 262144
    jl .base
    mov r9, r8
    xor ecx, ecx
    xor r10, r10
.pref:
    cmp ecx, 262112
    jae .nopref
    prefetcht0 [rdi+rcx*4+128]
.nopref:
    movsxd rax, dword [rdi+rcx*4]
    add r10, rax
    inc ecx
    cmp ecx, 262144
    jl .pref
    lea rcx, [fmt]
    mov rdx, r9
    mov r8, r10
    call printf
    xor eax, eax
    pop rbp
    ret
