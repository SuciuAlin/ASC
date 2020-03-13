;Se dau doua siruri de caractere S1 si S2. Sa se construiasca sirul D ce contine toate elementele din S1 care nu apar in S2. 
;Exemplu:
;S1: '+', '4', '2', 'a', '8', '4', 'X', '5'
;S2: 'a', '4', '5'
;D: '+', '2', '8', 'X'

bits 32 

global start        

extern exit               
import exit msvcrt.dll   
segment data use32 class=data
    S1 db '+','4','2','a','8','4','x','5'
    lS1 equ $ - S1
    S2 db 'a','4','5'
    lS2 equ $ - S2
    D times lS1 resb 0

segment code use32 class=code
    start:
    mov ebp, 0; pt D
    mov esi, 0; pt S1
    mov ecx, lS1
       
    RepetaS1:
        mov edx, lS2
        mov edi, 0; pt S2
        
        RepetaS2:
            mov al, [S2 + edi]; eax <- elementele din S2
            inc edi
            cmp al,[S1 + esi]
            je Apare
            
            dec edx
        jnz RepetaS2
        mov bl,[S1 + esi]
        mov [D + ebp],bl
        inc ebp
        Apare:
        inc esi
        dec ecx
        jnz RepetaS1
    
    
        push    dword 0      
        call    [exit]       
