    #include <mega328P.h>  
    #include <delay.h>
    #include <stdio.h> 
    
#define Dig1 PORTD.1
#define Dig2 PORTD.0

#define RojoP PORTD.3
#define VerdeP PORTD.4
#define RojoC PORTD.5
#define AmbarC PORTD.6
#define VerdeC PORTD.7

unsigned char segundos=0;
bit SelDigito=0;
bit peaton=0;    

// External Interrupt 0 service routine
interrupt [EXT_INT0] void ext_int0_isr(void)
{
   
}

// Timer 0 output compare A interrupt service routine
interrupt [TIM0_COMPA] void despliega(void)
{
   unsigned char SieteSeg[10]={0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xf8,0x80,0x98};
   
   SelDigito=!SelDigito;
   
}



void main(void)
{
    unsigned char i;
               
    // Global enable interrupts
    #asm("sei")

    while (1)
    {  
         
              
    }
}

