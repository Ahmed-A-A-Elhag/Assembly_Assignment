%include "io.inc"
extern _printf
section .data
M:dd 2.1,3.2,4.2,7.1
N:dd ($-M)/4
squre:dd 0.0
Average:dd 0.0
standard_deviation:dd 0.0
format:db "standard deviation=%f",0
section .text
global CMAIN
CMAIN:
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
    fstp dword[Average]
    xor ecx,ecx
    
    
label2: 
    fld dword[M+ecx*4]  
    fsub dword[Average]
    fst dword[squre]
    fmul dword[squre]
    fadd dword[standard_deviation]
    fstp dword[standard_deviation]
    inc ecx 
    cmp ecx,eax
    jl label2
    
    fld dword[standard_deviation]
    fidiv dword[N]
    fst dword[standard_deviation]
    sub esp,8
    fst qword[esp]
    push format
    call _printf
    add esp,12
    ret