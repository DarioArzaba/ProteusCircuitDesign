// Create an Arithmetic and Logical Unit or ALU
// It has 4 bit inputs A (PB0-PB3) and B (PB4-PB7), the result is outputed by PD0-PD4
// The operation can be selected from 8 possibilities using the bits PC0-PC3 as selector.
// A', A&B, A&'B, A+B, A+'B, Ax+B, Ax+'B, A+B (Math)

#include <mega328p.h>
#include <io.h>
unsigned char A,B,Op;
void main(void)
{
    DDRB = 0x00;
    DDRC = 0x00;
    DDRD = 0x1F;
    while (1)
    {
        A = PINB&0x0F;
        B = PINB&0xF0;
        B = B >> 4; // Carry the bits 4 places to the right
        Op = PINC&0x07;            
        switch (Op) 
        {
            case 0: PORTD = ~A;     break; 
            case 1: PORTD = A&B;    break;
            case 2: PORTD = ~(A&B); break;
            case 3: PORTD = A|B;    break;
            case 4: PORTD = ~(A|B); break;
            case 5: PORTD = A^B;    break;
            case 6: PORTD = ~(A^B); break;
            case 7: PORTD = A+B;    break;
            
        }

    }
}
