//Declaraci�n de var�ales.
float x0=0, x1=0, x2=0, y0=0, y1=0, y2=0;
unsigned int YY;
//Declaraci�n de la funci�n de interrupciones.
void interrupt ( void )
{
     if( INTCON.F2 )
     {
         TMR0L=135;
         //Timer0 con periodo de 774,4u segundo.
         // Fs = 1291,32 Hz.
         //Adquisici�n de una muestra de 10 bits en, x[0].
         x0 = (float)(ADC_Read(0)-512.0);
         //Implementaci�n de la ecuaci�n en diferencias.
         y0 = (x0+x2)*0.0436286852600961 + x1*0.0872573705201923 + y1*1.32843480532316
         -y2*0.502949546363549;
         //Corrimiento de los valores x(n), y y(n).
         y2 = y1;
         y1 = y0;
         x2 = x1;
         x1 = x0;
         //Reconstrucci�n de la se�al: y en 10 bits.
         YY = (unsigned int)(y0+512.0);
         PORTC = (YY>>8)&3;
         PORTB = YY&255;
         INTCON.F2=0;
     }
}

void main( void )
{
     //Inicio del puerto B como salida.
     TRISB = 0;
     PORTB = 0;
     TRISC = 0;
     PORTC = 0;
     //Se configura TIMER 0, su interrupci�n.
     INTCON = 0b10100000;
     T0CON  = 0b11000101;
     while(1)//Bucle infinito.
     {
     }
}