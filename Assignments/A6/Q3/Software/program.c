// Q3

#include <mega32.h>
#include <delay.h>

unsigned int second = 0;
unsigned int button = 0;


char convert[] = {
    0x40,
	0x79,
	0x24,
	0x30,
	0x19,
	0x12,
	0x02,
	0x78,
	0x00,
	0x10};
	
	
interrupt [EXT_INT0] void ext_int0_isr(void) {
	if (!PORTC.3)
		button = 1 - button;
}

// Timer1 output compare A interrupt service routine
interrupt [TIM1_COMPA] void timer1_compa_isr(void) {
	
	if (button == 0)
		second = (second + 1) % 10;       
}

void main(void) {
	// Port A as out
	DDRA = 0xFF;
	
	GICR |= 0xE0;
    MCUCR = 0x0A;
    MCUCSR = 0x00;
    GIFR = 0xE0;
	
	// Timer 1 config
	TCCR1A = 0x00;
	TCCR1B = 0x0C;
	TCNT1H = 0x00;
	TCNT1L = 0x00;
	ICR1H = 0x00;
	ICR1L = 0x00;
	OCR1AH = 0x7A;
	OCR1AL = 0x12;
	OCR1BH = 0x00;
	OCR1BL = 0x00;
	TIMSK = 0x12;
	
	// Global enable interrupts
	#asm("sei")

	while (1)
	{
	    PORTA = convert[second];
	}
}
