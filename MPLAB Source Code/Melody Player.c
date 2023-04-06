#define NOTE_B0  31
#define NOTE_C1  33
#define NOTE_CS1 35
#define NOTE_D1  37
#define NOTE_DS1 39
#define NOTE_E1  41
#define NOTE_F1  44
#define NOTE_FS1 46
#define NOTE_G1  49
#define NOTE_GS1 52
#define NOTE_A1  55
#define NOTE_AS1 58
#define NOTE_B1  62
#define NOTE_C2  65
#define NOTE_CS2 69
#define NOTE_D2  73
#define NOTE_DS2 78
#define NOTE_E2  82
#define NOTE_F2  87
#define NOTE_FS2 93
#define NOTE_G2  98
#define NOTE_GS2 104
#define NOTE_A2  110
#define NOTE_AS2 117
#define NOTE_B2  123
#define NOTE_C3  131
#define NOTE_CS3 139
#define NOTE_D3  147
#define NOTE_DS3 156
#define NOTE_E3  165
#define NOTE_F3  175
#define NOTE_FS3 185
#define NOTE_G3  196
#define NOTE_GS3 208
#define NOTE_A3  220
#define NOTE_AS3 233
#define NOTE_B3  247
#define NOTE_C4  262
#define NOTE_CS4 277
#define NOTE_D4  294
#define NOTE_DS4 311
#define NOTE_E4  330
#define NOTE_F4  349
#define NOTE_FS4 370
#define NOTE_G4  392
#define NOTE_GS4 415
#define NOTE_A4  440
#define NOTE_AS4 466
#define NOTE_B4  494
#define NOTE_C5  523
#define NOTE_CS5 554
#define NOTE_D5  587
#define NOTE_DS5 622
#define NOTE_E5  659
#define NOTE_F5  698
#define NOTE_FS5 740
#define NOTE_G5  784
#define NOTE_GS5 831
#define NOTE_A5  880
#define NOTE_AS5 932
#define NOTE_B5  988
#define NOTE_C6  1047
#define NOTE_CS6 1109
#define NOTE_D6  1175
#define NOTE_DS6 1245
#define NOTE_E6  1319
#define NOTE_F6  1397
#define NOTE_FS6 1480
#define NOTE_G6  1568
#define NOTE_GS6 1661
#define NOTE_A6  1760
#define NOTE_AS6 1865
#define NOTE_B6  1976
#define NOTE_C7  2093
#define NOTE_CS7 2217
#define NOTE_D7  2349
#define NOTE_DS7 2489
#define NOTE_E7  2637
#define NOTE_F7  2794
#define NOTE_FS7 2960
#define NOTE_G7  3136
#define NOTE_GS7 3322
#define NOTE_A7  3520
#define NOTE_AS7 3729
#define NOTE_B7  3951
#define NOTE_C8  4186
#define NOTE_CS8 4435
#define NOTE_D8  4699
#define NOTE_DS8 4978
#define REST     0

#include <mega328p.h>
#include <delay.h>
#include <stdio.h>
#include <stdlib.h>

//int tempo = 120; //Slower or faster
// Melody Notes and Duration
flash int melody[] = {
    NOTE_A4,4, NOTE_A4,4, NOTE_A4,4, NOTE_F4,-8, NOTE_C5,16,
    NOTE_A4,4, NOTE_F4,-8, NOTE_C5,16, NOTE_A4,2,//4
    NOTE_E5,4, NOTE_E5,4, NOTE_E5,4, NOTE_F5,-8, NOTE_C5,16,
    NOTE_A4,4, NOTE_F4,-8, NOTE_C5,16, NOTE_A4,2,
    NOTE_A5,4, NOTE_A4,-8, NOTE_A4,16, NOTE_A5,4, NOTE_GS5,-8, NOTE_G5,16, //7 
    NOTE_DS5,16, NOTE_D5,16, NOTE_DS5,8, REST,8, NOTE_A4,8, NOTE_DS5,4, NOTE_D5,-8, NOTE_CS5,16,
    NOTE_C5,16, NOTE_B4,16, NOTE_C5,16, REST,8, NOTE_F4,8, NOTE_GS4,4, NOTE_F4,-8, NOTE_A4,-16,//9
    NOTE_C5,4, NOTE_A4,-8, NOTE_C5,16, NOTE_E5,2
};

flash int melody2[] = {
    NOTE_C4,4, NOTE_E4,4, NOTE_G4,4, NOTE_E4,4, 
    NOTE_C4,4, NOTE_E4,8, NOTE_G4,-4, NOTE_E4,4,
    NOTE_A3,4, NOTE_C4,4, NOTE_E4,4, NOTE_C4,4,
    NOTE_A3,4, NOTE_C4,8, NOTE_E4,-4, NOTE_C4,4,
    NOTE_G3,4, NOTE_B3,4, NOTE_D4,4, NOTE_B3,4,
    NOTE_G3,4, NOTE_B3,8, NOTE_D4,-4
};

int notes = sizeof(melody) / sizeof(melody[0]) / 2;
int notes2 = sizeof(melody2) / sizeof(melody2[0]) / 2;
int wholenote = 2000; //Whole note duration in ms
int divider = 0, noteDuration = 0;
unsigned int thisNote;

void tono(float frec)
{
    float Cuentas;
    unsigned int CuentasEnt;
    DDRB.1=1; // Speaker Output
    Cuentas = 500000.0/frec;
    CuentasEnt=Cuentas;
    if ((Cuentas-CuentasEnt)>=0.5) CuentasEnt++;
    
    TCCR1A=0x40; //Timer 1 en Modo CTC
    TCCR1B=0x09; //No Pre-escaler (CKx1)
    
    OCR1AH=(CuentasEnt-1)/256;
    OCR1AL=(CuentasEnt-1)%256;
}

void noTono()
{
    // Turn off timers, STOP them
    TCCR1A=0;
    TCCR1B=0; 
}
unsigned int S = 0;
void main(void)
{
    CLKPR=0x80;
    CLKPR=0x04;
    
    PORTC.0=1;
    PORTC.1=1;
    
    while (1)
    {
        thisNote=0;
        if (PINC.0==0){
            if (S==1){S=0;}
            if (S!=1){delay_ms(30);}
            for (thisNote = 0; thisNote < notes * 2; thisNote = thisNote + 2) {
                if (PINC.1==0){ S=1; }
                if (S==1) break;
                divider = melody[thisNote + 1];
                if (divider > 0) {
                    noteDuration = (wholenote) / divider;
                } else if (divider < 0) {
                    divider=(-1)*divider;
                    noteDuration = (wholenote) / divider;
                    noteDuration=noteDuration*1.5;
                }
                if (PINC.1==0){ S=1; }
                else {
                    tono(melody[thisNote]);
                    delay_ms(noteDuration*0.9);
                    noTono();
                    delay_ms(noteDuration*0.1);
                }
            }
            if (S!=1){while (PINC.0==0); delay_ms(10);}
        }
        thisNote=0;
        if (PINC.1==0){
            if (S==1){S=0;}
            if (S!=1){delay_ms(30);}
            for (thisNote = 0; thisNote < notes2 * 2; thisNote = thisNote + 2) {
                if (PINC.0==0){ S=1; }
                if (S==1) break;
                divider = melody2[thisNote + 1];
                if (divider > 0) {
                    noteDuration = (1500) / divider;
                } else if (divider < 0) {
                    divider=(-1)*divider;
                    noteDuration = (1500) / divider;
                    noteDuration=noteDuration*1.5;
                }
                if (PINC.0==0){ S=1; }
                else {
                    tono(melody2[thisNote]);
                    delay_ms(noteDuration*0.9);
                    noTono();
                    delay_ms(noteDuration*0.1);
                }
            }
            if (S!=1){while (PINC.1==0); delay_ms(10);}
        }

    }
}





