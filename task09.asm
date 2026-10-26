; Task 9: Set-associative model: 4-way set, test K=1..6 addresses in same set.
default rel
extern printf
global main
section .data
fmt db "ways=4, K=%d addresses, misses on repeated sweep=%d (model)",10,0
section .text
main:
    push rbp
    mov rbp, rsp
    mov dword [rbp-4], 1
    sub rsp, 32
.kloop:
    mov eax, [rbp-4]
    ; one cold miss per address; if K>4, every access in cyclic sweep misses under LRU
    cmp eax, 4
    jle .fits
    mov edx, 12
    jmp .print
.fits:
    mov edx, eax
.print:
    lea rcx, [fmt]
    mov r8d, edx
    mov edx, [rbp-4]
    call printf
    inc dword [rbp-4]
    cmp dword [rbp-4], 6
    jle .kloop
    xor eax, eax
    add rsp, 32
    pop rbp
    ret
