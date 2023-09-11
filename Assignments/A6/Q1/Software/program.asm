;Q1
;BAKHSHANDE

.include "m32def.inc"

		LDI		R16,HIGH(RAMEND)
		OUT		SPH,R16    
		LDI		R16,LOW(RAMEND)
		OUT		SPL,R16

		LDI		R16,0xFF
		OUT		DDRC,R16		;PORTC as output
		OUT		DDRD,R16		;PORTD as output

		OUT		PORTA,R16		;Enabling Pullup Resistor on PORTA 
		LDI		R16,0x00
		OUT		DDRA,R16		;PORTA as input' 
		
INIT:   LDI		R18 , 1
		LDI 	R19 , 0 
		LDI 	R20 , 0 



FIB:    MOV     R16 , R18
	    LDI	    R17 , 0
	    MOV 	R20 , R18 
	    ADD 	R18 , R19 
	    MOV 	R19 ,R20
	
YEKAN:  CPI	    R16, 10
	    BRGE    DAHGAN
	    RJMP    DISPLAY 
	
DAHGAN: LDI 	R21,10
	    SUB     R16,R21
	    INC 	R17
	    RJMP	YEKAN  
	    
CHECK:  CPI	    R16,9  
        BREQ    DISPLAY
	    RJMP    FIB
	
	
	
DISPLAY:
        MOV	 R22,R16  ;Yekan
		CALL CONVERT
		OUT	 PORTC,R22
		
		MOV  R22,R17  ;Dahgan
		CALL CONVERT
		OUT	 PORTD,R22 
				
		CALL ONESEC_DEL
		RJMP CHECK

     
     

ONESEC_DEL:  
        LDI     R27, 8   ; One clock cycle;
DELAY1: LDI     R28, 125 ; One clock cycle
DELAY2: LDI     R29, 250 ; One clock cycle
DELAY3: DEC     R29      ; One clock cycle
        NOP              ; One clock cycle
        BRNE    DELAY3   ; Two clock cycles when jumping to Delay3, 
                         ;1 clock when continuing to DEC
        DEC     R28      ; One clock cycle
        BRNE    DELAY2   ; Two clock cycles when jumping to Delay2, 
                         ;1 clock when continuing to DEC
        DEC     R27      ; One clock Cycle
        BRNE    DELAY1   ; Two clock cycles when jumping to Delay1, 
                         ;1 clock when continuing to RET
        RET




CONVERT:
		CPI		R22,0
		BRNE	C1
		LDI		R22,0x3F
		RET

C1:		CPI		R22,1
		BRNE	C2
		LDI		R22,0x06
		RET

C2:		CPI		R22,2
		BRNE	C3
		LDI		R22,0x5B
		RET

C3:		CPI		R22,3
		BRNE	C4
		LDI		R22,0x4F
		RET
C4:		CPI		R22,4
		BRNE	C5
		LDI		R22,0x66
		RET

C5:		CPI		R22,5
		BRNE	C6
		LDI		R22,0x6D
		RET

C6:		CPI		R22,6
		BRNE	C7
		LDI		R22,0x7D
		RET

C7:		CPI		R22,7
		BRNE	C8
		LDI		R22,0x07
		RET

C8:		CPI		R22,8
		BRNE	C9
		LDI		R22,0x7F
		RET

C9:		CPI		R22,9
		BRNE	C10
		LDI		R22,0x6F
C10:	RET




