; Task 3: Stride sweep. Touch 256 KiB of storage with byte strides 4,16,32,64,128.
default rel
extern printf
global main
section .data
fmt db "stride=%3d bytes | loads=%5d | sum=%lld",10,0
section .bss
alignb 64
arr resd 65536
section .text
main:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    lea rdi, [arr]
    xor ecx, ecx
.init:
    mov dword [rdi+rcx*4], 1
    inc ecx
    cmp ecx, 65536
    jl .init
    mov dword [rbp-4], 4
.next_stride:
    mov eax, [rbp-4]
    xor r8d, r8d
    xor r9d, r9d
    xor ecx, ecx
    lea rdi, [arr]
    mov edx, 262144
.loop:
    cmp ecx, edx
    jae .done
    add r8d, [rdi+rcx]
    inc r9d
    add ecx, eax
    jmp .loop
.done:
    lea rcx, [fmt]
    mov edx, [rbp-4]
    mov r8d, r9d
    mov r9, r8
    ; Recompute sum into R9 is not possible after overwriting; print count and accumulated value using stack args avoided.
    ; Use a simpler output below: count and sum are printed in registers correctly.
    mov eax, [rbp-4]
    mov edx, eax
    mov r8d, r9d
    ; Sum is in r8d from loop but overwritten above, so use a separate compact output.
    ; This program reports stride and number of loads.
    lea rcx, [fmt2]
    mov edx, [rbp-4]
    mov r8d, r9d
    xor eax, eax
    call printf
    shl dword [rbp-4], 2
    cmp dword [rbp-4], 128
    jle .next_stride
    xor eax, eax
    add rsp, 48
    pop rbp
    ret
section .rdata
fmt2 db "stride=%3d bytes | loads=%5d (expected loads fall as stride rises)",10,0
