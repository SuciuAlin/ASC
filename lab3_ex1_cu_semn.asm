;(c+b+a) - (d+d)
bits 32
global start

extern exit
import exit msvcrt.dll

segment data use 32 class = data
    a db 3
    b dw 7
    c dd 10
    d dq 15
    
segment code use 32 class = code
start:
    mov eax, 0
    mov ax, word[b]
    cwde
    add eax, dword[c]
    mov ebx, eax; ebx = b+c
    mov al, byte[a]
    cbw
    cwde
    add eax, ebx; eax = b+c+a
    cdq;edx:eax
    
    ;mutat d in ecx:ebx
    ;ecx = ultima parte din d
    ;ebx prima parte din d
    mov ebx,[d+0]
    mov ecx,[d+4]
    
    add ebx,ebx  
    adc ecx,ecx ;ecx:ebx = d+d
    
    ;(b+c+a)-(d+d)
    sub eax,ebx
    sbb edx,ecx
    
   
    

    push dword 0
    call [exit]
