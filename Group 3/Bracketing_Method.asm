%include "io.inc"
extern _printf
section .data
a:dd 2.0
b:dd -5.0
c:dd -9.0
x_l:dd 0.0
x_u:dd 4.0
x_m:dd 0.0
x_m_odd:dd 0.0
f_x_m:dd 0.0
f_x_l:dd 0.0
two:dd 2.0
zero:dd 0.0
E_a:dd 0.0000001
k:dd 0.0
error:dd 0.0
v:dd 5.0
g:dd 100.0
count: dd 1000
form:db "the number of iteration is more than maximum number of iterations allowed",0
format:db "f(x)=x^3+2*x^2-5*x-9   ,x1=%f",0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ecx,-1
next:    
    inc ecx
    cmp ecx,[count]
    je stop
    push ecx
    finit
    fld dword[x_m]
    fstp dword[x_m_odd]
    fld dword[x_l]
    fadd dword[x_u]
    fdiv dword[two]
    fst dword[x_m]
    sub esp,4
    fst dword[esp]
    call f_x
    add esp,4
    fstp dword[f_x_m]
    fld dword[x_l]
    sub esp,4
    fst dword[esp]
    call f_x
    add esp,4
    fst dword[f_x_l]
    fmul dword[f_x_m]
    fld dword[zero]
    fcomi st1
    je done
    fcomi st1
    ja label1
    fld dword[x_m]
    fst dword[x_l] 
    fsub dword[x_m_odd]
    fdiv dword[x_m]
    fmul dword[g]
    fabs
    fst dword[error]
    fld dword[E_a]
    fcomi st1
    ja done
    pop ecx
    jmp next
label1:
    fld dword[x_m]
    fst dword[x_u] 
    fsub dword[x_m_odd]
    fdiv dword[x_m]
    fmul dword[g]
    fabs
    fst dword[error]
    fld dword[E_a]
    fcomi st1
    ja done
    pop ecx
    jmp next
stop:
    push form
    call printf
    add esp,4     
done:
    pop ecx
    fld dword[x_m]
    sub esp,8
    fstp qword[esp]
    push format
    call _printf
    add esp,12
    ret
    
f_x:
   ;f(x)=5*x^3+2*x^2-5*x-9
   finit
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