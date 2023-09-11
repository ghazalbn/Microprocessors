#include <stdio.h>
#include <dos.h>
#include "converter.h"

#define GET_SYSTEM_DATE 0x2A

long date[3];

int main()
{
    union REGS input_regs, output_regs;
    input_regs.h.ah = GET_SYSTEM_DATE;

    // using intdos
    intdos(&input_regs, &output_regs);
    printf("gregorian date using intdos: %d/%d/%d\n", 
    output_regs.x.cx, output_regs.h.dh, output_regs.h.dl, date);
    gregorian_to_jalali(output_regs.x.cx, output_regs.h.dh, output_regs.h.dl, date);
    printf("persian date using intdos: %ld/%ld/%ld\n", date[0], date[1], date[2]);

    // using int86
//    int86(0x21, &input_regs, &output_regs);
//    printf("gregorian date using int86: %d/%d/%d\n", 
//    output_regs.x.cx, output_regs.h.dh, output_regs.h.dl, date);
//    gregorian_to_jalali(output_regs.x.cx, output_regs.h.dh, output_regs.h.dl, date);
//    printf("persian date using int86: %ld/%ld/%ld\n", date[0], date[1], date[2]);
    
    return 0;
}
