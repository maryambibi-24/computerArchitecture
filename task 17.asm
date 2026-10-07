; Task 17: Branch Delay Slot - NOP Fallback

section .text
global _start

_start:

    ; R4 = R4 - 1
    dec     r4

    ; Check whether R4 == 0
    cmp     r4, 0
    je      EXIT

    ; In MIPS:
    ; NOP would be placed in the delay slot.
    ; x86 has no branch delay slot.

    j       EXIT

EXIT:
    mov     eax, 1
    xor     ebx, ebx
    int     0x80