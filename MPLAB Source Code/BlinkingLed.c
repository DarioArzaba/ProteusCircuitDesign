/*
 * BlinkingLed.c
 *
 * Created: 1/23/2023 11:15:43 AM
 * Author: PRN14097
 */

#include <mega328p.h>
#include <io.h>
#include <delay.h>

void main(void)
{
    DDRB.0=1; // PB0 es salida.
    while (1)
        {
            PORTB.0=1; // PB0 prende LED
            delay_ms(500);
            PORTB.0=0; // PB0 apaga LED
            delay_ms(500);
        }
}
