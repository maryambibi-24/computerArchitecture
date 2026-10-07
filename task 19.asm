; Task 19: Structural Hazard
; Concept:
; LW accesses data memory while another instruction
; needs instruction memory at the same time.

section .text
global _start

_start:

    ; Equivalent of:
    ; LW R1, 0(R2)

    mov     eax, [ebx]

    ; Equivalent arithmetic instructions
    add     ecx, edx
    sub     esi, edi
    and     ebp, esp

    ; In a pipelined processor with unified single-port
    ; memory, instruction fetch and data access may conflict.
    ; The hardware would insert a stall.

    nop                     ; Demonstrates a possible stall

    mov     eax, 1
    xor     ebx, ebx
    int     0x80