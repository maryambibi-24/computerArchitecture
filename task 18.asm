; Task 18: Unconditional Jump Delay
; MIPS concept:
; LOOP:
;     J LOOP
;     SUB R1, R1, 1

section .text
global _start

_start:

    mov     ecx, 5

LOOP:
    dec     ecx

    ; x86 JMP has no delay slot.
    ; This instruction is executed BEFORE the jump.
    jmp     LOOP

    ; This instruction would NOT execute
    ; because JMP always transfers control.
    
EXIT:
    mov     eax, 1
    xor     ebx, ebx
    int     0x80