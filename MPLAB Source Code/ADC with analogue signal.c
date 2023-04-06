#include <mega328p.h>
#include <delay.h>

#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (1<<ADLAR))

// Read the 8 most significant bits
// of the AD conversion result
unsigned char read_adc(unsigned char adc_input)
{
ADMUX=adc_input | ADC_VREF_TYPE;
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=(1<<ADSC);
// Wait for the AD conversion to complete
while ((ADCSRA & (1<<ADIF))==0);
ADCSRA|=(1<<ADIF);
return ADCH;
}

void main(void)
{
    
    // ADC initialization
    // ADC Clock frequency: 500.000 kHz
    // ADC Voltage Reference: AVCC pin
    // ADC Auto Trigger Source: ADC Stopped
    // Only the 8 most significant bits of
    // the AD conversion result are used
    // Digital input buffers on ADC0: Off, ADC1: Off, ADC2: Off, ADC3: Off
    // ADC4: Off, ADC5: Off
    DIDR0=(1<<ADC5D) | (1<<ADC4D) | (1<<ADC3D) | (1<<ADC2D) | (1<<ADC1D) | (1<<ADC0D);
    ADMUX=ADC_VREF_TYPE;
    ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (1<<ADPS0);
    ADCSRB=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
    
    DDRB=0x0E; //Outputs PB1, PB2, PB3 (Oscilloscope)
    DDRD=0x68; //Outputs PD3, PD5, PD6 (Oscilloscope)
    
    TCCR0A=0xA1; //Timer 0 in PWM Phase Correct (8bit)
    TCCR0B=0x01; //Timer 0 without Pre-scaler (CK x 1)  

    TCCR1A=0xA1; //Timer 1 in PWM Phase Correct (8bit)
    TCCR1B=0x01; //Timer 1 without Pre-scaler (CK x 1) 
    
    TCCR2A=0xA1; //Timer 2 in PWM Phase Correct (8bit)
    TCCR2B=0x01; //Timer 2 without Pre-scaler (CK x 1) 
    
    while (1)
    {
        // Assign the analog values 8-bit (pot) to the compare registers of every timer
        OCR0A=read_adc(0);
        OCR0B=read_adc(1);
        OCR1AH=0x00;
        OCR1AL=read_adc(2);
        OCR1BH=0x00;
        OCR1BL=read_adc(3);
        OCR2A=read_adc(4);
        OCR2B=read_adc(5);

    }
}
