.model small
.stack 100h
.data
.code

    nand:
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