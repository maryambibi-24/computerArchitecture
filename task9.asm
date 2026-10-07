; =========================================================
; TASK 9: STORE AFTER ARITHMETIC
;
; Logical instructions:
;
; ADD R4, R2, R3
; SW  R4, 0(R5)
;
; The ADD result is forwarded directly to the store.
; Therefore, no NOP/stall is required.
; =========================================================

global _main
extern _printf

section .data

    ; Simulated memory location
    memory_value dd 0

    title db "===== TASK 9: STORE AFTER ARITHMETIC =====", 10, 0

    msg1 db "ADD R4, R2, R3", 10, 0
    msg2 db "SW  R4, 0(R5)", 10, 0

    add_msg db "ADD result R4 = %d", 10, 0
    store_msg db "Memory[R5 + 0] = %d", 10, 0

    result_msg db "Result: 0 stalls and 0 NOPs required.", 10, 0

section .text

_main:

    ; -----------------------------------------------------
    ; Display title
    ; -----------------------------------------------------

    push title
    call _printf
    add esp, 4

    ; -----------------------------------------------------
    ; Display logical instructions
    ; -----------------------------------------------------

    push msg1
    call _printf
    add esp, 4

    push msg2
    call _printf
    add esp, 4

    ; =====================================================
    ; ADD R4, R2, R3
    ;
    ; R2 = 100
    ; R3 = 50
    ; R4 = 150
    ; =====================================================

    mov eax, 100          ; R2
    mov ebx, 50           ; R3

    add eax, ebx          ; R4 = R2 + R3

    ; EAX now contains logical R4 = 150

    push eax
    push add_msg
    call _printf
    add esp, 8

    ; =====================================================
    ; SW R4, 0(R5)
    ;
    ; The ADD result is directly available to the store.
    ; No NOP is needed.
    ;
    ; ESI represents R5 / memory address.
    ; =====================================================

    mov esi, memory_value

    ; Store R4 into memory
    mov [esi], eax

    push dword [esi]
    push store_msg
    call _printf
    add esp, 8

    ; -----------------------------------------------------
    ; Final result
    ; -----------------------------------------------------

    push result_msg
    call _printf
    add esp, 4

    ; Return 0
    xor eax, eax
    ret