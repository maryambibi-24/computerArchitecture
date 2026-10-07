; =========================================================
; TASK 14: DOT PRODUCT ELEMENT INTERLEAVING
;
; Logical sequence:
;
; LW  R3, 0(R1)       ; Load X0
; LW  R4, 0(R2)       ; Load Y0
; LW  R5, 4(R1)       ; Load X1 / pre-fetch
; MUL R6, R3, R4      ; X0 * Y0
; ADD R10, R10, R6    ; Accumulate
;
; The independent X1 load is placed between the
; operand loads and multiplication to keep the
; pipeline busy.
;
; Stalls = 0 in the conceptual scheduled sequence.
; =========================================================

global _main
extern _printf

section .data

    ; -----------------------------------------------------
    ; X array
    ; X0 = 3
    ; X1 = 4
    ; -----------------------------------------------------

    X:
        dd 3
        dd 4

    ; -----------------------------------------------------
    ; Y array
    ; Y0 = 5
    ; Y1 = 6
    ; -----------------------------------------------------

    Y:
        dd 5
        dd 6

    ; Running sum
    dot_product dd 0

    title db "===== TASK 14: DOT PRODUCT ELEMENT INTERLEAVING =====", 10, 0

    msg1 db "LW  R3, 0(R1)       -> Load X0", 10, 0
    msg2 db "LW  R4, 0(R2)       -> Load Y0", 10, 0
    msg3 db "LW  R5, 4(R1)       -> Pre-fetch X1", 10, 0
    msg4 db "MUL R6, R3, R4      -> X0 * Y0", 10, 0
    msg5 db "ADD R10, R10, R6    -> Accumulate", 10, 0

    x0_msg db "X0 = %d", 10, 0
    y0_msg db "Y0 = %d", 10, 0
    x1_msg db "X1 pre-fetched = %d", 10, 0
    mul_msg db "R6 = X0 * Y0 = %d", 10, 0
    sum_msg db "Dot product sum = %d", 10, 0

    result_msg db "Result: Load interleaving masks the load latency.", 10, 0


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

    push msg5
    call _printf
    add esp, 4


    ; =====================================================
    ; Set base addresses
    ;
    ; R1 -> ESI = X array
    ; R2 -> EDI = Y array
    ; =====================================================

    mov esi, X
    mov edi, Y


    ; =====================================================
    ; LW R3, 0(R1)
    ;
    ; Load X0 = 3
    ;
    ; EAX represents R3.
    ; =====================================================

    mov eax, [esi]

    push eax
    push x0_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; LW R4, 0(R2)
    ;
    ; Load Y0 = 5
    ;
    ; EBX represents R4.
    ; =====================================================

    mov ebx, [edi]

    push ebx
    push y0_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; LW R5, 4(R1)
    ;
    ; Pre-fetch X1 = 4
    ;
    ; ECX represents R5.
    ;
    ; This independent load keeps the pipeline busy
    ; while the previous load values become available.
    ; =====================================================

    mov ecx, [esi + 4]

    push ecx
    push x1_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; MUL R6, R3, R4
    ;
    ; R6 = X0 * Y0
    ;     = 3 * 5
    ;     = 15
    ;
    ; NASM x86:
    ; EAX * EBX
    ; =====================================================

    imul eax, ebx

    push eax
    push mul_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; ADD R10, R10, R6
    ;
    ; Accumulate multiplication result.
    ;
    ; EDX represents R10.
    ; =====================================================

    xor edx, edx          ; R10 = 0

    add edx, eax          ; R10 = R10 + R6

    mov [dot_product], edx

    push edx
    push sum_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; Final result
    ; =====================================================

    push result_msg
    call _printf
    add esp, 4


    ; Return 0
    xor eax, eax
    ret