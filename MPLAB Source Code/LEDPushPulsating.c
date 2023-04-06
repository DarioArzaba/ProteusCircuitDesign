// Nano LED turn on or off with a push button.
// Pulsating with a delay of 0.125 seconds

#include <mega328p.h>
#include <delay.h>
void main(void)
{
    CLKPR=0x80;
    CLKPR=0x04;
    PORTB.0=1;
    DDRB.1=1;
    while (1)
    {
        if (PINB.0==0)
        {
            PORTB.1=1;
            delay_ms(125);
            PORTB.1=0;
            delay_ms(125);  
        }
    }
}