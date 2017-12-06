; SQUARE ROOT OF A NUMBER
; Newton's algorithm
; new_appx = (old_appx + (N/old_appx))/2
; continue doing untill new_appx == old_appx

.model small

.stack 100h

.data
    stid dw 0464H 

.code
    start:

        mov ax, @data
        mov ds, ax ; set ds to be a pointer to data segment
        
        mov ah, 02h ; 02h is for printing chars
        mov dx, stid
        int 21h ; prints 'd' on the screen, ascii code - 64h

        end start