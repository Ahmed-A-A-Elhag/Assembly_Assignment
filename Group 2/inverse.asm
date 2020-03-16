%include "io.inc"
section .data
m: dd 3
a: dd 1.0,2.0,9.0,0.0,1.0,3.0,0.0,0.0,1.0
u:times(9) dd 0.0
l: dd 0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0
sum: dd 0.0
sum1: dd 0.0
one: dd 1.0
h:dd 0.0
o:dd 0.0
uin: dd 1.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,1.0
v1: dd 0.0
v3:dd 0.0
v4: dd 0.0
v5: dd 0.0
lin:times(9) dd 0.0
ain: times(9) dd 0.0
section .text
global CMAIN
CMAIN:
mov ebp, esp; for correct debugging
    xor edi,edi
    lop1:
    cmp edi,[m]
    jge d
    mov ebx ,edi
   
    lop2:
    cmp ebx ,[m]
    jge f 
    cmp edi,ebx
    jne lop3
    mov eax,[m]
    mul ebx
    add eax,ebx
    fld dword[one]
    fstp dword [l+4*eax]
    inc ebx 
    jmp lop2
   
    lop3:
     fldz
    xor ecx,ecx
    lop4:
    cmp ecx,edi
    jge k
    mov eax,[m]
    mul ebx
    add eax,ecx
    fld dword[a+4*eax]
    mov eax,[m]
    mul ecx
    add eax,edi
    fld dword[a+4*eax]
    fmulp
    fadd
     fst dword[sum1]
    inc ecx
    jmp lop4
    k:
   
    mov eax,[m]
    mul ebx
    add eax,edi
    fld dword[a+ 4*eax]
    fsub dword[sum1]
   
   
    ;fst dword [a+ 4*eax]
    fstp dword [l+4*eax]
   
    inc ebx
    jmp lop2
    
    
    f:
    inc edi
    jmp lop1
    ;;u matrix
    
    
    
    d: 
    xor esi,esi
   loop1:
   cmp esi,[m]
   jge done
   mov edi,esi
   
   loop2:
   cmp edi,[m]
   jge q
   fldz;
   xor ebx,ebx
   loop3:
   cmp ebx,esi
   jge w
   finit
   mov eax,[m]
   mul esi
    add eax, ebx
   fld dword[a+4*eax]
   fstp dword[h]
   mov eax,[m]
   mul ebx
   add eax, edi
   fld dword[a+4*eax]
   fmul dword[h]
    fadd dword[sum]
 ;  fstp dword[o]
  
   fstp dword [sum]
   inc ebx
   jmp loop3
   
   w: 
   cmp edi, esi
   je lop5
   mov eax,[m]
   mul esi
   add eax,edi
   fld dword[a+4*eax]
   fsub dword [sum]
   mov eax,[m]
   mul esi
   add eax,esi
   fdiv dword[u+4*eax]
   mov eax,[m]
   mul esi
   add eax,edi
   
   ;fst dword[a+4*eax]
   fstp dword [u+4*eax]
   fldz
   fstp dword[sum]
   inc edi 
   jmp loop2
   lop5:
    mov eax,[m]
   mul esi
   add eax,edi
   fld dword[a+4*eax]
   fsub dword [sum]
  ; fst dword[a+4*eax]
   fstp dword [u+4*eax]
   fldz
   fstp dword[sum]
   inc edi 
   jmp loop2
  
    q:
    inc esi
    jmp loop1
    done:
    xor ebx,ebx
    lp0:
    cmp ebx,[m]
    jge continue
    mov eax,[m]
    mul ebx
    add eax,ebx
    fld dword[u+4*eax]
    fstp dword[v1]
   mov ecx,ebx
   
    lp1:
    cmp ecx,[m]
    jge incrementebx
    finit
    
    mov eax,[m]
    mul ebx
    add eax,ecx
    fld dword[uin+4*eax]
    fdiv dword[v1]
    fstp dword[uin+4*eax]
     mov eax,[m]
    mul ebx
    add eax,ecx
    fld dword[u+4*eax]
    fdiv dword[v1]
    fstp dword[u+4*eax]
    inc ecx 
    jmp lp1
    incrementebx:
    inc ebx
    jmp lp0
    
    
    continue:
    xor esi,esi
    lp2:
    cmp esi,[m]
    jge u1
    mov edi,esi
    inc edi
    lp3:
    cmp edi,[m]
    jge u2
     mov eax,[m]
    mul esi
    add eax,edi
    fld dword[u+4*eax]
    fstp dword[v3]
    mov ecx,edi
    lp4:
    cmp ecx,[m]
    jge u3
    finit
     mov eax,[m]
    mul edi
    add eax,ecx
    fld dword[u+4*eax]
    fmul dword[v3]
    fstp dword[v4]
    fld dword[uin+4*eax]
    fmul dword[v3]
   fstp dword[v5]
 mov eax,[m]
    mul esi
    add eax,ecx
    fld dword[u+4*eax]
    
    fsub dword[v4]
    
    fstp dword[u+4*eax]
    fld dword[uin+4*eax]
    
    fsub dword[v5]
    
    fstp dword[uin+4*eax]
    inc ecx 
    jmp lp4
    u3:
    inc edi
    jmp lp3
    u2:
    inc esi
    jmp lp2
    u1:
    xor ecx,ecx
    l1:
    cmp ecx,[m]
    jge a1
    mov ebx,ecx
    l2:
    cmp ebx,[m]
    jge a2
    cmp ebx,ecx
    jne a3
    mov eax,[m]
    mul ebx
    add eax,ecx
    fld dword[l+4*eax]
    fstp dword[lin+4*eax]
    inc ebx
    jmp l2
    
    a3:
    mov eax,[m]
    mul ebx
    add eax,ecx
    fld dword[l+4*eax]
    fchs
    fstp dword[lin+4*eax]
    inc ebx
    jmp l2
    
    a2:
    inc ecx
    jmp l1
    a1:
  xor ebx,ebx
    looop1:
    cmp ebx,[m]
    jge exit
   
   
    
   
    
    xor edi,edi
    looop2:
    cmp edi,[m]
    jge nextrow  

    
    
    xor ecx,ecx
fldz   
    looop3:
    XOR EAX,EAX
    cmp ecx,[m]
    jge loadsum
    mov eax ,[m]
    mul ebx
    add eax,ecx
    fld dword [uin + 4*eax]
   mov eax ,[m]
    mul ecx
    add eax,edi
    
    fld dword [lin + 4*eax]
    fmulp
    faddp 
    
    INC ECX
    JMP looop3
       
        
     loadsum:
    mov eax,[m]
    mul ebx
    add eax,edi
    fstp dword [ain + 4*eax]
    inc edi
    jmp looop2
     
   nextrow:
     
     inc ebx
     jmp looop1
     
     
     
     
      exit: 
    ret
    
    
    
    
    
    

    