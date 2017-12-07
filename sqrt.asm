; SQUARE ROOT OF A NUMBER
; Newton's algorithm
; new_appx = (old_appx + (N/old_appx))
; continue doing untill new_appx == old_appx

.model small
.stack 100h
.data
.code
    main:

        mov ax, @data
        mov ds, ax ; set ds to be a pointer to data segment

        stid equ 464h
        mov bx, 1 ; bx is the old apprx, set it to 1
        
    sqrtloop:
        mov dx, 0
        mov ax, stid ; keep N in ax
        div bx ; (N/old_appx)
        add ax, bx ; (old_appx + (N/old_appx))
        shr ax, 1 ; divide by 2
        
        ;cmp dx, bx ; compare old appx with new appx
        ;je result ; if equal go to result
        ;jmp sqrtloop ; else loop again

    result:

        mov dx, ax
        mov ah, 02h
        int 21h

        mov ah, 4ch	; setup to terminate program and
        int 21h	; return to the DOC prompt
        
        end main