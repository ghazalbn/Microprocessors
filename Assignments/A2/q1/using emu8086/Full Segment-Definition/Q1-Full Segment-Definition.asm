
;Q1 using FULL SEGMENT DEFINITION

STSEG   SEGMENT
DB 64   DUP (?)
STSEG   ENDS
;--------------------------------------------------
DTSEG   SEGMENT
DATA1   DB 90H          ;number 1
DATA2   DB 12H          ;number 2
MULT    DW 0            ;multiplication of two numbers will be stored in MULT
DTSEG   ENDS
;--------------------------------------------------
CDSEG   SEGMENT
MAIN    PROC FAR        ;program entry point
        ASSUME CS:CDSEG,DS:DTSEG,SS:STSEG
        MOV AX,DTSEG    ;load the data segment address 
        MOV DS, AX  
        
        MOV AH, 0
        MOV AL,DATA1 
        MOV BL,DATA2 
        
LOP:    ADD MULT, AX
        DEC BL          ;decrement BL and update the flag register ZF
        JNZ LOP  
        
        MOV AH,4CH      ;set up to
        INT 21H         ;return to the DOS
MAIN    ENDP
CDSEG   ENDS
        END MAIN        ;program exit point
