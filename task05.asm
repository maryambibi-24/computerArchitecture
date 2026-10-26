; Task 5: Tiled matrix transpose B = A^T, N=64, tile=8.
default rel
extern printf
global main
section .data
fmt db "Tiled transpose complete: N=64, tile=8, check B[7][3]=A[3][7]=%d",10,0
section .bss
alignb 64
A resd 4096
B resd 4096
section .text
main:
    push rbp
    mov rbp, rsp
    lea rdi, [A]
    xor ecx, ecx
.init:
    mov [rdi+rcx*4], ecx
    inc ecx
    cmp ecx, 4096
    jl .init
    xor r8d, r8d             ; block row
.block_i:
    xor r9d, r9d             ; block column
.block_j:
    xor r10d, r10d           ; local row
.local_i:
    xor r11d, r11d           ; local col
.local_j:
    mov eax, r8d
    add eax, r10d
    shl eax, 6
    mov edx, r9d
    add edx, r11d
    add eax, edx
    mov ecx, [A+rax*4]
    ; B[col][row] = B[(j*64)+i]
    mov eax, edx
    shl eax, 6
    mov edx, r8d
    add edx, r10d
    add eax, edx
    mov [B+rax*4], ecx
    inc r11d
    cmp r11d, 8
    jl .local_j
    inc r10d
    cmp r10d, 8
    jl .local_i
    add r9d, 8
    cmp r9d, 64
    jl .block_j
    add r8d, 8
    cmp r8d, 64
    jl .block_i
    mov edx, [B+(7*64+3)*4]
    lea rcx, [fmt]
    call printf
    xor eax, eax
    pop rbp
    ret
