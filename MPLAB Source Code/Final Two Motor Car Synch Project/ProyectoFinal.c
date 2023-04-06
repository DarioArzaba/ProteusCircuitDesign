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
#include <stdio.h>
#include <stdlib.h>

unsigned char cursor;
void SendDataBitsLCD(unsigned char Data);
void WriteComandLCD(unsigned char command);
void PulseEn();

void SetupLCD() {
	unsigned char TableSetup[12]={3,3,3,2,2,12,0,8,0,1,0,6};
	unsigned char i;   
	#asm
	SBI __lcd_port-1,__lcd_EN 
	SBI __lcd_port-1,__lcd_RS
	SBI __lcd_port-1,__lcd_D4
	SBI __lcd_port-1,__lcd_D5
	SBI __lcd_port-1,__lcd_D6
	SBI __lcd_port-1,__lcd_D7
	#endasm 
	delay_ms(50);
	for (i=0;i<12;i++)
	{
		delay_ms(2);    
		SendDataBitsLCD(TableSetup[i]);     
		PulseEn();
		
	} 
	cursor=0x0C;
	WriteComandLCD(cursor);  
}       
	
void PulseEn() {
	#asm
		SBI __lcd_port,__lcd_EN
		CBI __lcd_port,__lcd_EN
	#endasm 
}

void SendDataBitsLCD(unsigned char Data) {
	if ((Data&0x08)!=0)  
		#asm("SBI __lcd_port,__lcd_D7")
	else
		#asm("CBI __lcd_port,__lcd_D7")
	if ((Data&0x04)!=0)
		#asm("SBI __lcd_port,__lcd_D6")
	else
		#asm("CBI __lcd_port,__lcd_D6")
	if ((Data&0x02)!=0)
		#asm("SBI __lcd_port,__lcd_D5") 
	else
		#asm("CBI __lcd_port,__lcd_D5")
	if ((Data&0x01)!=0)
		#asm("SBI __lcd_port,__lcd_D4")
	else
		#asm("CBI __lcd_port,__lcd_D4") 
}

void WriteComandLCD(unsigned char commnad)
{
	unsigned char tempcommand;  
	#asm("CBI __lcd_port,__lcd_RS")
	delay_ms(2);
	tempcommand=commnad&0xF0;
	tempcommand=tempcommand>>4;  
	SendDataBitsLCD(tempcommand);
	PulseEn();
	tempcommand=commnad&0x0F;    
	SendDataBitsLCD(tempcommand);
	delay_ms(2);
	PulseEn();
}

void CharLCD(unsigned char Data) {
	unsigned char tempData; 
	#asm("SBI __lcd_port,__lcd_RS")
	delay_ms(2);
	tempData=Data&0xF0;
	tempData=tempData>>4;    
	SendDataBitsLCD(tempData);
	PulseEn();
	tempData=Data&0x0F;
	SendDataBitsLCD(tempData);
	delay_ms(2);
	PulseEn();
}

void StringLCD(flash unsigned char Message[]) {
	unsigned char i;
	i=0;
	do{
		CharLCD(Message[i++]); 
	} while(Message[i]!=0);
}    

void StringLCD2(flash unsigned char Message[],unsigned int tiempo) {
	unsigned char i;
	i=0;
	do{
		CharLCD(Message[i++]);
		delay_ms(tiempo); 
	} while(Message[i]!=0);
}    

void StringLCDVar(unsigned char Message[]) {
	unsigned char i;
	i=0;
	do{
		CharLCD(Message[i++]); 
	} while(Message[i]!=0);
}

void EraseLCD( )
{
	WriteComandLCD(1);  
}

void MoveCursor(unsigned char x, unsigned char y) {
	switch (y) {
		case(0):
			WriteComandLCD(0x80+x);
			break; 
		case(1):
			WriteComandLCD(0xC0+x);  
				break;   
				case(2):
			WriteComandLCD(0x94+x);  
				break;  
				case(3):
			WriteComandLCD(0xD4+x);  
				break;             
	}   
} 

void UnderscoreCursor() {
	cursor=cursor|0x02;
	WriteComandLCD(cursor);
}

void NoUnderscoreCursor() {
	cursor=cursor&0xFD;
	WriteComandLCD(cursor);
}

void BlinkCursor()
{
	cursor=cursor|0x01;
	WriteComandLCD(cursor);
}

void NoBlinkCursor()
{
	cursor=cursor&0xFE;
	WriteComandLCD(cursor);
}
	  
void CreateChar(unsigned char NoCaracter, unsigned char MultipleData[8]) {
	 unsigned char i;
	 WriteComandLCD(0x40+NoCaracter*8);   
	 for (i=0;i<8;i++)
		CharLCD(MultipleData[i]);  
	 WriteComandLCD(0x80);   
}
					   
char charArrayDisplay[17];
char random_object;
unsigned int hs=0;
unsigned int score = 0;
int allow_jump = 0;
int restart = 0;
int jumping = 0;
char dino_l[8] = { 0x07, 0x05, 0x07, 0x16, 0x1F, 0x1E, 0x0E, 0x04 };
char dino_r[8] = { 0x07, 0x05, 0x07, 0x16, 0x1F, 0x1E, 0x0E, 0x02 };
char cacti_small[8] = { 0x00, 0x00, 0x04, 0x05, 0x15, 0x16, 0x0C, 0x04 };
char cacti_big[8] = { 0x00, 0x04, 0x05, 0x15, 0x16, 0x1C, 0x04, 0x04 };
char world[] = {32, 32, 32, 32, 32, 32, 32, 83, 99, 111, 114, 101, 58, 32, 32, 32, 32, 0, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32};
unsigned char i;

int scroll_world() {
	if (restart==1){
		for (i = 18; i < 31; i++) {
		  world[i] = 32;
		}
		EraseLCD();
		restart=0;
		for (i=0; i<50; i++) 
		{
			PORTC.1=1;
			delay_us(2000);
			PORTC.1=0;
			delay_us(2000);
		}
		
	}
	//Generate Random Obstacles
	delay_ms(250);
	srand(TCNT0);
	random_object =(rand() % (32 - 2 + 1)) + 2;
	if (random_object < 4) world[31] = random_object;
	else world[31] = 32;

	//Detect Sprite Collisions
	for (i = 16; i < 32; i++) {
	  if (world[i] == 2 || world[i] == 3) {
		char prev = (i < 31) ? world[i + 1] : 32;
		if (world[i - 1] < 2) return 1;
		world[i - 1] = world[i];
		world[i] = prev;
	  }
	}

	//No Collision detected, continue to next frame
	world[15] = 32;
	if (world[16] < 2) world[16] = 32;
	return 0;
}

void update_world() {
	int game_over = scroll_world();
	if (jumping ==1){
		MoveCursor(1,1);
		CharLCD(32);
		MoveCursor(1,0);
		CharLCD(0);
		world[1] = 0;
		world[17] = 32; 
	}
	
	// Maximum score achieved
	if (score == 999) {
		EraseLCD();
		MoveCursor(0,0);
		StringLCD("    GANASTE ");
		MoveCursor(0,1);
		CharLCD(0); CharLCD(32); CharLCD(2); CharLCD(2); CharLCD(2);
		CharLCD(3); CharLCD(3); CharLCD(3); CharLCD(3); CharLCD(3); CharLCD(3);
		CharLCD(2); CharLCD(2); CharLCD(2); CharLCD(32); CharLCD(1);
		for (i=0; i<120; i++) 
		{
			PORTC.1=1;
			delay_us(835);
			PORTC.1=0;
			delay_us(835);
		}
		restart=1;
		delay_ms(3000);
		score=0;
		EraseLCD();
	}
	
	//Game over condition 
	if (game_over) {
		EraseLCD();
		MoveCursor(0,0);
		CharLCD(0);
		CharLCD(3);
		StringLCD("  PERDISTE  "); 
		CharLCD(3);
		MoveCursor(0,1);
		if (score>=hs) hs = score;  
		sprintf(charArrayDisplay,"S:%i  HS:%i", score, hs);
		StringLCDVar(charArrayDisplay);
		for (i=0; i<60; i++) 
		{
			PORTC.1=1;
			delay_us(1650);
			PORTC.1=0;
			delay_us(1650);
		}
		restart=1;
		delay_ms(3000);
		score=0;
		EraseLCD();
	}        
	
	//Update score
	score++;
	MoveCursor(13,0);    
	sprintf(charArrayDisplay,"%i", score);
	StringLCDVar(charArrayDisplay);
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
	CreateChar(2,cacti_small);
	CreateChar(3,cacti_big);

	while (1)
	{
		allow_jump = allow_jump ^ 1;
		if (PINC.0==0 && allow_jump == 1) {
			jumping =1;
			// Jumping Animation
			MoveCursor(1,1);
			CharLCD(32);
			MoveCursor(1,0);
			CharLCD(0);
			world[1] = 0;
			world[17] = 32;               
			for (i = 0; i < 4; i++) {
				MoveCursor(1,1);
				CharLCD(32);
				MoveCursor(1,0);
				CharLCD(0);
				world[1] = 0;
				world[17] = 32; 
				update_world();
			}
			jumping=0;
			world[1] = 32;
			world[17] = 0;             
			MoveCursor(1,0);
			CharLCD(32);
			MoveCursor(1,1);
			CharLCD(0);
			for (i=0; i<80; i++) 
			{
				PORTC.1=1;
				delay_us(1250);
				PORTC.1=0;
				delay_us(1250);
			}
		}
		update_world();
	}
}
