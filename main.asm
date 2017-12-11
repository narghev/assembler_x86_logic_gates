.model small
.stack 100h
.data
    new_appx dw ?
    sqrt_result db ?

.code   

    main:
        mov ax, @data
        mov ds, ax          ; set ds to be a pointer to data segment

        stid equ 464h
        mov bx, 1           ; bx is the old apprx, set it to 1

        call sqrtloop       ; calculate sqrt_result
        mov al, sqrt_result ; keep the value in al

        mov bh, 00000000b   ; prepare backup register
        call _nor           ; call custom nor
        call back_up        ; save the result
        shr al, 2           ; remove the bits that are used in _nor
        mov bl, al
        and bl, 00000001b
        call back_up
        and al, 11111110b
        mov bl, al
        shr bl, 1
        and bl, 00000001b
        or al, bl
        call _nand
        call back_up
        shr al, 2
        call _xor
        call back_up
        shr al, 2
        call _nand
        call back_up


        mov al, bh
        mov bh, 00000000b
        call _xor
        and al, 11111110b
        or al, ah
        call _not
        call back_up
        shr al, 1
        mov bl, al
        and bl, 00000001b
        call back_up
        shr al, 1
        mov bl, al
        and bl, 00000001b
        call back_up
        shr al, 1
        call _nand
        call back_up
        mov al, bh
        call _or
        shr al, 2
        shl al, 1
        or al, ah
        call _nand
        shr al, 2
        shl al, 1
        or al, ah
        call _nand

        jmp result          ; print the result
    
    back_up:
        shl bh, 1           ; shift left
        or bh, bl           ; add the new result to the backed up result
        ret

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
        mov sqrt_result, bl ; keep the result
        ret                 ; return

    _nand:
        mov bl, al          ; copy of input bits into BL
        mov cl, al          ; and another in CL
        and bl, 00000001b   ; mask off all bits except input bit 0
        and cl, 00000010b   ; mask off all bits except input bit 1
        shr cl, 1           ; move bit 1 value into bit 0 of CL register
        
        and bl, cl          ; AND these two registers, result in BL
        not bl              ; invert bits for the not part of nand
        and bl, 00000001b   ; clear all upper bits positions leaving bit 0 either a zero or one 
        
        mov ah, bl          ; copy answer into return value register
        ret                 ; uncomment for subroutine

    _nor:
        mov bl, al          ; copy of input bits into BL
        mov cl, al          ; and another in CL
        and bl, 00000001b   ; mask off all bits except input bit 0
        and cl, 00000010b   ; mask off all bits except input bit 1
        shr cl, 1           ; move bit 1 value into bit 0 of CL register
        
        or bl, cl           ; OR these two registers, result in BL
        not bl              ; invert bits for the not part of nor
        and bl, 00000001b   ; clear all upper bits positions leaving bit 0 either a zero or one 
        
        mov ah, bl          ; copy answer into return value register
        ret                 ; uncomment for subroutine

    _or:
        mov bl, al           ; copy of input bits into BL
        mov cl, al           ; and another in CL

        and bl, 00000001b   ; mask off all bits except input bit 0
        and cl, 00000010b   ; mask off all bits except input bit 1
        
        shr cl,1            ; move bit 1 value into bit 0 of CL register
        or bl, cl           ; AND these two registers, result in BL
        and bl, 00000001b   ; clear all upper bits positions leaving bit 0 either a zero or one

        mov ah, bl          ; copy answer into return value register
        ret                 ; uncomment for subroutine

    _xor:
        mov bl, al           ; copy of input bits into BL
        mov cl, al           ; and another in CL
        and bl, 00000001b   ; mask off all bits except input bit 0
        and cl, 00000010b   ; mask off all bits except input bit 1
        shr cl, 1            ; move bit 1 value into bit 0 of CL register
                            ; now we have the binary value of each bit in BL and CL, in bit 0 location
        xor bl, cl           ; AND these two registers, result in BL
        and bl, 00000001b   ; clear all upper bits positions leaving bit 0 either a zero or one

        mov ah, bl          ; copy answer into return value register
        ret                 ; uncomment for subroutine
    
    _not:
        mov bl, al           ; copy of input bits into BL
        and bl, 00000001b   ; mask off all bits except input bit 0
        not bl
        and bl, 00000001b   ; clear all upper bits positions leaving bit 0 either a zero or one

        mov ah, bl          ; copy answer into return value register
        ret                 ; uncomment for subroutine

    result:
        mov dl, ah
        add dx, 30h
        mov ah, 02h
        int 21h

        mov ah, 4ch	        ; setup to terminate program and
        int 21h	            ; return to the DOC prompt
        
        end main