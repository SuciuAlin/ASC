;Se da un sir de dublucuvinte. Sa se obtina sirul format din octetii superiori ai 
;cuvitelor superioare din elementele sirului de dublucuvinte care sunt divizibili cu 3.
;Exemplu:

;Se da sirul de dublucuvinte:
;s DD 12345678h, 1A2B3C4Dh, FE98DC76h
;Sa se obtina sirul
;d DB 12h.


bits 32 
global start        

extern exit               
import exit msvcrt.dll   
segment data use32 class=data
    s dd 12345678h, 1A2B3C4Dh, 0FE98DC76h
    ls equ $ - s
    d times ls resb 0

segment code use32 class=code
start:
    mov esi,3
    mov ecx,ls/4
    mov edi,0
    Repeta:
        mov al, [s+esi]
        cbw
        mov bl, 3
        idiv bl
        
        cmp ah,0
        je Divizibil ; octetul se divide cu 3
        jmp PesteDivizibilitate
    
        Divizibil:
            mov al, [s+esi]
            mov [d+edi],al
            inc edi
        
        PesteDivizibilitate:
        add esi,4
    
    loop Repeta
        
push    dword 0      
call    [exit]       
