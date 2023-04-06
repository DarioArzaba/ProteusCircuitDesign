#asm
    .equ __lcd_port=0x0B
    .equ __lcd_EN=3
    .equ __lcd_RS=2
    .equ __lcd_D4=4
    .equ __lcd_D5=5
    .equ __lcd_D6=6
    .equ __lcd_D7=7
#endasm
#include <mega328p.h>
#include <delay.h>
#include <display.h>   
#include <stdio.h>
#include <stdlib.h>
                           
char Cadena[17];
unsigned char i;
char random_object;
unsigned int score = 0;
int allow_jump = 0;
char dino_l[8] = { 0x07, 0x05, 0x07, 0x16, 0x1F, 0x1E, 0x0E, 0x04 };
char dino_r[8] = { 0x07, 0x05, 0x07, 0x16, 0x1F, 0x1E, 0x0E, 0x02 };
char cactus_small[8] = { 0x00, 0x00, 0x04, 0x05, 0x15, 0x16, 0x0C, 0x04 };
char cactus_big[8] = { 0x00, 0x04, 0x05, 0x15, 0x16, 0x1C, 0x04, 0x04 };
char world[] = {32, 32, 32, 32, 32, 32, 32, 83, 99, 111, 114, 101, 58, 32, 32, 32, 32, 0, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32};

int scroll_world() {
    
    delay_ms(250);
        
    srand(TCNT0);
    random_object =(rand() % (32 - 2 + 1)) + 2;
    
    if (random_object < 4) world[31] = random_object;
    else world[31] = 32;

    for (i = 16; i < 32; i++) {
      if (world[i] == 2 || world[i] == 3) {
        char prev = (i < 31) ? world[i + 1] : 32;
        if (world[i - 1] < 2) return 1;
        world[i - 1] = world[i];
        world[i] = prev;
      }
    }
    
    world[15] = 32;
    if (world[16] < 2) world[16] = 32;
    return 0;
}

void update_world() {

    int game_over = scroll_world();
        
    if (score == 999) {
        MoveCursor(0,0);
        StringLCD("  GANASTE ");
        MoveCursor(0,1);
        CharLCD(0); CharLCD(32); CharLCD(2); CharLCD(2); CharLCD(2);
        CharLCD(3); CharLCD(3); CharLCD(3); CharLCD(3); CharLCD(3); CharLCD(3);
        CharLCD(2); CharLCD(2); CharLCD(2); CharLCD(32); CharLCD(1);
        while(1);
    }
    
    if (game_over) {
        MoveCursor(0,0);
        CharLCD(0);
        CharLCD(3);
        StringLCD("   GAME OVER! ");
        CharLCD(3);
        CharLCD(0);
        while(1);
    }        
    
    score++;
    MoveCursor(13,0);    
    sprintf(Cadena,"%i", score);
    StringLCDVar(Cadena);
    MoveCursor(0,0);
    
    for (i = 0; i < 32; i++) {
        if (world[i] < 2) world[i] = world[i] ^ 1;
        if (i == 16) MoveCursor(0,1);
        if (i < 13 || i > 15) CharLCD(world[i]);
    }
    
}

void main(void)
{
    CLKPR=0x80;
    CLKPR=0x04;
    SetupLCD();
    
    PORTC.0=1;
    DDRC.1=1;  
    TCCR0B=0x01;
    
    CreateChar(0,dino_l);
    CreateChar(1,dino_r);
    CreateChar(2,cactus_small);
    CreateChar(3,cactus_big);

    while (1)
    {
        allow_jump = allow_jump ^ 1;
                  
        if (PINC.0==0 & allow_jump == 1) {
        
            MoveCursor(1,1);
            CharLCD(32);
            MoveCursor(1,0);
            CharLCD(0);

            world[1] =0;
            world[17] = 32;
                            
            for (i = 0; i < 4; i++) update_world();

            world[1] = 32;
            world[17] = 0;
                            
            MoveCursor(1,0);
            CharLCD(32);
            MoveCursor(1,1);
            CharLCD(0);
        }

        update_world();

    }
}
