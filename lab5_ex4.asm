;Se dau doua siruri de octeti S1 si S2 de aceeasi lungime. Sa se construiasca sirul D astfel: fiecare element de pe pozitiile pare din D este suma elementelor de pe pozitiile corespunzatoare din S1 si S2, iar fiecare element de pe pozitiile impare are ca si valoare diferenta elementelor de pe pozitiile corespunzatoare din S1 si S2.
;pozitiile elementelor incep cu 0
;S1: 1, 2, 3, 4
;S2: 5, 6, 7, 8
;D: 6, -4, 10, -4

bits 32 ; assembling for the 32 bits architecture

global start        
extern exit               
import exit msvcrt.dll    


segment data use32 class=data
    S1 db 1,2,3,4
    S2 db 5,6,7,8
    ls equ $-S2
    D times ls db 0 

segment code use32 class=code
    start:
    
    mov esi,0
    mov ecx,ls
    Repeta:
        mov eax,esi
        cdq
        mov ebx, 2
        idiv ebx ; edx - rest
        mov al, [S1 + esi]
        mov [D + esi], al
        mov al, [S2 + esi]
        cmp edx,1;
        je impar
        par:
            add [D+esi], al
        
        jmp final
        impar:
            sub [D+esi], al
        
        final:
            mov al,[D+esi] ;debug
            add esi, 1
            
    loop Repeta 
    
    
        
        
    
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
