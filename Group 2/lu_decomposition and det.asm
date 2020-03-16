%include "io.inc"
section .data
A:  dd  1.0,2.0,3.0
    dd  4.0,5.0,6.0
    dd  3.0,8.0,9.0
l:  times 9 dd  0
u:  times 9 dd  0
i:  dd  0
j:  dd  0
k:  dd  0
n:  dd  3
det: dd 0.0
result: db "|A| = %0.3f" , 10 , 0
msg: db "%0.3f" , 9 , 0
newline: db "" , 10 , 0
section .text
extern printf
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ecx , [n]
    for1:
    cmp [i] , ecx
    jge done1
    
    
    mov dword [j] , 0
    for3:
    cmp [j] , ecx
    jge done3
    
    
    mov ebx , [j]
    cmp ebx , [i]
    jg upper
    jl lower
    jmp diagonal
    
    inc dword [j]
    jmp for3
    done3:
    
    
    inc dword [i]
    jmp for1
    done1:
    xor ecx , ecx
    mov ebx , [n]
    forli:
    cmp ecx , ebx
    jnl doneli
    
    mov eax , ecx
    mov esi , ecx
    push ecx
    
    xor ecx , ecx
    forlj:
    cmp ecx, ebx
    jnl donelj
    
    mul ebx
    add eax , ecx
    pushad
    finit
    fld dword [l + 4 * eax]
    sub esp , 8
    fstp qword [esp]
    push msg
    call printf
    add esp , 12
    popad
    mov eax, esi
    inc ecx
    jmp forlj
    donelj:
    pop ecx
    
    pushad
    push newline
    call printf
    add esp, 4
    popad
    
    inc ecx
    jmp forli
    doneli:
    
    push newline
    call printf
    add esp , 4
    
    push newline
    call printf
    add esp , 4
    
    mov ebx, [n]
    xor ecx, ecx
    forui:
    cmp ecx , ebx
    jnl doneui
    
    mov eax , ecx
    mov esi , ecx
    push ecx
    
    xor ecx , ecx
    foruj:
    cmp ecx, ebx
    jnl doneuj
    
    mul ebx
    add eax , ecx
    pushad
    finit
    fld dword [u + 4 * eax]
    sub esp , 8
    fstp qword [esp]
    push msg
    call printf
    add esp , 12
    popad
    mov eax, esi
    inc ecx
    jmp foruj
    doneuj:
    pop ecx
    
    pushad
    push newline
    call printf
    add esp, 4
    popad
    
    inc ecx
    jmp forui
    
    
    doneui:
    xor ecx , ecx
    mov ebx , [n]
    finit
    fld1
    fordet:
    cmp ecx , ebx
    jge donedet
    
    mov eax , ebx
    mul ecx
    add eax,  ecx
    
    fmul dword [u + 4 * eax]
    
    inc ecx
    jmp fordet
    donedet:
    push newline
    call printf
    add esp, 4
    
    fst dword [det]
    sub esp , 8
    fstp qword [esp]
    push result
    call printf
    add esp , 12
    
    ret
    
    
    
    
    diagonal:
    finit
    fldz
    mov esi , [i]
    mov dword[k] , 0
    for2:

    cmp [k] , esi
    jge done2
    
    mov eax , [n]
    mul dword [i]
    add eax , [k]
    fld dword [l + 4*eax]

    mov eax , [n]
    mul dword [k]
    add eax , [i]
    fmul dword [u +4*eax]    
    faddp
    
    
    
    inc dword [k]
    jmp for2
    done2:
    
    fld1
    mov eax , [n]
    mul dword [i]
    add eax , [i]
    fstp dword [l +4*eax]
    
    fld dword [A + 4*eax]
    fsub st0 ,st1
    fstp dword [u + 4* eax]

    inc dword [j]
    jmp for3
    
    
    
    upper:
        
    finit
    fldz
    mov dword [k] , 0
    mov esi , [i]
    
    for4:
    cmp [k] , esi
    jge done4
    
    mov eax , [n]
    mul dword [i]
    add eax , [k]
    fld dword [l + 4*eax]

    mov eax , [n]
    mul dword [k]
    add eax , [j]
    fmul dword [u +4*eax]   
    faddp
    
    inc dword [k]
    jmp for4
    done4:
    mov eax , [n]
    mul dword [i]
    add eax , [j]
    fld dword [A + 4*eax]
    fsub st0 , st1
    mov eax , [n]
    mul dword [i]
    add eax , [j]
    fstp dword [u + 4 *eax]
    finit
    
    inc dword [j]
    jmp for3
    
    
    
    lower:
    
    finit
    fldz
    
    mov dword [k] , 0
    mov esi , [j]
    for6:
    cmp [k] , esi
    jge done6
    
    mov eax , [n]
    mul dword [i]
    add eax , [k]
    fld dword [l + 4*eax]

    mov eax , [n]
    mul dword [k]
    add eax , [j]
    fmul dword [u +4*eax]  
    faddp
    
    inc dword [k]
    jmp for6
    done6:
    mov eax , [n]
    mul dword [i]
    add eax , [j]
    fld dword [A + 4*eax]
    fsub st0 , st1
    
    mov eax , [n]
    mul dword [j]
    add eax , [j]
    fdiv dword [u + 4*eax]
    
    mov eax , [n]
    mul dword [i]
    add eax , [j]
    
    fstp dword [l + 4 *eax]
    
    inc dword [j]
    jmp for3

    