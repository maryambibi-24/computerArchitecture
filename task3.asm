; =========================================================
; TASK 3: MANUAL NOP INSERTION - DISTANCE 2
;
; Producer   : ADD R2, R4, R5
; Independent: AND R6, R7, R8
; NOP        : One additional delay cycle
; Consumer   : OR R9, R2, R10
; =========================================================

global _main
extern _printf

section .data

    title db "===== TASK 3: NOP INSERTION - DISTANCE 2 =====", 10, 0

    msg1 db "Producer    : ADD R2, R4, R5", 10, 0
    msg2 db "Independent : AND R6, R7, R8", 10, 0
    msg3 db "NOP         : One-cycle delay", 10, 0
    msg4 db "Consumer    : OR R9, R2, R10", 10, 0

    result1 db "R2 = R4 + R5 = %d", 10, 0
    result2 db "R6 = R7 AND R8 = %d", 10, 0
    result3 db "R9 = R2 OR R10 = %d", 10, 0

    safe_msg db "RAW hazard avoided: Consumer reads R2 safely at CC5.", 10, 0

section .text

_main:

    ; -----------------------------------------
    ; Display title
    ; -----------------------------------------

    push title
    call _printf
    add esp, 4

    ; Display instructions

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
    ; Initialize registers
    ;
    ; R4 = 10
    ; R5 = 20
    ; -----------------------------------------

    mov eax, 10          ; R4
    mov ebx, 20          ; R5

    ; -----------------------------------------
    ; PRODUCER
    ;
    ; ADD R2, R4, R5
    ; R2 = 10 + 20 = 30
    ; -----------------------------------------

    add eax, ebx         ; R2 = 30

    push eax
    push result1
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; INDEPENDENT INSTRUCTION
    ;
    ; AND R6, R7, R8
    ; -----------------------------------------

    mov ecx, 15          ; R7
    mov edx, 7           ; R8

    and ecx, edx         ; R6 = 15 AND 7

    push ecx
    push result2
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; ONE NOP
    ;
    ; Provides one additional pipeline cycle.
    ; -----------------------------------------

    nop

    ; -----------------------------------------
    ; CONSUMER
    ;
    ; OR R9, R2, R10
    ; R10 = 5
    ; R9 = R2 OR R10
    ; -----------------------------------------

    mov edx, 5           ; R10

    or eax, edx          ; R9 = R2 OR R10

    push eax
    push result3
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; Display result
    ; -----------------------------------------

    push safe_msg
    call _printf
    add esp, 4

    ; Return 0
    xor eax, eax
    ret