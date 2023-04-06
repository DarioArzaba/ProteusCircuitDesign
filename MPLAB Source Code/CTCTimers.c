#include <mega328p.h>

void main(void)
{
    CLKPR=0x80;
    CLKPR=0;
    
    // Timer 0
    DDRD.6=1; // Output PD6 for Timer 0
    TCCR0A = 0x42;
    TCCR0B = 0X04; 
    OCR0A = 102;
    
    // Timer 1
    DDRB.1=1; // Output PB1 for Timer 1
    TCCR1A = 0x40;
    TCCR1B = 0x09;
    OCR1AH = 15872/256;
    OCR1AL = 15872%256;

    // Timer 2
    DDRB.3=1; // Output PB3 for Timer 2
    TCCR2A = 0x42;
    TCCR2B = 0X04; 
    OCR2A = 177;
        
    while (1)
    {      
    }
}
 