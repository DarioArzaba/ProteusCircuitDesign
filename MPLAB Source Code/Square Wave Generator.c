#include <mega328p.h>

void delay5msTimer1 ()
{
    TCCR1B=0x01; // Prescaler to 1
    // ADJUST FOR EXECUTION TIME 55921 + 26 = 55947
    TCNT1H = 55947 /256;
    TCNT1L=55947 % 256;
    while (TIFR1.TOV1==0);
    TIFR1.TOV1=1;
    TCCR1B=0;
}

void main(void)
{
    DDRB.0=1;
    while (1)
    {
        PORTB.0=1;
        delay5msTimer1();
        PORTB.0=0;
        delay5msTimer1();
    }
}
