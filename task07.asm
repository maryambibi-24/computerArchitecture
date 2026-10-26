; Task 7: 32-bit address field extraction for 4KB cache, 32-byte blocks, direct mapped.
default rel
extern printf
global main
section .data
fmt db "addr=%08X offset=%02X set=%03X tag=%05X",10,0
addrs dd 0x00000000,0x0000001F,0x80001FE0
section .text
main:
    push rbp
    mov rbp, rsp
    xor esi, esi
.loop:
    mov eax, [addrs+rsi*4]
    mov r10d, eax
    and r10d, 31              ; offset bits 4:0
    mov r11d, eax
    shr r11d, 5
    and r11d, 127             ; set bits 11:5
    mov r9d, eax
    shr r9d, 12               ; tag bits 31:12
    lea rcx, [fmt]
    mov edx, eax
    mov r8d, r10d
    ; Win64 printf has only four register args; remaining args on stack.
    sub rsp, 48
    mov dword [rsp+32], r11d
    mov dword [rsp+40], r9d
    call printf
    add rsp, 48
    inc esi
    cmp esi, 3
    jl .loop
    xor eax, eax
    pop rbp
    ret
