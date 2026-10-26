; Task 20: Working-set sizes from 4 KB to 64 MB, sequential dependent pointer walk.
; Demonstration: reported timing is not a precise hardware cache-latency counter.
default rel
extern printf
extern malloc
extern free
extern clock
global main
section .data
fmt db "working_set=%8d bytes | dependent accesses=%d | clock ticks=%d",10,0
section .text
main:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov dword [rbp-4], 4096
.size_loop:
    mov ecx, [rbp-4]
    call malloc
    test rax, rax
    jz .finish
    mov [rbp-16], rax
    ; initialize one pointer per 64 bytes, linking line to next
    mov rdi, rax
    mov r10d, [rbp-4]
    shr r10d, 6
    xor r11d, r11d
.init:
    mov eax, r11d
    inc eax
    cmp eax, r10d
    jb .nextidx
    xor eax, eax
.nextidx:
    shl rax, 6
    add rax, [rbp-16]
    mov [rdi+r11*8], rax
    add r11d, 8
    cmp r11d, r10d
    jb .init
    call clock
    mov [rbp-24], eax
    mov rdi, [rbp-16]
    mov ecx, 100000
.chase:
    mov rdi, [rdi]
    dec ecx
    jnz .chase
    call clock
    sub eax, [rbp-24]
    mov r8d, eax
    lea rcx, [fmt]
    mov edx, [rbp-4]
    mov r9d, 100000
    sub rsp, 32
    mov dword [rsp+32], r8d
    call printf
    add rsp, 32
    mov rcx, [rbp-16]
    call free
    shl dword [rbp-4], 1
    cmp dword [rbp-4], 67108864
    jle .size_loop
.finish:
    xor eax, eax
    add rsp, 64
    pop rbp
    ret
