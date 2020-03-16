%include "io.inc"
section .data
MatA: dq 1.0,2.4,3.0,4.8
MatB: dq 3.4,1.0,2.0,1.0,3.0,7.8
MatC: times 1000 dq 0.0
M: dd 2
N: dd 2
P: dd 3
i: dd 0
j: dd 0
k: dd 0
String: db "MatC = MatA*MatB = ",10,0
formatStr: db "%.2f    ",0
newLine: db "",10,0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    finit
    xor ebx,ebx
    Mloop:
    xor ecx,ecx
    mov [j],ecx
    mov ecx,[i]
    mov eax,[N]
    cmp ecx,[M]
    jz print
    mul ecx
    inc ecx
    mov [i],ecx
    mov ebx,eax
    Ploop:
    finit
    xor ecx,ecx
    mov [k],ecx
    mov ecx,[j]
    cmp ecx,[P]
    jz Mloop
    mov eax,[P]
    mov edi,[i]
    dec edi
    mul edi
    add eax,ecx
    mov edi,eax
    fld qword[MatC+8*edi]
    inc ecx
    mov [j],ecx
    Nloop:
    mov eax,[P]
    mov ecx,[k]
    cmp ecx,[N]
    jz Ploop
    add ebx,ecx
    mul ecx
    add eax,[j]
    dec eax
    fld qword [MatA+8*ebx]
    fmul qword [MatB+8*eax]
    faddp
    fst qword[MatC+8*edi]
    sub ebx,ecx
    inc ecx
    mov [k],ecx
    jmp Nloop
      
    print:
    push String
    call _printf
    add esp,4
    xor ecx,ecx
    mov [i],ecx
    mov [j],ecx
    PL1:
    xor ecx,ecx
    mov [j],ecx
    mov ecx,[i]
    cmp ecx,[M]
    jz exit
    mov eax,[N]
    mul ecx
    pushad
    push newLine
    call _printf
    add esp,4
    popad
    inc ecx
    mov [i],ecx
    PL2:
    mov ecx,[j]
    cmp ecx,[P]
    jz PL1
    add eax ,ecx
    fld qword [MatC+8*eax]
    pushad
    sub esp,8
    fstp qword [esp]
    push formatStr
    call _printf
    add esp,12
    popad
    sub eax,ecx
    inc ecx
    mov [j],ecx
    jmp PL2
    
    exit:
    ret
    
    
    
    