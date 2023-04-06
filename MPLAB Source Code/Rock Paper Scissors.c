#asm
    .equ __lcd_port=0x05
    .equ __lcd_EN=1
    .equ __lcd_RS=0
    .equ __lcd_D4=2
    .equ __lcd_D5=3
    .equ __lcd_D6=4
    .equ __lcd_D7=5
#endasm 
#include <mega328p.h>
#include <delay.h>
#include <display.h>
#define SinTiro 0
#define Piedra 1
#define Papel 2
#define Tijeras 3

//Variables to save scores and the selection of each player
unsigned char A=0, B=0, TiroA, TiroB;
void ImprimeMarcador()
{
    MoveCursor(0,0);
    CharLCD(A+'0');
    MoveCursor(15,0); 
    CharLCD(B+'0');
}

void ImprimeTiro()
{
    MoveCursor(0,1);
    switch (TiroA)
    {
        case Piedra: StringLCD("ROCK    "); break;
        case Papel: StringLCD("PAPER   "); break; 
        case Tijeras: StringLCD("SCISSORS"); break;
    }
         
    MoveCursor(9,1);
    switch (TiroB)
    {
        case Piedra: StringLCD("   ROCK"); break;
        case Papel: StringLCD("  PAPER"); break; 
        case Tijeras: StringLCD("SCISSORS"); break;
    }    
}


void main(void)
{
    SetupLCD();
    PORTD=0xE1;
    PORTC=0x07;
    while (1)
    {   
        //Print the starting score and starting message
        ImprimeMarcador(); 
        MoveCursor(4,0);
        StringLCD(" PLAY");
        TiroA=SinTiro;
        TiroB=SinTiro;
        
        // Do until both players have made a move
        do { 
            if(PIND.5==0) TiroA=Piedra;
            if(PIND.6==0) TiroA=Papel;
            if(PIND.7==0) TiroA=Tijeras;
              
            if(PINC.0==0) TiroB=Piedra;
            if(PINC.1==0) TiroB=Papel;
            if(PINC.2==0) TiroB=Tijeras;
                      
            MoveCursor(0,1);
            if(TiroA==SinTiro) StringLCD("SELECT  ");
            else StringLCD("OK A     ");
                                    
            MoveCursor(9,1);
            if(TiroB==SinTiro) StringLCD(" SELECT");
            else StringLCD("   OK B");
                        
        } while((TiroA==SinTiro)||(TiroB==SinTiro));
                 
        // If both players have made a move show who won the round
        // Also add a point to their score
        ImprimeTiro(); 
        MoveCursor(4,0);
        switch (TiroA-TiroB)
        {
            case 0: StringLCD("TIE    "); break;
            case 1:
            case -2: StringLCD("A WON "); A++;  break;
            case -1:
            case 2: StringLCD("B WON "); B++; break;   
        }
                  
        ImprimeMarcador();
        delay_ms(1500);
        
        // Only do this if we have reached GAMEOVER condition 
        if((A==5)||(B==5))
        { 
            // Display message with the winner until
            // Restart button is pressed
            do {  
                MoveCursor(4,0);
                if(A==5) StringLCD("WINNER A "); 
                else StringLCD("WINNER B ");
                delay_ms(100);
                MoveCursor(4,0);
                StringLCD("         ");
                delay_ms(100);         
            } while(PIND.0==1);
            A=0;
            B=0;
        }
    }
}