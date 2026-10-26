; Task 15: 50,000 repeated stores vs dispersed stores.
default rel
extern printf
global main
section .data
fmt db "Repeated stores: final=%d; dispersed stores: checksum=%d. Actual bus stalls need hardware counters.",10,0
section .bss
alignb 64
hot resd 1
cold resd 50000
section .text
main:
    push rbp
    mov rbp, rsp
    xor ecx, ecx
.repeat:
    mov [hot], ecx
    inc ecx
    cmp ecx, 50000
    jl .repeat
    lea rdi, [cold]
    xor ecx, ecx
.dispersed:
    mov [rdi+rcx*4], ecx
    inc ecx
    cmp ecx, 50000
    jl .dispersed
    mov edx, [hot]
    xor r8d, r8d
    xor ecx, ecx
.sum:
    add r8d, [rdi+rcx*4]
    inc ecx
    cmp ecx, 50000
    jl .sum
    lea rcx, [fmt]
    ; format args: final and checksum
    mov r9d, r8d
    mov r8d, edx
    ; printf has RCX fmt, RDX arg1, R8 arg2
    mov edx, r8d
    mov r8d, r9d
    call printf
    xor eax, eax
    pop rbp
    ret
