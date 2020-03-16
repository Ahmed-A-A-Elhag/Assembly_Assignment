%include "io.inc"
extern _printf
section .data
M:dd 2.1,3.2,4.2,7.1
N:dd ($-M)/4
Average:dd 0.0
format:db "Average=%f",0
section .text
global CMAIN
CMAIN:
    ;p/f $st0
    mov ebp, esp; for correct debugging
    mov eax,[N]
    xor ecx,ecx
    finit
    fld dword[M+ecx*4]
label:
    inc ecx
    cmp ecx,eax
    jge done
    fadd dword[M+ecx*4]
    jmp label
done:
    fidiv dword[N]
    fst dword[Average]
    sub esp,8
    fst qword[esp]
    push format
    call _printf
    add esp,12     
    ret