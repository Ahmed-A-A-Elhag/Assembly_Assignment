%include "io.inc"
extern _printf
section .data
M:dd 3.2,2.1,7.1,4.2,-8.0
N:dd ($-M)/4
M2:dd 0.0,0.0 ,0.0,0.0,0.0
Median:dd 0.0
two:dd 2
format:db "Median=%f",0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax ,[N]
    xor ecx,ecx
label1:    
    fld dword[M+ecx*4]
    fstp dword[M2+ecx*4]
    inc ecx
    cmp ecx,eax
    jl label1
    mov edi,-1
label2: 
    inc edi
    cmp edi,eax
    jge done
    mov ecx,edi
label3:
    finit  
    fld dword[M2+edi*4]
    inc ecx
    cmp ecx,eax
    jge label2 
    fld dword[M2+ecx*4]
    fcomi st1
    jb label4
    jmp label3

     
label4:
    fstp dword[M2+edi*4] 
    fstp dword[M2+ecx*4]
    jmp label3
    
done:
    finit
    mov esi,eax
    and esi,1
    jz label5
    dec eax  
    mov edi,2
    div edi
    fld dword[M2+eax*4]
    jmp done2
label5:
    mov edi,2
    div edi
    fld dword[M2+eax*4]
    dec eax
    fadd dword[M2+eax*4]
    fidiv dword[two]
 
done2:   
    fst dword[Median]
    sub esp,8
    fstp qword[esp]
    push format
    call _printf
    add esp,12  
    ret