; SQUARE ROOT OF A NUMBER
; Newton's algorithm
; new_appx = (old_appx + (N/old_appx))
; continue doing untill new_appx == old_appx

.model small

.stack 100h

.data
    stid dw 0464H 

.code
    start:

        mov ax, @data
        mov ds, ax ; set ds to be a pointer to data segment
        
    sqrt:
        mov bx, 01h
        
    sqrtloop:
        
        mov dx, bx ; dx becomes the old apprx
        mov cx, stid ; keep N in cx
        
        mov ax, cx
        div bx ; divide N by old_appx
        mov cx, ax
        
        add bx, cx ; (old_appx + (N/old_appx))
        
        mov ax, bx
        mov cx, 02h
        div cx ; (old_appx + (N/old_appx))/2
        mov bx, ax
        
        cmp dx, bx ; compare old appx with new appx
        je result ; if equal go to result
        jmp sqrtloop ; else loop again

    result:
        mov ah, 02h
        mov dx, bx
        int 21h
        
        end start