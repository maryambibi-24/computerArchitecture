; =========================================================
; TASK 8: BACK-TO-BACK ADDRESS DEPENDENCY
;
; Logical MIPS-like instructions:
;
; LW  R1, 0(R2)
; NOP
; LW  R3, 4(R1)
;
; The first load produces R1.
; The second load uses R1 as a base address.
; Therefore, one NOP is required.
; =========================================================

global _main
extern _printf

section .data

    ; Simulated memory
    memory_value dd address_data

    ; Data located at the address loaded into R1
    address_data times 5 dd 0
    ; address_data[0] = 0
    ; address_data[1] = 0
    ; address_data[2] = 0
    ; address_data[3] = 0
    ; address_data[4] = 500

    title db "===== TASK 8: BACK-TO-BACK ADDRESS DEPENDENCY =====", 10, 0

    msg1 db "LW  R1, 0(R2)", 10, 0
    msg2 db "NOP                  ; 1-cycle stall", 10, 0
    msg3 db "LW  R3, 4(R1)", 10, 0

    load_msg db "R1 loaded with address = %d", 10, 0
    result_msg db "R3 loaded from address R1 + 4 = %d", 10, 0

    explanation db "The NOP is required because R1 is needed by the second LW during EX.", 10, 0

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

    push msg3
    call _printf
    add esp, 4

    ; =====================================================
    ; FIRST LOAD
    ;
    ; LW R1, 0(R2)
    ;
    ; R2 = address of memory_value
    ; R1 = value stored at memory_value
    ; =====================================================

    mov esi, memory_value

    ; EAX represents logical R1
    mov eax, [esi]

    push eax
    push load_msg
    call _printf
    add esp, 8

    ; =====================================================
    ; ONE-CYCLE STALL
    ;
    ; The NOP represents the mandatory pipeline stall.
    ; =====================================================

    nop

    ; =====================================================
    ; SECOND LOAD
    ;
    ; LW R3, 4(R1)
    ;
    ; R1 contains the base address.
    ;
    ; In x86:
    ; [eax + 4]
    ;
    ; EBX represents logical R3.
    ; =====================================================

    mov ebx, [eax + 4]

    push ebx
    push result_msg
    call _printf
    add esp, 8

    ; -----------------------------------------------------
    ; Explanation
    ; -----------------------------------------------------

    push explanation
    call _printf
    add esp, 4

    ; Return 0
    xor eax, eax
    ret