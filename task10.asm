; =========================================================
; TASK 10: LOAD-TO-STORE FORWARDING
;
; Logical instructions:
;
; LW R1, 0(R2)
; SW R1, 0(R3)
;
; Concept:
; The loaded data is forwarded directly from the
; load's MEM stage to the store's MEM stage.
;
; Stalls = 0
; NOPs   = 0
; =========================================================

global _main
extern _printf

section .data

    ; Source memory
    source_memory dd 250

    ; Destination memory
    destination_memory dd 0

    title db "===== TASK 10: LOAD-TO-STORE FORWARDING =====", 10, 0

    load_msg db "LW R1, 0(R2)  -> Loaded value = %d", 10, 0

    store_msg db "SW R1, 0(R3) -> Stored value = %d", 10, 0

    result_msg db "MEM-to-MEM forwarding: 0 stalls, 0 NOPs", 10, 0


section .text

_main:

    ; =====================================================
    ; Display title
    ; =====================================================

    push title
    call _printf
    add esp, 4


    ; =====================================================
    ; LW R1, 0(R2)
    ;
    ; R2 -> ESI
    ; R1 -> EAX
    ;
    ; Load value from source memory into EAX.
    ; =====================================================

    mov esi, source_memory

    mov eax, [esi]          ; LW R1, 0(R2)

    push eax
    push load_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; SW R1, 0(R3)
    ;
    ; R3 -> EDI
    ; R1 -> EAX
    ;
    ; Store the loaded value into destination memory.
    ;
    ; NO NOP is inserted.
    ; The conceptual MEM-to-MEM forwarding supplies
    ; the value directly to the store.
    ; =====================================================

    mov edi, destination_memory

    mov [edi], eax          ; SW R1, 0(R3)


    ; =====================================================
    ; Display stored value
    ; =====================================================

    push dword [edi]
    push store_msg
    call _printf
    add esp, 8


    ; =====================================================
    ; Display result
    ; =====================================================

    push result_msg
    call _printf
    add esp, 4


    ; =====================================================
    ; Return 0
    ; =====================================================

    xor eax, eax
    ret