#include <mega328p.h>
#include <io.h>
#include <delay.h>
unsigned char value; // Byte to store value
unsigned char display[16] = {0xFC, 0x60, 0xDB, 0xF3, 0x66, 0xB7, 0xBE, 0xE1, 0xFE, 0xF6, 0xEE, 0x3F, 0x9C, 0x7B, 0x9E, 0x8E};
void main(void)
{
    DDRD=0xFF; // All PD as output
    DDRC=0x00; // All PC as input
    PORTC=0x0F; // Pull-Ups in PC0, PC1, PC2 and PC3    
    while (1)
        {
            value=PINC&0x0F; // Read PC but ignore (masking) PC4, PC5, PC6 and PC7
            PORTD=display[value];
        }
}