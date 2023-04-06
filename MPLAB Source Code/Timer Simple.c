// Read a dip switch. (PC0)
// Use it with a 7 segment display to stop and resume a timer of 0-9 seconds (PD1 - PD7)
// Finally connect PD0 to a LED to display if it is a prime number

#include <mega328p.h>
#include <io.h>
#include <delay.h>
unsigned char timerValue = 0;
unsigned char display[10] = {0xFC, 0x60, 0xDB, 0xF3, 0x66, 0xB7, 0xBE, 0xE1, 0xFE, 0xF6};
void main(void)
{
    DDRD=0xFF;
    DDRC=0x00;
    PORTC=0x0F;  
    while (1)
        {
            PORTD=display[timerValue];
            if (PINC.0 == 0)
            {
                timerValue++; // Add 1 to the Value if the Switch at PC0 is Pressed
            }
            if (timerValue == 10) 
            {
                timerValue = 0; // Restart the index to 0 if it reaches a value of 10
            }
            delay_ms(1000);            
        }
}