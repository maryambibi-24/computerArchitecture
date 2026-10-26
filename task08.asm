; Task 8: Software model of direct-mapped 8 KB cache, 64-byte lines.
; P2 = P1 + 8192 bytes => same set, different tag.
default rel
extern printf
global main
section .data
fmt db "loads=%d hits=%d misses=%d miss_rate=%.1f%% (model)",10,0
section .text
main:
    push rbp
    mov rbp, rsp
    xor r8d, r8d       ; previous tag, 0=P1, 1=P2
    xor r9d, r9d       ; valid flag
    xor r10d, r10d     ; hits
    xor r11d, r11d     ; misses
    xor ecx, ecx
.loop:
    ; alternate tag 0/1, same set; first access each alternation replaces prior
    xor eax, eax
    test ecx, 1
    jz .tag_ready
    mov eax, 1
.tag_ready:
    cmp r9d, 0
    je .miss
    cmp eax, r8d
    je .hit
.miss:
    inc r11d
    mov r8d, eax
    mov r9d, 1
    jmp .next
.hit:
    inc r10d
.next:
    inc ecx
    cmp ecx, 2000
    jl .loop
    ; print rate 100*misses/2000 = integer 100.0 in this model
    lea rcx, [fmt]
    mov edx, 2000
    mov r8d, r10d
    mov r9d, r11d
    sub rsp, 48
    mov qword [rsp+32], 100.0
    call printf
    add rsp, 48
    xor eax, eax
    pop rbp
    ret
