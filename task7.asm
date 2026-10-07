; =========================================================
; TASK 7: LOAD-USE WITH INDEPENDENT WORK
;
; Logical sequence:
;
; LW  R1, 0(R2)
; SUB R5, R6, R7
; ADD R3, R1, R4
;
; The independent SUB instruction hides the load latency.
; Therefore, NO NOP is required.
; =========================================================

global _main
extern _printf

section .data

    ; Simulated memory
    memory_value dd 100

    title db "===== TASK 7: LOAD-USE WITH INDEPENDENT WORK =====", 10, 0

    msg1 db "LW  R1, 0(R2)", 10, 0
    msg2 db "SUB R5, R6, R7       ; Independent instruction", 10, 0
    msg3 db "ADD R3, R1, R4       ; Uses loaded R1", 10, 0

    load_msg db "Loaded R1 = %d", 10, 0
    sub_msg db "Independent SUB result R5 = %d", 10, 0
    add_msg db "Final ADD result R3 = %d", 10, 0

    result_msg db "No NOP required: independent work hides load latency.", 10, 0

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

    ; =========================================
    ; LOAD
    ;
    ; LW R1, 0(R2)
    ; =========================================

    ; R2 contains the address of memory_value
    mov esi, memory_value

    ; Load memory value into EAX
    ; EAX represents R1
    mov eax, [esi]

    push eax
    push load_msg
    call _printf
    add esp, 8

    ; =========================================
    ; INDEPENDENT INSTRUCTION
    ;
    ; SUB R5, R6, R7
    ;
    ; R6 = 50
    ; R7 = 20
    ; R5 = 30
    ;
    ; This useful instruction occupies the
    ; pipeline cycle that would otherwise
    ; require a stall.
    ; =========================================

    mov ebx, 50          ; R6
    mov ecx, 20          ; R7

    sub ebx, ecx         ; R5 = 50 - 20 = 30

    push ebx
    push sub_msg
    call _printf
    add esp, 8

    ; =========================================
    ; CONSUMER
    ;
    ; ADD R3, R1, R4
    ;
    ; R1 = 100
    ; R4 = 25
    ; R3 = 125
    ;
    ; The loaded value can now be forwarded.
    ; =========================================

    mov edx, 25          ; R4

    add eax, edx         ; R3 = R1 + R4

    push eax
    push add_msg
    call _printf
    add esp, 8

    ; =========================================
    ; Result
    ; =========================================

    push result_msg
    call _printf
    add esp, 4

    ; Return 0
    xor eax, eax
    ret