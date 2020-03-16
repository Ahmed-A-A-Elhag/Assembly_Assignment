%include "io.inc"
extern _printf
section .data
a:dd 2.0
b:dd -5.0
c:dd -9.0
x_l:dd 0.0
x_u:dd 4.0
x_r:dd 0.0
x_r_odd:dd 0.0

f_x_l:dd 0.0
f_x_u:dd 0.0
f_x_r:dd 0.0
two:dd 2.0
zero:dd 0.0
E_a:dd 0.0000001
k:dd 0.0
error:dd 0.0
v:dd 5.0
g:dd 100.0
count: dd 1000
form:db "the number of iteration is more than maximum number of iterations allowed",0
format:db "f(x)=5*x^3+2*x^2-5*x-9   ,x1=%f",0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor ecx,ecx
next:
    inc ecx
    cmp ecx,[count]
    je stop
    push ecx
    finit  
    fld dword[x_r]
    fstp dword[x_r_odd] 
    fld dword[x_l]
    sub esp,4
    fst dword[esp]
    call f_x
    add esp,4
    fstp dword[f_x_l]
    fld dword[x_u]
    sub esp,4
    fst dword[esp]
    call f_x
    add esp,4
    fstp dword[f_x_u]
    fld dword[x_l]
    fsub dword[x_u]
    fstp dword[x_r]
    fld dword[f_x_l]
    fsub dword[f_x_u]
    fdiv dword[x_r]
    fstp dword[x_r]
    fld dword[x_u]
    fld dword[f_x_u]
    fdiv dword[x_r]
    fsub
    fst dword[x_r]
    sub esp,4
    fstp dword[esp]
    call f_x
    add esp ,4
    fstp dword[f_x_r]
    
    fld dword[f_x_l]
    fmul dword[f_x_r]
    fld dword[zero]
    fcomi st1
    je done
    fcomi st1
    ja label1
    fld dword[x_r]
    fst dword[x_l] 
    fsub dword[x_r_odd]
    fdiv dword[x_r]
    fmul dword[g]
    fabs
    fst dword[error]
    fld dword[E_a]
    fcomi st1
    ja done
    pop ecx
    jmp next
label1:
    fld dword[x_r]
    fst dword[x_u] 
    fsub dword[x_r_odd]
    fdiv dword[x_r]
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
    fld dword[x_r]
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