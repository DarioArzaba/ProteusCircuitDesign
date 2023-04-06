
int referencia = 511; // Valor deseado
// byte pinEncoder = A2; (Utilizar en vez de la referencia)
// int valorActualEncoder = 0; (Utilizar junto con el pin del Encoder)
// float integracionError = 0;
// float integracionPasada = 0;
// int valorPasadoPotenciometro = valorActualPotenciometro;

byte pinPotenciometro = A3; // Señal de entrada del potenciometro 0 a 1023 mapeados a un voltaje de 0 a 5 V
int pinControlPWM = 3; // Señal de salida PWM para el control de velocidad mediante enable
int pinDireccionMotor1 = 5; // Señal de salida de direccion del motor 1
int pinDireccionMotor2 = 6; // Señal de salida direccion del motor 2
int valorActualPotenciometro = 0; // Valor del potenciometro temporal para realizar calculos.
int PWM = 0; // Valor que se enviara al pin de control PWM (3)
float error = 0; // Valor de la señal de error del sistema de control.
float errorPasado = 0; // Referencia al error anterior
float control = 0.1; // Valor de la señal de control del sistema de control
float controlMin = -12;
float controlMax = 12;
float KP = 0.2; // Constante proporcional para el sistema de control P.
float KD = 2.0; // Constante derivativo para el sistema de control PD.
float KI = 0.0; // Constante integral para el sistema de control PID.
int valorSaturacionMinima = 50; // Constante para saturar el sistema. 1
int valorSaturacionMaxima = 255; // Constante para saturar el sistema. 5
int unidadTiempo;
unsigned long tiempoActual;
unsigned long tiempoPasado = 0;

// const unsigned long eventInterval = 1500;
bool satMinAct = false;
bool satMaxAct = false;

void setup() {
  Serial.begin (9600);
  pinMode(pinControlPWM, OUTPUT);
  pinMode(pinDireccionMotor1,OUTPUT);
  pinMode(pinDireccionMotor2, OUTPUT);
}

void loop() {

  satMinAct = false;
  satMaxAct = false;

  valorActualPotenciometro = analogRead(pinPotenciometro); // Pot con valor entre 0 y 1023
  // valorActualEncoder = analogRead(pinEncoder);
  tiempoActual = millis(); 
  unidadTiempo = (tiempoActual - tiempoPasado);
  error = referencia - valorActualPotenciometro; // NOTA: Luego cambiar la referencia por valorActualEncoder
  // integracionError = integracionPasada + (unidadTiempo * (error + errorPasado) / 2);
  // control = KP * error + KI * integracionError + (KD * (error - errorPasado) / unidadTiempo); USAR PARA PID
  control = (KP * error) + (KD * (error - errorPasado) / unidadTiempo);

  if (control > controlMax) {
    control = controlMax;
    // integracionError = integracionPasada;
  }
  
  if (control < controlMin) {
    control = controlMin;
    // integracionError = integracionPasada;
    // valorPasadoPotenciometro = valorActualPotenciometro;
  }

  PWM = int(255 * abs(control) / controlMax);

  if (PWM < valorSaturacionMinima) {PWM = valorSaturacionMinima; satMinAct = true;}
  if (PWM >= valorSaturacionMaxima) {PWM = valorSaturacionMaxima; satMaxAct = true;}

  if (control > 0) {digitalWrite(pinDireccionMotor1, HIGH); digitalWrite(pinDireccionMotor2, LOW); }
  else if (control < 0) { digitalWrite(pinDireccionMotor1, LOW); digitalWrite(pinDireccionMotor2, HIGH); }
  else { digitalWrite(pinDireccionMotor1, LOW); digitalWrite(pinDireccionMotor2, LOW); }

  analogWrite(pinControlPWM, PWM); // Señal de salida

  // integracionPasada = integracionError;
  errorPasado = error;
  tiempoPasado = tiempoActual;

  Serial.println();
  Serial.print("-------------"); Serial.println();
  Serial.print("Pot Feedback: "); Serial.print(valorActualPotenciometro); Serial.println();
  Serial.print("Error: "); Serial.print(error); Serial.println();
  Serial.print("Control: "); Serial.print(control); Serial.println();
  Serial.print("PWM: "); Serial.print(PWM); Serial.println();
  Serial.print("Sat Min: ");  Serial.print(satMinAct); Serial.println();
  Serial.print("Sat Max: "); Serial.print(satMaxAct); Serial.println();
  Serial.print("Direccion: "); Serial.print(digitalRead(pinDireccionMotor1)); Serial.print(" , "); Serial.print(digitalRead(pinDireccionMotor2)); Serial.println();
  Serial.print("-------------");
  delay(10);

}