; SQUARE ROOT OF A NUMBER
MODEL SMALL
    .STACK 100
    .DATA
        STID DW 464H ; Initialize num1 to 0019
        SQRT DW 01 DUP (?) ; Reserve 1 word of uninitialised data space to offset sqrt
    .CODE ; Code segment starts
        START:
            MOV AX, @DATA ;Initialize data segment
            MOV DS, AX
            MOV AX, 0001H ;Initialize BX to 0001H
            MOV CX, 0001H ;Initialize CX to 0001H
        LOOP1:
            LEA DX, AX		; that the value entered
            INT 21H		; is a prime by a DOS console out of NL2 ASCII string
            CMP STID, AX
            JG RESULT
            INC CX
            MUL AX



            ;SUB AX, BX ;AX=AX-BX
            ;JZ LOOP2 ; If zero flag is zero jump to loop2
            ;INC CX ; Increment CX by 1
            ;ADD BX, 0002H ;BX=BX+0002H
            ;JMP LOOP1 ; Jump to loop1
        RESULT:
            END START
