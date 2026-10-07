; =========================================================
; TASK 13: ARRAY ELEMENT SWAPPING
;
; Logical instructions:
;
; LW R3, 0(R2)       ; Load ValA
; LW R4, 4(R2)       ; Load ValB
; SW R3, 4(R2)       ; Store ValA at second position
; SW R4, 0(R2)       ; Store ValB at first position
;
; The two loads are scheduled consecutively.
; The stores use the loaded values through forwarding.
;
; Stalls = 0
; NOPs   = 0
; =========================================================

global _main
extern _printf

section .data

    ; Simulated array
    array:
        dd 100          ; array[0] = ValA
        dd 200          ; array[1] = ValB

    title db "===== TASK 13: ARRAY ELEMENT SWAPPING =====", 10, 0

    before_msg db "Before swap: Array[0] = %d, Array[1] = %d", 10, 0
    loadA_msg db "LW R3, 0(R2)  -> ValA = %d", 10, 0
    loadB_msg db "LW R4, 4(R2)  -> ValB = %d", 10, 0
    storeA_msg db "SW R3, 4(R2) -> Array[1] = %d", 10, 0
    storeB_msg db "SW R4, 0(R2) -> Array[0] = %d", 10, 0
    after_msg db "After swap:  Array[0] = %d, Array[1] = %d", 10, 0

    result_msg db "Result: 0 stalls and 0 NOPs", 10, 0


section .text

_main:

    ; =====================================================
    ; Display title
    ; =====================================================

    push title
    call _printf
    add esp, 4


    ; =====================================================
    ; R2 points to beginning of array
    ;
    ; ESI represents R2
    ; =====================================================

    mov esi, array


    ; =====================================================
    ; Display array BEFORE swap
    ; =====================================================

    push dword [esi + 4]
    push dword [esi]
    push before_msg
    call _printf
    add esp, 12


    ; =====================================================
    ; LW R3, 0(R2)
    ;
    ; EAX represents R3
    ; Load ValA = 100
    ; =====================================================

    mov eax, [esi]

    push eax
    push loadA_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; LW R4, 4(R2)
    ;
    ; EBX represents R4
    ; Load ValB = 200
    ;
    ; This second load fills the latency slot
    ; of the first load.
    ; =====================================================

    mov ebx, [esi + 4]

    push ebx
    push loadB_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; SW R3, 4(R2)
    ;
    ; Store ValA into second array position.
    ;
    ; EAX contains R3.
    ; =====================================================

    mov [esi + 4], eax

    push dword [esi + 4]
    push storeA_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; SW R4, 0(R2)
    ;
    ; Store ValB into first array position.
    ;
    ; EBX contains R4.
    ; =====================================================

    mov [esi], ebx

    push dword [esi]
    push storeB_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; Display array AFTER swap
    ; =====================================================

    push dword [esi + 4]
    push dword [esi]
    push after_msg
    call _printf
    add esp, 12


    ; =====================================================
    ; Final result
    ; =====================================================

    push result_msg
    call _printf
    add esp, 4


    ; Return 0
    xor eax, eax
    ret