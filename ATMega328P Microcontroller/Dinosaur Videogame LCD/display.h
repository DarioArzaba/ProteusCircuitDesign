 
    //Librería del display de cuarzo líquido
    //Si se cambian la conexiones: cambiar las definiciones de abajo
    //y la configuración de los pines de salida en ConfiguraLCD()
    
    //incluírla en el directorio de tu proyecto y mandarla llamar como: #include "display.h"    

    #define EN PORTB.6
    #define RS PORTB.7    
    #define Backlight PORTB.2     
    #define D4 PORTC.0
    #define D5 PORTC.1
    #define D6 PORTC.2
    #define D7 PORTC.3      
           
    unsigned char cursor;

#pragma used+

void MandaLineasDatosLCD(unsigned char dato);
void EscribeComLCD(unsigned char Comando);
void PulsoEn();

/* Procedimiento para configurar el LCD. Es necesaria ejecutar al inicio para el correcto funcionamiento */
/* en un LCD físico (no es crítico para simulcación sólo en Proteus*/
void ConfiguraLCD()
{
    unsigned char TablaInicializacion[12]={3,3,3,2,2,12,0,8,0,1,0,6};
    unsigned char i;   
    
    DDRC=DDRC|0x0F;      //Cambiar a salida aquellos pines de ser necesario 
    DDRB=DDRB|0xC0;      //Cambiar a salida aquellos pines de ser necesario   
    delay_ms(50);
    for (i=0;i<12;i++)
    {
      delay_ms(2);    
      MandaLineasDatosLCD(TablaInicializacion[i]);     
      PulsoEn();
      
    } 
    cursor=0x0C;       //Display ON, sin cursor underscore, sin cursor parpadenate
    EscribeComLCD(cursor);  
    
}       
    
/* Procedimiento para prender la luz de fondo del LCD */
/* contectar al micro por medio de un diodo para bajar el voltaje a 4.3Volts*/
void BacklightON()
{
   Backlight=1;
}

/* Procedimiento para apagar la luz de fondo del LCD */
void BacklightOFF()
{
   Backlight=0;
}
    

void PulsoEn()
{
     EN=1;
     EN=0;
}

void MandaLineasDatosLCD(unsigned char dato)
{
     if ((dato&0x08)!=0)
          D7=1;
     else
          D7=0;   
     if ((dato&0x04)!=0)
          D6=1;
     else
          D6=0;   
     if ((dato&0x02)!=0)
          D5=1;
     else
          D5=0;      
     if ((dato&0x01)!=0)
          D4=1;
     else
          D4=0;   
}

void EscribeComLCD(unsigned char Comando)
{
    unsigned char tempComando;
    RS=0;
    delay_ms(2);
    tempComando=Comando&0xF0;
    tempComando=tempComando>>4;  
    MandaLineasDatosLCD(tempComando);
    PulsoEn();
    tempComando=Comando&0x0F;    
    MandaLineasDatosLCD(tempComando);
    delay_ms(2);
    PulsoEn();
}

void LetraDatoLCD(unsigned char dato)
{
    unsigned char tempdato;
    RS=1;
    delay_ms(2);
    tempdato=dato&0xF0;
    tempdato=tempdato>>4;    
    MandaLineasDatosLCD(tempdato);
    PulsoEn();
    tempdato=dato&0x0F;
    MandaLineasDatosLCD(tempdato);
    delay_ms(2);
    PulsoEn();
}

/* Procedimiento que manda una letra al LCD en donde se encuentre el cursor*/
void LetraLCD(unsigned char dato)
{
    unsigned char tempdato;
    RS=1;
    delay_ms(2);
    tempdato=dato&0xF0;
    tempdato=tempdato>>4;    
    MandaLineasDatosLCD(tempdato);
    PulsoEn();
    tempdato=dato&0x0F;
    MandaLineasDatosLCD(tempdato);
    delay_ms(2);
    PulsoEn();
}

/* Procedimiento que manda un string fijo al LCD en donde se encuentre el cursor*/
void StringLCD(flash unsigned char Mensaje[])
{
 unsigned char i;
 i=0;
 do{
   LetraLCD(Mensaje[i++]); 
 }while(Mensaje[i]!=0);
}       

/* Procedimiento que manda un string variable (que cambie durante la ejecución) */
/* al LCD en donde se encuentre el cursor*/
void StringLCDVar(unsigned char Mensaje[])     
{
 unsigned char i;
 i=0;
 do{
   LetraLCD(Mensaje[i++]); 
 }while(Mensaje[i]!=0);
}

/* Procedimiento que borra el LCD */
void BorrarLCD( )
{
   EscribeComLCD(1);  
}

/* Mueve el cursor a la poscición (x,y)  */
/*   x: número de columna 0 a 19         */
/*   y: número de renglón 0,1,2 ó 3      */
void MoverCursor(unsigned char x, unsigned char y)
{
    switch (y)
    {   
      case(0):
         EscribeComLCD(0x80+x);
         break; 
      case(1):
        EscribeComLCD(0xC0+x);  
        break;   
      case(2):
        EscribeComLCD(0x94+x);  
        break;  
      case(3):
        EscribeComLCD(0xD4+x);  
        break;             
        }   
} 

/* Configura el cursor para aparecer con el caracter underscore "_" */
void UnderscoreCursor()
{
    cursor=cursor|0x02;
    EscribeComLCD(cursor);
}

/* Configura el cursor para no aparecer con el caracter underscore "_" */
void NoUnderscoreCursor()
{
    cursor=cursor&0xFD;
    EscribeComLCD(cursor);
}

/* Configura el cursor para aparecer parpadenado */
void BlinkCursor()
{
    cursor=cursor|0x01;
    EscribeComLCD(cursor);
}

/* Configura el cursor para no aparecer parpadenado */
void NoBlinkCursor()
{
    cursor=cursor&0xFE;
    EscribeComLCD(cursor);
}
      
/* Procedimiento que apaga el LCD pero los contenidos siguen en memoria */
void DisplayOFF()
{
    cursor=cursor&0xFB;
    EscribeComLCD(cursor);
}


/* Procedimiento que prende el LCD y muestra los contenidos siguen en memoria */
void DisplayON()
{
    cursor=cursor|0x04;
    EscribeComLCD(cursor);
}


/* Procedimiento que CreaCaracter en la memoria RAM del LCD 
   Parámetros: NoCaracter.- número entre 0 y 7 (puedes tener 8 caracteres diferentes 
             datos[8].- arreglo de 8 bytes que contienen el mapa de pixeles del caracter a generar.
                        bit en 1 punto pixel prendido.
                        
                         0x00
             $ $         0x0A
            $ $ $        0x15
            $   $        0x11
             $ $         0x0A
              $          0x04
             
   Ejemplo: unsigned char Letra0[8] = {0x00, 0x0A, 0x15, 0x11, 0x0A, 0x04};   //Caracter como un corazón
                          CreaCaracter(0, Letra0);
                          
   Para desplegar el caracter especial se pondria: LetraLCD(0);  (el 0 cambiaría por el número de letra si es el caso)
   
   Importante: cuando mandas llamar CreaCaracter el cursor se mueve a la primera poscición del LCD */                       

void CreaCaracter(unsigned char NoCaracter, unsigned char datos[8])
{
     unsigned char i;
     EscribeComLCD(0x40+NoCaracter*8);   
     for (i=0;i<8;i++)
        LetraDatoLCD(datos[i]);  
     EscribeComLCD(0x80);   
}

#pragma used-