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
int valor, valor2;
float volts, volts2;

int main(int argc, char** argv) {
    
    ADCON1 = 0b10000000;
    
    ADCON0 = 0b00001000;
    
    TRISC = 0;
    PORTC = 0;
    
    Lcd_Init();
    
    Lcd_Clear();
    Lcd_Set_Cursor(1,1);
    Lcd_Write_String("Mi segundo");
    Lcd_Set_Cursor(2,1);
    Lcd_Write_String("programa LCD");
    __delay_ms(2000);
    
    while (1){
        sBoton = PORTBbits.RB0;
        sBoton2 = PORTBbits.RB1;
        
        sprintf(mensaje,"SD1=%d SD2=%d",sBoton,sBoton2);
        Lcd_Clear();
        Lcd_Set_Cursor(1,1);
        Lcd_Write_String(mensaje);
        
        //POTENCIOMETRO 1
        ADCON0 = 0b00000000;
        ADCON0bits.ADON = 1; //Encender ADC
        __delay_ms(1);
        ADCON0bits.GO = 1; //Comienza la conversion
        while ( ADCON0bits.GO);
        valor = ADRESH;
        valor = valor<<8;
        valor = valor+ADRESL;
        ADCON0bits.ADON = 0;
        
        //POTENCIOMETRO 2
        ADCON0 = 0b00001000;
        ADCON0bits.ADON = 1; //Encender ADC
        __delay_ms(1);
        ADCON0bits.GO = 1; //Comienza la conversion
        while ( ADCON0bits.GO);
        valor2 = ADRESH;
        valor2 = valor2<<8;
        valor2 = valor2+ADRESL;
        ADCON0bits.ADON = 0;
        
        //Conversion
        volts = valor * 0.0048;
        volts2 = valor2 * 0.0048;
        Lcd_Set_Cursor(2,1);
        sprintf(mensaje,"SA1=%.2f SA2=%.2f",volts,volts2);
        Lcd_Write_String(mensaje);
 
        __delay_ms(200);
    }

    return (EXIT_SUCCESS);
}

