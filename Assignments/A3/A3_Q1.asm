;A3 Q1 Bakhshande


DATA SEGMENT
              
LEN DB 20D    ;tedade nomrat
GRADE DB 14H, 13H, 18H, 10H, 07H, 15H, 06H, 09H, 19H, 17H, 17H, 10H, 15H, 18H, 19H, 17H, 16H, 16H, 14H, 11H
MAX DB 20H
MEDIAN DB ?   ;miane
DIF DB ?      ;ekhtelafe nomreye max va adade 20
AVG1 DW 0     ;miangin ghabl az shifte nomrat
AVG2 DW 0     ;miangin baad az shifte nomrat

DATA ENDS

ASSUME CS:CODE,DS:DATA

CODE SEGMENT

START:  MOV AX,DATA
        MOV DS,AX
        MOV AH, 0
        MOV BH, 0
        
       
   SORT:MOV BL,LEN
        DEC BL
        
   INIT:MOV CL,BL
        MOV SI,00H
        
   LOP2:MOV AL,GRADE[SI]
        INC SI
        CMP AL,GRADE[SI]
        JB LOP1
        XCHG AL,GRADE[SI]
        MOV GRADE[SI-1],AL
        
   LOP1:LOOP LOP2
        DEC BL
        JNZ INIT
        
   MED: MOV AL, LEN
        MOV BL, 02H
        DIV BL
        MOV SI, AX
        DEC SI
        MOV AL, GRADE[SI]
        MOV MEDIAN, AL
        
   DIFF:MOV BL, LEN
        MOV SI, BX
        MOV AL, MAX
        SUB AL, GRADE[SI-1]
        DAS
        MOV DIF, AL
        
        MOV SI, 00H
        MOV CL, LEN
   AVG: MOV AL,GRADE[SI]
        SHR AL, 4
        MOV BL, GRADE[SI]
        SHL BL, 4
        SHR BL, 4
        MOV BH, 0AH
        MUL BH
        MOV BH, 00H
        ADD AX, BX
        ADD AX, AVG1
        MOV AVG1, AX
        INC SI
        LOOP AVG
        DIV LEN
        
 ToBCD: MOV AH, 00H
        MOV CL, 64H
        DIV CL
        MOV BH,AL
        MOV AL, AH
        MOV AH,00H
        MOV CL,0AH
        DIV CL
        MOV CL,04H
        ROL AL,CL
        ADD AL,AH
        MOV BL,AL
        MOV AVG1, BX
        
        ADD BL, DIF
        MOV AVG2, BX
        
        MOV SI, 00H
        MOV CL, LEN
 SHIFT: MOV AL,GRADE[SI]
        CMP AL, MEDIAN
        JBE CONT
        ADD AL, DIF
        DAA
        MOV GRADE[SI], AL
  CONT: INC SI
        LOOP SHIFT
        
        
        MOV AH,4CH
        INT 21H
CODE ENDS
END START
