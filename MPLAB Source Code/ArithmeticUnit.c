// Create an Arithmetic and Logical Unit or ALU
// It has 4 bit inputs A (PB0-PB3) and B (PB4-PB7), the result is outputed by PD0-PD4
// The operation can be selected from 8 possibilities using the bits PC0-PC3 as selector.
// A', A&B, A&'B, A|B, A|'B, Ax|B, Ax|'B, A+B (Math)

#include <mega328p.h>
#include <io.h>
#include <iostream>
using namespace std;

void main(void)
{
    unsigned char y = 0xC9;
    unsigned char x = 0x00;
    x = ~y; cout << hex << (int) x endl;
}
