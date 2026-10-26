; Task 12: XOR-hashed index emulation, 128 sets, 64-byte lines.
default rel
extern printf
global main
section .data
fmt db "address=%08X raw_set=%3d tag_low=%3d hashed_set=%3d",10,0
addrs dd 0x00000000,0x00000400,0x00000800,0x00000C00
section .text
main:
    push rbp
    mov rbp, rsp
    xor esi, esi
.loop:
    mov eax, [addrs+rsi*4]
    mov r10d, eax
    shr r10d, 6
    and r10d, 127
    mov r11d, eax
    shr r11d, 13
    and r11d, 127
    mov r9d, r10d
    xor r9d, r11d
    lea rcx, [fmt]
    mov edx, eax
    mov r8d, r10d
    sub rsp, 48
    mov dword [rsp+32], r11d
    mov dword [rsp+40], r9d
    call printf
    add rsp, 48
    inc esi
    cmp esi, 4
    jl .loop
    xor eax, eax
    pop rbp
    ret
