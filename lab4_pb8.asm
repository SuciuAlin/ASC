;Se dau doua cuvinte A si B. Sa se obtina un octet C care are:
;pe bitii 0-5, bitii 5-10 ai cuvantului A
;pe bitii 6-7 bitii 1-2 ai cuvantului B.
;Sa se obtina dublucuvantul D care are :
;pe bitii 8-15, bitii lui C
;pe bitii 0-7, bitii 8-15 din B
;pe bitii 24-31, bitii 0-7 din A
;iar pe bitii 16-23, bitii 8-15 din A


bits 32
bits 32 ; assembling for the 32 bits architecture
global start
extern exit
import exit msvcrt.dll

segment data use32 class = data
    A dw 1010111110000001b
    B dw 1111000010101010b
    C db 0
    D dd 0

segment code use32 class = code
    start:
    mov ax,[A] ;1010111110000001b = AF81h
    mov cl,5
    shr ax,cl;ax = 00000a15a14a13a12a11a10a9a8a7a6a5
             ;ax = 0000010101111100b = 057Ch
    and al,00111111b; al = 00a10a9a8a7a6a5
                    ; al = 00111100b = 3Ch
    or byte[C],al; C = 00a10a9a8a7a6a5
                 ; C = 00111100b = 3Ch
    
    mov ax,[B]; ax = 1111000010101010b = F0AAh
    mov cl,5
    shl ax,cl;ax = b10b9b8b7b6b5b4b3 b2b1b000000
             ;ax = 0001010101000000b = 1540h
    and al, 11000000b; b2b1000000
                     ; al = 01000000b = 40h
    or byte[C],al; C = b2b1a10a9a8a7a6a5
                 ; C = 01111100b = 7Ch 
    
    mov eax,0
    mov ax,[A] ;1010111110000001b = AF81h
    mov cl,8
    shl eax,cl; bitii 0-7 din A pe poz8-15 in eax 
              ;si bitii 8-15 din A pe poz16-23(dar se vor pierde in urma operatiilor)
              ; 00000000 1010111110000001 00000000b = 00Af8100h
    mov bx,[A]; 1010111110000001b = AF81h                 
    shr bx,cl; bitii 8-15 din A pe poz 0-8 in bx
             ; bx = 0000000010101111b = 00AFh
    mov al,bl; al = 10101111b = AFh
    shl eax, cl; eax = 10101111100000011010111100000000b = Af81Af00h
    mov al,[C]; al = 01111100b = 7Ch 
    shl eax, cl; bitii 0-7 pe 24-31, bitii 8-15 pe 16-23, bitii lui C pe 8-15
               ; eax = 10000001101011110111110000000000b = 81Af7C00h
    mov bx,[B] ; bx = 1111000010101010b = F0AAh
    shr bx,cl  ; bx = 0000000011110000b = 00F0b
    mov al, bl ; al = 11110000b = F0h
        ;eax devine 10101111100000011010111111110000b = 81AF7CF0h
    mov dword[D], eax
    
    
    
    push dword 0
    call [exit]
