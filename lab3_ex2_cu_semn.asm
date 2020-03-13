;c+(a*a-b+7)/(2+a), a-byte; b-doubleword; c-qword
bits 32
global start

extern exit
import exit msvcrt.dll

segment data use 32 class = data
    a db 3
    b dd 6
    c dq 3
    x dq 0
segment code use 32 class = code
    start:
    
    ;a*a
    mov al,byte[a]
    imul al
    cwde
    
    ;eax - b + 7
    sub eax,dword[b]
    add eax,7
    ;x = eax
    mov [x],eax
    
    ;bx = a+2
    mov al,byte[a]
    add al,2
    cbw 
    mov cx,ax
    
    ;dx = [x+2] ax = [x+0]
    mov dx,[x+2]
    mov ax,[x+0]
    
    idiv cx
    cwde
    cdq ;eax => edx:eax
    
    ;ecx:ebx ecx ultima parte din c, ebx prima parte din c
    ;e
    add eax,[c+0]
    adc edx,[c+4]
    
    
    
    
    
    
    
    push dword 0
    call [exit]