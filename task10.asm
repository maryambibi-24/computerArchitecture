; Task 10: Fully associative 8-entry software tag lookup.
default rel
extern printf
global main
section .data
fmt db "tag=%d => %s",10,0
hit db "HIT",0
miss db "MISS",0
tags dd 11,22,33,44,55,66,77,88
section .text
main:
    push rbp
    mov rbp, rsp
    mov dword [rbp-4], 33
    sub rsp, 32
    xor esi, esi
.search:
    cmp esi, 8
    jge .not_found
    mov eax, [tags+rsi*4]
    cmp eax, [rbp-4]
    je .found
    inc esi
    jmp .search
.found:
    lea rcx, [fmt]
    mov edx, [rbp-4]
    lea r8, [hit]
    call printf
    jmp .end
.not_found:
    lea rcx, [fmt]
    mov edx, [rbp-4]
    lea r8, [miss]
    call printf
.end:
    xor eax, eax
    add rsp, 32
    pop rbp
    ret
