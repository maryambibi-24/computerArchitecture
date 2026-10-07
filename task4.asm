; =========================================================
; TASK 4: MULTI-OPERAND RAW HAZARD
;
; Producer 1 : ADD R1, R3, R4       Distance = 2
; Producer 2 : ADD R2, R5, R6       Distance = 1
;             NOP
;             NOP
; Consumer   : ADD R7, R1, R2
;
; Two NOPs are required because R2 is the youngest
; producer and requires the larger delay.
; These same two NOPs also resolve the R1 dependency.
; =========================================================

global _main
extern _printf

section .data

    title db "===== TASK 4: MULTI-OPERAND RAW HAZARD =====", 10, 0

    msg1 db "Producer 1 : ADD R1, R3, R4", 10, 0
    msg2 db "Producer 2 : ADD R2, R5, R6", 10, 0
    msg3 db "Delay      : NOP", 10, 0
    msg4 db "Delay      : NOP", 10, 0
    msg5 db "Consumer   : ADD R7, R1, R2", 10, 0

    result1 db "R1 = R3 + R4 = %d", 10, 0
    result2 db "R2 = R5 + R6 = %d", 10, 0
    result3 db "R7 = R1 + R2 = %d", 10, 0

    hazard db "Two NOPs resolve BOTH RAW dependencies.", 10, 0

section .text

_main:

    ; -----------------------------------------
    ; Display title
    ; -----------------------------------------

    push title
    call _printf
    add esp, 4

    ; Display instruction sequence

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

    ; -----------------------------------------
    ; Producer 1
    ;
    ; ADD R1, R3, R4
    ; R3 = 10
    ; R4 = 20
    ; R1 = 30
    ; -----------------------------------------

    mov eax, 10          ; R3
    mov ebx, 20          ; R4

    add eax, ebx         ; R1 = 30

    push eax
    push result1
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; Producer 2
    ;
    ; ADD R2, R5, R6
    ; R5 = 5
    ; R6 = 15
    ; R2 = 20
    ; -----------------------------------------

    mov ecx, 5           ; R5
    mov edx, 15          ; R6

    add ecx, edx         ; R2 = 20

    push ecx
    push result2
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; TWO NOPS
    ;
    ; These provide the required delay.
    ; -----------------------------------------

    nop                  ; Delay cycle 1
    nop                  ; Delay cycle 2

    ; -----------------------------------------
    ; Consumer
    ;
    ; ADD R7, R1, R2
    ;
    ; R7 = R1 + R2
    ; R7 = 30 + 20
    ; R7 = 50
    ; -----------------------------------------

    add eax, ecx         ; R7 = R1 + R2

    push eax
    push result3
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; Display conclusion
    ; -----------------------------------------

    push hazard
    call _printf
    add esp, 4

    ; Return 0
    xor eax, eax
    ret