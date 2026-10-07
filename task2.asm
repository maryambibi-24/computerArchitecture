; =========================================================
; TASK 2: MANUAL NOP INSERTION
; RAW Hazard - Distance 1
;
; ADD R1, R2, R3
; NOP
; NOP
; SUB R4, R1, R5
; =========================================================

global _main
extern _printf

section .data

    title db "===== TASK 2: MANUAL NOP INSERTION =====", 10, 0

    msg1 db "ADD R1, R2, R3", 10, 0
    msg2 db "NOP", 10, 0
    msg3 db "NOP", 10, 0
    msg4 db "SUB R4, R1, R5", 10, 0

    result1 db "R1 = R2 + R3 = %d", 10, 0
    result2 db "R4 = R1 - R5 = %d", 10, 0

    safe db "Two NOPs inserted: SUB can safely read R1.", 10, 0

section .text

_main:

    ; -----------------------------------------
    ; Display title
    ; -----------------------------------------

    push title
    call _printf
    add esp, 4

    ; -----------------------------------------
    ; Display instructions
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

    ; -----------------------------------------
    ; R2 = 10
    ; R3 = 20
    ; -----------------------------------------

    mov eax, 10          ; R2
    mov ebx, 20          ; R3

    ; -----------------------------------------
    ; Producer
    ;
    ; ADD R1, R2, R3
    ; R1 = 10 + 20 = 30
    ; -----------------------------------------

    add eax, ebx         ; R1 = 30

    push eax
    push result1
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; MANUAL NOP INSERTION
    ;
    ; These two NOPs create a 2-cycle delay.
    ; -----------------------------------------

    nop                  ; Wait 1 cycle
    nop                  ; Wait 1 cycle

    ; -----------------------------------------
    ; Consumer
    ;
    ; R5 = 5
    ; R4 = R1 - R5
    ; -----------------------------------------

    mov edx, 5           ; R5

    sub eax, edx         ; R4 = 30 - 5 = 25

    push eax
    push result2
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; Display confirmation
    ; -----------------------------------------

    push safe
    call _printf
    add esp, 4

    ; Return 0
    xor eax, eax
    ret