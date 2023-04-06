// CONFIG
#pragma config FOSC = XT        // Oscillator Selection bits (XT oscillator)
#pragma config WDTE = OFF       // Watchdog Timer Enable bit (WDT disabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = OFF      // Brown-out Reset Enable bit (BOR disabled)
#pragma config LVP = OFF        // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF        // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
#pragma config WRT = OFF        // Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

#define _XTAL_FREQ 4000000
#define __delay_ms(x) _delay((unsigned long)((x)*(_XTAL_FREQ/4000.0)))

#define RS RC2
#define EN RC3
#define D4 RC4
#define D5 RC5
#define D6 RC6
#define D7 RC7


#include <xc.h>
#include <stdio.h>
#include <stdlib.h>
#include "lcd.h"

int sBoton = 0;
int sBoton2 = 0;
char mensaje[17];

int main(int argc, char** argv) {
    
    TRISC = 0;
    PORTC = 0;
    
    Lcd_Init();
    
    Lcd_Clear();
    Lcd_Set_Cursor(1,1);
    Lcd_Write_String("Mi primer");
    Lcd_Set_Cursor(2,1);
    Lcd_Write_String("programa LCD");
    __delay_ms(2000);
    
    while (1){
        sBoton = PORTBbits.RB0;
        sBoton2 = PORTBbits.RB1;
        
        sprintf(mensaje,"Sensor 1 = %d",sBoton);
        Lcd_Clear();
        Lcd_Set_Cursor(1,1);
        Lcd_Write_String(mensaje);
        sprintf(mensaje,"Sensor 2 = %d",sBoton2);
        Lcd_Set_Cursor(2,1);
        Lcd_Write_String(mensaje);
        
        __delay_ms(200);
    }

    return (EXIT_SUCCESS);
}

