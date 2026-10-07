; Task 16: Branch Delay Slot - Moving
; MIPS concept:
; BEQ R4, R5, TARGET
; ADD R1, R2, R3     ; delay slot

section .text
global _start

_start:

    ; Original instruction before branch
    ; R1 = R2 + R3

    cmp     r4, r5
    je      TARGET

    ; In MIPS this instruction would be in the delay slot.
    ; NASM/x86 has NO architectural delay slot.
    mov     r1, r2
    add     r1, r3

    j       EXIT

TARGET:
    ; Branch target
    nop

EXIT:
    ; End program
    mov     eax, 1
    xor     ebx, ebx
    int     0x80