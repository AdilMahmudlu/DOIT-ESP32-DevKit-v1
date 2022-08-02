#include <DFRobot_DHT11.h>
#include <MQ135.h>

const int tempOut = 21;

const int gasOut = 15;

const int usTrig = 5;
const int usEcho = 18;

int temp;
int  hum;
DFRobot_DHT11 DHT;

int gasM;
int gasL;
long duration;
float distance;
float soundSpeed = 0.034;

int distM;
int distL;
int distD;

int inByte = 0;

void setup() {
  // start serial port at 9600 bps:
  Serial.begin(9600);
//  while (!Serial) {
//    ; // wait for serial port to connect. Needed for native USB port only
//  }
  pinMode(tempOut, INPUT);
  pinMode(gasOut, INPUT);
  pinMode(usTrig, OUTPUT);
  pinMode(usEcho, INPUT);
  establishContact();
}

void loop() {
  DHT.read(tempOut);
  temp = DHT.temperature;
  hum = DHT.humidity;
  
  gasM = (int)analogRead(gasOut)/256;
  gasL = (int)analogRead(gasOut)%256;
  
  digitalWrite(usTrig, LOW);
  delayMicroseconds(2);
  digitalWrite(usTrig, HIGH);
  delayMicroseconds(10);
  digitalWrite(usTrig, LOW);
  duration = pulseIn(usEcho, HIGH);
  distance = duration * soundSpeed/2;
  distM = (int)distance/256;
  distL = (int)distance%256;
  distD = ((int)(distance*100))%100;
  
  if (Serial.available() > 0) {
    inByte = Serial.read();
    Serial.write(temp);
    Serial.write(hum);
    Serial.write(gasM);
    Serial.write(gasL);
    Serial.write(distM);
    Serial.write(distL);
    Serial.write(distD);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}
