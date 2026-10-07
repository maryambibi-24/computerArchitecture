; =========================================================
; TASK 15: BRANCH STALL PENALTY CALCULATION
;
; Logical MIPS instruction:
;
; BEQ R1, R2, TARGET
;
; If R1 == R2, branch to TARGET.
;
; Conceptual pipeline:
;
; Branch resolved in EX:
;     2 instructions are flushed
;     Penalty = 2 cycles
;
; Branch resolved in ID:
;     1 instruction is flushed
;     Penalty = 1 cycle
;
; This NASM program demonstrates the branch condition
; and displays the two possible penalties.
; =========================================================

global _main
extern _printf

section .data

    title db "===== TASK 15: BRANCH STALL PENALTY =====", 10, 0

    branch_msg db "BEQ R1, R2, TARGET", 10, 0

    equal_msg db "R1 == R2: Branch condition is TRUE", 10, 0
    target_msg db "Branch taken -> TARGET", 10, 0

    ex_msg db "Branch resolved in EX: 2 instructions flushed", 10, 0
    ex_penalty db "EX resolution penalty = 2 cycles", 10, 0

    id_msg db "Branch resolved in ID: 1 instruction flushed", 10, 0
    id_penalty db "ID resolution penalty = 1 cycle", 10, 0

    finish_msg db "Control hazard demonstration complete.", 10, 0


section .text

_main:

    ; =====================================================
    ; Display title
    ; =====================================================

    push title
    call _printf
    add esp, 4

    push branch_msg
    call _printf
    add esp, 4


    ; =====================================================
    ; Set logical registers
    ;
    ; R1 = EAX
    ; R2 = EBX
    ;
    ; Make them equal so the branch is taken.
    ; =====================================================

    mov eax, 10          ; R1 = 10
    mov ebx, 10          ; R2 = 10


    ; =====================================================
    ; BEQ R1, R2, TARGET
    ;
    ; Actual x86 equivalent:
    ;
    ; CMP R1, R2
    ; JE  TARGET
    ; =====================================================

    cmp eax, ebx
    je TARGET


    ; =====================================================
    ; These instructions would be on the sequential path.
    ; If the branch is taken, they are conceptually
    ; flushed from the pipeline.
    ; =====================================================

    push ex_msg
    call _printf
    add esp, 4

    jmp FINISH


TARGET:

    ; =====================================================
    ; Branch target
    ; =====================================================

    push equal_msg
    call _printf
    add esp, 4

    push target_msg
    call _printf
    add esp, 4

    ; -----------------------------------------------------
    ; Branch penalty when resolved in EX
    ; -----------------------------------------------------

    push ex_msg
    call _printf
    add esp, 4

    push ex_penalty
    call _printf
    add esp, 4

    ; -----------------------------------------------------
    ; Branch penalty when resolved in ID
    ; -----------------------------------------------------

    push id_msg
    call _printf
    add esp, 4

    push id_penalty
    call _printf
    add esp, 4


FINISH:

    push finish_msg
    call _printf
    add esp, 4

    ; Return 0
    xor eax, eax
    ret