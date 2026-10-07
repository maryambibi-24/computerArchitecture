; =========================================================
; TASK 12: DOUBLE LOAD SCHEDULING
;
; Logical instructions:
;
; LW  R1, 0(R4)       ; Load A
; LW  R6, 4(R4)       ; Load B
; ADD R2, R1, R5      ; Compute with A
; ADD R7, R6, R8      ; Compute with B
;
; Scheduling eliminates the need for NOPs.
; Stalls = 0
; =========================================================

global _main
extern _printf

section .data

    ; Simulated memory
    memory_data:
        dd 100          ; Memory[R4 + 0] = A
        dd 200          ; Memory[R4 + 4] = B

    title db "===== TASK 12: DOUBLE LOAD SCHEDULING =====", 10, 0

    msg1 db "LW  R1, 0(R4)       -> Load A", 10, 0
    msg2 db "LW  R6, 4(R4)       -> Load B", 10, 0
    msg3 db "ADD R2, R1, R5      -> Compute A", 10, 0
    msg4 db "ADD R7, R6, R8      -> Compute B", 10, 0

    loadA_msg db "R1 = %d", 10, 0
    loadB_msg db "R6 = %d", 10, 0

    resultA_msg db "R2 = R1 + R5 = %d", 10, 0
    resultB_msg db "R7 = R6 + R8 = %d", 10, 0

    final_msg db "Double-load scheduling: 0 stalls, 0 NOPs", 10, 0


section .text

_main:

    ; =====================================================
    ; Display title
    ; =====================================================

    push title
    call _printf
    add esp, 4


    ; =====================================================
    ; Display instruction sequence
    ; =====================================================

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


    ; =====================================================
    ; LW R1, 0(R4)
    ;
    ; R4 -> ESI
    ; R1 -> EAX
    ;
    ; Load A = 100
    ; =====================================================

    mov esi, memory_data

    mov eax, [esi]          ; LW R1, 0(R4)

    push eax
    push loadA_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; LW R6, 4(R4)
    ;
    ; R6 -> EBX
    ;
    ; Load B = 200
    ;
    ; This instruction fills the latency slot
    ; of the first load.
    ; =====================================================

    mov ebx, [esi + 4]      ; LW R6, 4(R4)

    push ebx
    push loadB_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; ADD R2, R1, R5
    ;
    ; R5 = 50
    ; R2 = 100 + 50 = 150
    ;
    ; This useful arithmetic instruction fills
    ; the latency slot associated with the second load.
    ; =====================================================

    mov ecx, 50             ; R5

    add eax, ecx            ; R2 = R1 + R5

    push eax
    push resultA_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; ADD R7, R6, R8
    ;
    ; R8 = 25
    ; R7 = 200 + 25 = 225
    ; =====================================================

    mov edx, 25             ; R8

    add ebx, edx            ; R7 = R6 + R8

    push ebx
    push resultB_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; Final result
    ; =====================================================

    push final_msg
    call _printf
    add esp, 4


    ; Return 0
    xor eax, eax
    ret