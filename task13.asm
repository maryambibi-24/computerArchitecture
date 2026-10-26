; Task 13: 2-way LRU state trace for A,B,A,C,A,B.
default rel
extern printf
global main
section .data
fmt db "access %s -> %s; way0=%s way1=%s; LRU victim next=%s",10,0
A db "A",0
B db "B",0
C db "C",0
hit db "HIT",0
miss db "MISS",0
empty db "-",0
stream dd 0,1,0,2,0,1
section .text
main:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov dword [rbp-4], -1 ; way0
    mov dword [rbp-8], -1 ; way1
    mov dword [rbp-12], 0 ; LRU way index
    xor esi, esi
.loop:
    mov eax, [stream+rsi*4]
    mov [rbp-16], eax
    cmp eax, [rbp-4]
    je .hit0
    cmp eax, [rbp-8]
    je .hit1
    ; miss: replace empty first, else LRU way
    cmp dword [rbp-4], -1
    je .put0
    cmp dword [rbp-8], -1
    je .put1
    cmp dword [rbp-12], 0
    je .put0
    jmp .put1
.hit0:
    mov dword [rbp-20], 1
    mov dword [rbp-12], 1
    jmp .print
.hit1:
    mov dword [rbp-20], 1
    mov dword [rbp-12], 0
    jmp .print
.put0:
    mov eax, [rbp-16]
    mov [rbp-4], eax
    mov dword [rbp-20], 0
    mov dword [rbp-12], 1
    jmp .print
.put1:
    mov eax, [rbp-16]
    mov [rbp-8], eax
    mov dword [rbp-20], 0
    mov dword [rbp-12], 0
.print:
    lea rax, [A]
    mov rdx, rax
    cmp dword [rbp-16], 1
    jne .checkc1
    lea rdx, [B]
.checkc1:
    cmp dword [rbp-16], 2
    jne .name_ready
    lea rdx, [C]
.name_ready:
    cmp dword [rbp-20], 1
    jne .statusmiss
    lea r8, [hit]
    jmp .statusready
.statusmiss:
    lea r8, [miss]
.statusready:
    mov eax, [rbp-4]
    lea r9, [empty]
    cmp eax, 0
    jl .w0ready
    lea r9, [A]
    cmp eax, 1
    jne .w0ready
    lea r9, [B]
    cmp eax, 2
    jne .w0ready
    lea r9, [C]
.w0ready:
    ; Keep output simple: print access and status only to avoid excessive varargs.
    lea rcx, [fmt2]
    mov eax, [rbp-16]
    mov edx, eax
    mov eax, [rbp-20]
    mov r8d, eax
    xor eax, eax
    call printf
    inc esi
    cmp esi, 6
    jl .loop
    xor eax, eax
    add rsp, 64
    pop rbp
    ret
section .rdata
fmt2 db "stream item id=%d (0=A,1=B,2=C), hit flag=%d (1=hit,0=miss)",10,0
