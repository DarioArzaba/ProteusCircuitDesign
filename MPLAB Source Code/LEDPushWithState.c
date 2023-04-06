// Nano LED turn on or off with a push button (Correct with delay for bounce).
// The LED must stay on or off with a state.

#include <mega328p.h>
#include <delay.h>
bit s1=0;
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
            s1=~s1; // Toggle Change with Button
            PORTB.1=s1; // LED uses the current state
            delay_ms(30); // Delay for bounce when PRESSING
            while (PINB.0==0); //Ignore everything until first RELEASE
            delay_ms(10); // Delay for bounce at RELEASE
        }
        
    }
}