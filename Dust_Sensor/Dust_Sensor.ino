int measurePin = 4;
int ledPower = 5;

int samplingTime = 280;
int deltaTime = 40;
int sleepTime = 9680;

float measuredV = 0;
float vOut = 0;
float dustDensity = 0;

void setup(){
  Serial.begin(115200);
  pinMode(ledPower,OUTPUT);
}

void loop(){
  digitalWrite(ledPower,LOW);
  delayMicroseconds(samplingTime);

  measuredV = analogRead(measurePin);

  delayMicroseconds(deltaTime);
  digitalWrite(ledPower,HIGH);
  delayMicroseconds(sleepTime);

  vOut = measuredV *(5.0/4096);
  dustDensity = 0.17*vOut-0.1;

  if ( dustDensity < 0)
  {
    dustDensity = 0.00;
  }
  Serial.println("----------------------");
  Serial.println("Raw Signal Value (0-4096):");
  Serial.println(measuredV);

  Serial.println("Voltage:");
  Serial.println(vOut);

  Serial.println("Dust Density:");
  Serial.println(dustDensity);

  delay(1000);
}
