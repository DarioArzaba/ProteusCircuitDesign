#include <MEGA328P.h>
#include <delay.h>
#include <stdio.h>
#include <ff.h>
#include "display.h"

char NombreArchivo[]  = "0:Hola.txt";
char TextoEscritura[] = "Escribiendo en un archivo mediante el AVR en la SD.";

interrupt [TIM1_COMPA] void timer1_compa_isr(void)
{
disk_timerproc();
/* MMC/SD/SD HC card access low level timing function */
}
    

void main()
{
    unsigned int  br;
    char buffer[100];
    
    /* FAT function result */
    FRESULT res;
    
    /* will hold the information for logical drive 0: */
    FATFS drive;
    FIL archivo; // file objects
    
    /*Configurar el PORTB I/O*/
    DDRB=0b11101101;
    
    // Código para hacer una interrupción periódica cada 10ms
    // Timer/Counter 1 initialization
    // Clock source: System Clock
    // Clock value: 1000.000 kHz
    // Mode: CTC top=OCR1A
    // Compare A Match Interrupt: On
    TCCR1B=0x09;
    OCR1AH=0x27;
    OCR1AL=0x10;
    TIMSK1=0x02;
    ConfiguraLCD();
    #asm("sei")
    /* Inicia el puerto SPI para la SD */
    disk_initialize(0);
    delay_ms(200);
    
    /* mount logical drive 0: */
    if ((res=f_mount(0,&drive))==FR_OK){
        MoverCursor(0,1);
        StringLCD("Drive Detectado");
        delay_ms(1500);
        
        /*Lectura de Archivo*/
        res = f_open(&archivo, NombreArchivo, FA_OPEN_ALWAYS | FA_WRITE | FA_READ);
        if (res==FR_OK){
            MoverCursor(0,1);
            StringLCD("Archivo Encontrado ");
            delay_ms(1500);
            
            f_read(&archivo, buffer, 10,&br); //leer archivo
            
            MoverCursor(0,1); 
            StringLCD("El Archivo dice:   ");
            delay_ms(1500);
             
            MoverCursor(0,2);
            StringLCDVar(buffer);
            delay_ms(1500);
            
            /*Escribiendo en el mismo Arcvhivo*/
            BorrarLCD();
            MoverCursor(0,1); 
            StringLCD("Escribiendo ...");
            
            /*Saltando un reglon*/
            f_lseek(&archivo, 10); 
            buffer[0] = 0x0D;                //Carriage return   
            buffer[1] = 0x0A;                //Line Feed
            f_write(&archivo,buffer,2,&br);
            /*Escribiendo el Texto*/            
            f_write(&archivo,TextoEscritura,sizeof(TextoEscritura),&br);
            f_close(&archivo);           
            delay_ms(500);
            
            BorrarLCD();
            MoverCursor(0,1); 
            StringLCD("Listo");  
        }              
        else{
            StringLCD("Archivo NO Encontrado");
           
        }
    }
    else{
         StringLCD("Drive NO Detectado");
         while(1);
    }
    f_mount(0, 0); //Cerrar drive de SD
    while(1);
}
