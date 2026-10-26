; Task 18: Portable approximation of hot vs cold-ish access.
; Windows user-mode clflush/timing is CPU-dependent; this demonstrates repeated hot reads.
default rel
extern printf
global main
section .data
fmt db "hot repeated-load checksum=%d. For true RDTSC/CLFLUSH timing use a privileged/validated benchmark harness.",10,0
section .bss
alignb 64
sample resd 16
section .text
main:
    push rbp
    mov rbp, rsp
    mov dword [sample], 123
    xor ecx, ecx
    xor r8d, r8d
.loop:
    add r8d, [sample]
    inc ecx
    cmp ecx, 100000
    jl .loop
    lea rcx, [fmt]
    mov edx, r8d
    call printf
    xor eax, eax
    pop rbp
    ret
