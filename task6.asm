; =========================================================
; TASK 6: CLASSIC LOAD-USE STALL
;
; Logical instructions:
;
; LW  R1, 0(R2)
; NOP
; ADD R3, R1, R4
;
; The NOP represents the required 1-cycle stall.
; =========================================================

global _main
extern _printf

section .data

    ; Simulated memory
    memory_value dd 100

    title db "===== TASK 6: CLASSIC LOAD-USE STALL =====", 10, 0

    msg1 db "LW  R1, 0(R2)", 10, 0
    msg2 db "NOP             ; 1-cycle stall", 10, 0
    msg3 db "ADD R3, R1, R4", 10, 0

    load_msg db "Loaded value into R1 = %d", 10, 0
    result_msg db "R3 = R1 + R4 = %d", 10, 0

    hazard_msg db "LOAD-USE HAZARD: One NOP is required.", 10, 0
    forward_msg db "At CC5, MEM-to-EX forwarding supplies R1 to ADD.", 10, 0

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

    ; -----------------------------------------
    ; R2 contains address of memory_value
    ;
    ; Simulates:
    ; LW R1, 0(R2)
    ; -----------------------------------------

    mov esi, memory_value

    ; Load value from memory
    mov eax, [esi]

    ; EAX represents R1
    push eax
    push load_msg
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; ONE NOP
    ;
    ; Represents the required 1-cycle stall.
    ; -----------------------------------------

    nop

    ; -----------------------------------------
    ; R4 = 50
    ;
    ; Simulates:
    ; ADD R3, R1, R4
    ; -----------------------------------------

    mov ebx, 50

    ; R3 = R1 + R4
    add eax, ebx

    push eax
    push result_msg
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; Explanation
    ; -----------------------------------------

    push hazard_msg
    call _printf
    add esp, 4

    push forward_msg
    call _printf
    add esp, 4

    ; Return 0
    xor eax, eax
    ret