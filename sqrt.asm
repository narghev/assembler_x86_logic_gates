; SQUARE ROOT OF A NUMBER
; Newton's algorithm
; new_appx = (old_appx + (N/old_appx))
; continue doing untill new_appx == old_appx

.model small
.stack 100h
.data
    new_appx dw ?
    sqrt_result dw ?

.code
    main:

        mov ax, @data
        mov ds, ax          ; set ds to be a pointer to data segment

        stid equ 464h
        mov bx, 1           ; bx is the old apprx, set it to 1
        
    sqrtloop:
        mov ax, stid        ; keep N in ax

        mov dx, 0           ; reset the remainder
        div bx              ; (N/old_appx)
        add ax, bx          ; (old_appx + (N/old_appx))
        shr ax, 1           ; divide by 2

        mov new_appx, ax    ; keeo the new apprxs
        xchg ax, bx         ; new, old = old, new
        sub new_appx, ax    ; new = new - old
        jns positive        ; if positive, jump to positive
        neg new_appx        ; else negetare then continue to positive section

    positive:
        cmp new_appx, 0     ; cpm new - old with 0
        ja sqrtloop         ; if new - old == 0, loop again
        mov sqrt_result, bx ; keep the result


    result:

        mov dx, sqrt_result
        mov ah, 02h
        int 21h

        mov ah, 4ch	        ; setup to terminate program and
        int 21h	            ; return to the DOC prompt
        
        end main