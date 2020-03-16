%include "io.inc"
extern _printf
section .data
M:dd 3.2,2.1,7.1,4.2,-8.0,3.2,7.1,2.1,3.2
N:dd ($-M)/4
Mode:dd 0.0
count:dd 0
a:dd 0.0
b:dd 0.0
format:db "Mode=%f",0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax,[N]
    xor esi,esi
    
next:
    finit    
    xor ecx,ecx
    xor edi,edi
    fld dword[M+esi*4]
label1: 
    cmp ecx,eax
    jge done  
    fld dword[M+ecx*4]
    fcomi st1
    je label2
    inc ecx
    fstp dword[b]
    jmp label1
label2:
    inc edi
    inc ecx  
    fstp dword[a]
    jmp label1
done:
    cmp edi,[count]
    jg label3
label3:  
    fst dword[Mode]  
    mov [count],edi
    inc esi
    cmp esi,eax
    jge done2
    jmp next
done2: 
     sub esp,8
     fstp qword[esp]
     push format
     call _printf
     add esp,12   
    ret