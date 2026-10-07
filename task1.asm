; RAW Hazard Demonstration
; NASM 32-bit, Windows

global _main
extern _printf

section .data

    title db "===== RAW DEPENDENCY DEMONSTRATION =====", 10, 0

    producer db "Producer: ADD R1, R2, R3", 10, 0
    consumer db "Consumer: SUB R4, R1, R5", 10, 0

    result_msg db "ADD calculates R1 = R2 + R3", 10, 0
    hazard_msg db "RAW HAZARD: SUB needs R1 before ADD writes it!", 10, 0

    values_msg db "R2 = %d, R3 = %d", 10, 0
    r1_msg db "New R1 value = %d", 10, 0

section .text

_main:

    ; Display title
    push title
    call _printf
    add esp, 4

    ; Display producer
    push producer
    call _printf
    add esp, 4

    ; Display consumer
    push consumer
    call _printf
    add esp, 4

    ; -----------------------------------------
    ; Initialize registers
    ; -----------------------------------------

    mov eax, 10          ; R2 = 10
    mov ebx, 20          ; R3 = 20
    mov ecx, 0           ; R1 initially contains old value

    ; Display values
    push ebx
    push eax
    push values_msg
    call _printf
    add esp, 12

    ; -----------------------------------------
    ; PRODUCER
    ; ADD R1, R2, R3
    ;
    ; R1 = R2 + R3
    ; R1 = 10 + 20 = 30
    ; -----------------------------------------

    add eax, ebx

    ; Now EAX contains the new R1 value
    ; In a real CPU pipeline, this result
    ; would be written during WB.

    push eax
    push r1_msg
    call _printf
    add esp, 8

    ; -----------------------------------------
    ; RAW HAZARD
    ; -----------------------------------------

    push hazard_msg
    call _printf
    add esp, 4

    ; -----------------------------------------
    ; Consumer
    ; SUB R4, R1, R5
    ;
    ; R4 = R1 - R5
    ; -----------------------------------------

    mov edx, 5           ; R5 = 5
    sub eax, edx         ; R4 = R1 - R5

    ; Exit
    xor eax, eax
    ret