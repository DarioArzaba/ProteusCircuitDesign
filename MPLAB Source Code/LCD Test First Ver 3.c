// Use the ADC on PC4 to control the speed of two sets of lights.
// Also implement a switch to use as a selector and change the sets.

#include <mega328p.h>
#include <io.h> 
#include <delay.h>  
#include <stdio.h>
#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR)) // ADV Voltage Ref

unsigned int read_adc(unsigned char adc_input) {
    // Used to Read the Conversion Result
    ADMUX=adc_input | ADC_VREF_TYPE;
    delay_us(10); // ADC Input Voltage Stabilization Delay
    ADCSRA|=(1<<ADSC); // Start Conversion
    while ((ADCSRA & (1<<ADIF))==0); // Wait for Conversion to finish
    ADCSRA|=(1<<ADIF);
    return ADCW;
}

void delayKitt() {
    delay_ms(read_adc(4));
} 

unsigned char Seq1[14]={0x80,0x40,0x20,0x10,0x08,0x04,0x02,0x01,0x02,0x04,0x08,0x10,0x20,0x40};
unsigned char Seq2[6]={0x81,0x42,0x24,0x18,0x24,0x42};
unsigned char i;
void main(void)
{
    ADMUX=ADC_VREF_TYPE; // ADC Voltage Reference: AVCC pin 
    // Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On, ADC4: Off, ADC5: On
    DIDR0=(0<<ADC5D) | (1<<ADC4D) | (0<<ADC3D) | (0<<ADC2D) | (0<<ADC1D) | (0<<ADC0D);
    // ADC Auto Trigger Source: ADC Stopped
    ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
    ADCSRB=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);  

    CLKPR=0x80;
    CLKPR=0x04;
    DDRD=0xFF;
    DDRB=0x03;
    PORTC.0=1;
    while (1)
    {
        if (PINC.0==0)
        {
            for (i=0; i<14;i++)
            {
                PORTD=Seq1[i];
                PORTB=(PORTB&0xFC)|(Seq1[i]&0x03); 
                delayKitt();
                if (PINC.0==1) { break; }
            }
        }
        else 
        {
            for (i=0; i<6;i++)
            {
                PORTD=Seq2[i];
                PORTB=(PORTB&0xFC)|(Seq2[i]&0x03); 
                delayKitt();
                if (PINC.0==0) { break; }
            }
        }
    }
}
