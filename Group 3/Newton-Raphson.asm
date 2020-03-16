%include "io.inc"
extern _printf
section .data
a:dd 2.0
b:dd -5.0
c:dd -9.0
d:dd 3.0
x_i:dd 7.0
x_i_new: dd 0.0
f_x_i:dd 0.0
f_x_i_driv:dd 0.0
two:dd 2.0
zero:dd 0.0
E_a:dd 0.0000001
k:dd 0.0
error:dd 0.0
v:dd 5.0
g:dd 100.0
count: dd 1000
epsilon: dd 0.000001
form:db "the number of iteration is more than maximum number of iterations allowed",0
format:db "f(x)=5*x^3+2*x^2-5*x-9   ,x1=%f",0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    xor ecx, ecx
next:
    inc ecx
    cmp ecx,[count]
    je stop
    push ecx
    finit  
    fld dword[x_i]
    sub esp,4
    fstp dword[esp]
    call f_x
    add esp,4
    fstp dword[f_x_i]
    
    fld dword[x_i]
    fadd dword[epsilon]
    sub esp,4
    fstp dword[esp]
    call f_x
    add esp,4
    fsub dword[f_x_i]
    fdiv dword[epsilon]
    fstp dword[f_x_i_driv]
    
    
    fld dword[x_i]
    fld dword[f_x_i]
    fdiv dword[f_x_i_driv]
    fsub
    fst dword[x_i_new]
    sub esp,4
    fstp dword[esp]
    call f_x
    add esp,4
    fld dword[zero]
    fcomi st1
    je done
    fld dword[x_i_new]
    fsub dword[x_i]
    fdiv dword[x_i_new]
    fmul dword[g]
    fabs
    fst dword[error]
    fld dword[E_a]
    fcomi st1
    ja done
    pop ecx
    fld dword[x_i_new]
    fstp dword[x_i]
    jmp next
stop:
    push form
    call printf
    add esp,4   
done:
    pop ecx
    fld dword[x_i_new]
    sub esp,8
    fstp qword[esp]
    push format
    call _printf
    add esp,12    
    ret
    
f_x:
   ;f(x)=5*x^3+2*x^2-5*x-9
   fld dword[esp+4]
   fmul dword[esp+4]
   fmul dword[esp+4]
   fmul dword[v]
   fld dword[esp+4]
   fmul dword[esp+4]
   fmul dword[a]
   fadd
   fld dword[esp+4]
   fmul dword[b]
   fadd
   fadd dword[c]
   ret
