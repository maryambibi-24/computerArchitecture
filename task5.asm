; =========================================================
; TASK 5: CHAIN OF CUMULATIVE ADDITIONS
;
; R1 = R1 + R2
; NOP
; NOP
;
; R1 = R1 + R3
; NOP
; NOP
;
; R1 = R1 + R4
;
; Every ADD depends on the previous value of R1.
; Therefore, two NOPs are required after each ADD.
; =========================================================

global _main
extern _printf

section .data

    title db "===== TASK 5: CUMULATIVE ADDITION CHAIN =====", 10, 0

    msg1 db "ADD R1, R1, R2", 10, 0
    msg2 db "NOP", 10, 0
    msg3 db "NOP", 10, 0
    msg4 db "ADD R1, R1, R3", 10, 0
    msg5 db "NOP", 10, 0
    msg6 db "NOP", 10, 0
    msg7 db "ADD R1, R1, R4", 10, 0

    result1 db "After ADD 1: R1 = %d", 10, 0
    result2 db "After ADD 2: R1 = %d", 10, 0
    result3 db "After ADD 3: R1 = %d", 10, 0

    hazard db "Each ADD depends on the previous R1 result.", 10, 0
    finish db "Two NOPs are required between each dependent ADD.", 10, 0

section .text

_main:

    ; -----------------------------------------
    ; Display title
    ; -----------------------------------------

    push title
    call _printf
    add esp, 4

    ; -----------------------------------------
    ; Display instruction sequence
    ; -----------------------------------------

    push msg1
    call _printf
    add esp, 4

    push msg2
    call _printf
    add esp, 4

    push msg3
    call _printf
    add esp, 4

    push msg4
    call _printf
    add esp, 4

    push msg5
    call _printf
    add esp, 4

    push msg6
    call _printf
    add esp, 4

    push msg7
    call _printf
    add esp, 4

    ; -----------------------------------------
    ; Initialize registers
    ;
    ; R1 = 10
    ; R2 = 20
    ; R3 = 30
    ; R4 = 40
    ; -----------------------------------------

    mov eax, 10          ; R1
    mov ebx, 20          ; R2
    mov ecx, 30          ; R3
    mov edx, 40          ; R4

    ; -----------------------------------------
    ; ADD 1
    ;
    ; R1 = R1 + R2
    ; R1 = 10 + 20 = 30
    ; -----------------------------------------

    add eax, ebx

    push eax
    push result1
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; TWO-CYCLE STALL
    ; -----------------------------------------

    nop
    nop

    ; -----------------------------------------
    ; ADD 2
    ;
    ; R1 = R1 + R3
    ; R1 = 30 + 30 = 60
    ; -----------------------------------------

    add eax, ecx

    push eax
    push result2
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; TWO-CYCLE STALL
    ; -----------------------------------------

    nop
    nop

    ; -----------------------------------------
    ; ADD 3
    ;
    ; R1 = R1 + R4
    ; R1 = 60 + 40 = 100
    ; -----------------------------------------

    add eax, edx

    push eax
    push result3
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; Explanation
    ; -----------------------------------------

    push hazard
    call _printf
    add esp, 4

    push finish
    call _printf
    add esp, 4

    ; Return 0
    xor eax, eax
    ret