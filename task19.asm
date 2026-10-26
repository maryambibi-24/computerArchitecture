; Task 19: Pointer-chasing stride experiment with a simple linked ring.
; Ring size is fixed at 4096 nodes; stride changes storage footprint.
default rel
extern printf
global main
section .data
fmt db "stride=%3d bytes | traversal complete | checksum=%lld",10,0
section .bss
alignb 64
arena resb 1048576
section .text
main:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov dword [rbp-4], 8
.next:
    mov eax, [rbp-4]
    ; initialize each slot with address of next slot, 4096 nodes
    lea rdi, [arena]
    xor ecx, ecx
.init:
    mov edx, ecx
    inc edx
    and edx, 4095
    imul edx, eax
    lea rdx, [arena+rdx]
    mov [rdi+rcx*rax], rdx
    inc ecx
    cmp ecx, 4096
    jl .init
    lea rdi, [arena]
    mov ecx, 4096
    xor r8, r8
.chase:
    mov rdi, [rdi]
    dec ecx
    jnz .chase
    mov rdx, r8
    lea rcx, [fmt]
    mov edx, [rbp-4]
    mov r8, rdi
    call printf
    shl dword [rbp-4], 1
    cmp dword [rbp-4], 256
    jle .next
    xor eax, eax
    add rsp, 48
    pop rbp
    ret
