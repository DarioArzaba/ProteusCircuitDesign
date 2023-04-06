    #include <io.h> 
    #include <delay.h>  
    #include <stdio.h>
   
            
// Voltage Reference: AVCC pin
#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR))

// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
    ADMUX=adc_input | ADC_VREF_TYPE;
    // Delay needed for the stabilization of the ADC input voltage
    delay_us(10);
    // Start the AD conversion
    ADCSRA|=(1<<ADSC);
    // Wait for the AD conversion to complete
    while ((ADCSRA & (1<<ADIF))==0);
    ADCSRA|=(1<<ADIF);
    return ADCW;
}

void delayKitt()
{
    delay_ms(read_adc(4));
} 
 
unsigned char Kitt1[6]={0x81,0x42,0x24,0x18,0x24,0x42};
unsigned char i;
  
void main()
{
    // ADC initialization
    // ADC Voltage Reference: AVCC pin
    // ADC Auto Trigger Source: ADC Stopped
    // Digital input buffers on ADC0: On, ADC1: On, ADC2: On, ADC3: On
    // ADC4: Off, ADC5: On
    DIDR0=(0<<ADC5D) | (1<<ADC4D) | (0<<ADC3D) | (0<<ADC2D) | (0<<ADC1D) | (0<<ADC0D);
    ADMUX=ADC_VREF_TYPE;
    ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
    ADCSRB=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);       
    
    DDRD=0xFF;
    DDRB=0x03;
             
    while(1)
    {      
//         PORTD.2=0;
//         delayKitt();
//         PORTD.2=1;
//         delayKitt();  
          for (i=0; i<6;i++)
          {
            PORTD=Kitt1[i];
            PORTB=(PORTB&0xFC)|(Kitt1[i]&0x03); 
            delayKitt();
          }
         
    }    
}
