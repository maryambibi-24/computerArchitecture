; Task 6: Compare AoS (16-byte padded record) and SoA for summing x.
default rel
extern printf
global main
section .data
fmt db "AoS x sum=%lld; SoA x sum=%lld; useful x bytes=40000",10,0
section .bss
alignb 64
aos resb 160000       ; 10000 records x 16 bytes
soa resd 10000
section .text
main:
    push rbp
    mov rbp, rsp
    lea rdi, [aos]
    lea rsi, [soa]
    xor ecx, ecx
.init:
    mov [rdi+rcx*16], ecx
    mov dword [rdi+rcx*16+4], 2
    mov byte [rdi+rcx*16+8], 1
    mov dword [rdi+rcx*16+12], 3
    mov [rsi+rcx*4], ecx
    inc ecx
    cmp ecx, 10000
    jl .init
    xor r8, r8
    xor r9, r9
    xor ecx, ecx
.aosloop:
    movsxd rax, dword [rdi+rcx*16]
    add r8, rax
    inc ecx
    cmp ecx, 10000
    jl .aosloop
    xor ecx, ecx
.soaloop:
    movsxd rax, dword [rsi+rcx*4]
    add r9, rax
    inc ecx
    cmp ecx, 10000
    jl .soaloop
    lea rcx, [fmt]
    mov rdx, r8
    mov r8, r9
    call printf
    xor eax, eax
    pop rbp
    ret
