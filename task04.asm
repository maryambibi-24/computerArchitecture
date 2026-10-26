; Task 4: Row-major vs column-major traversal of 256x256 32-bit matrix.
default rel
extern printf
global main
section .data
fmt db "%s: sum=%lld",10,0
rowmsg db "Row-major",0
colmsg db "Column-major",0
section .bss
alignb 64
mat resd 65536
section .text
main:
    push rbp
    mov rbp, rsp
    lea rdi, [mat]
    xor ecx, ecx
.init:
    mov [rdi+rcx*4], ecx
    inc ecx
    cmp ecx, 65536
    jl .init
    ; row-major
    xor r8, r8
    xor ecx, ecx
.rloop:
    movsxd rax, dword [rdi+rcx*4]
    add r8, rax
    inc ecx
    cmp ecx, 65536
    jl .rloop
    lea rcx, [fmt]
    lea rdx, [rowmsg]
    mov r9, r8
    mov r8, r9
    ; printf("%s: sum=%lld", rowmsg, sum): RCX format, RDX string, R8 sum
    call printf
    ; column-major
    xor r8, r8
    xor r10d, r10d
.col:
    xor r11d, r11d
.inner:
    mov eax, r10d
    shl eax, 8
    add eax, r11d
    movsxd rax, dword [rdi+rax*4]
    add r8, rax
    inc r11d
    cmp r11d, 256
    jl .inner
    inc r10d
    cmp r10d, 256
    jl .col
    lea rcx, [fmt]
    lea rdx, [colmsg]
    mov r9, r8
    mov r8, r9
    call printf
    xor eax, eax
    pop rbp
    ret
