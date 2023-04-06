// Nano LED turn on or off with a push button.

#include <mega328p.h>
void main(void)
{
    CLKPR=0x80;
    CLKPR=0x04;   // Arduino 1MHz
    PORTB.0=1;    // PB0 in Pull Up
    DDRB.1=1;     // PB1 as Output
    while (1)
    {
        if (PINB.0==0) PORTB.1=1;
        else  PORTB.1=0;
    }
}