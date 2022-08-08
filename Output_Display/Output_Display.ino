#include <DFRobot_DHT11.h>
#include <MQ135.h>

const int tempOut = 21;

const int gasOut = 15;

const int usTrig = 5;
const int usEcho = 18;

const int dustOut = 4;
const int ledIn = 16;

const int reedOut = 22;

const int fireOut = 21;

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

float dustDensity;
int dustM;
int dustL;
int dustD;

int reed;

int fire;

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
  pinMode(dustOut, INPUT);
  pinMode(ledIn, OUTPUT);
  pinMode(reedOut, INPUT);
  pinMode(fireOut, INPUT);
  establishContact();
}

void loop() {
  DHT.read(tempOut);
  temp = DHT.temperature;
  hum = DHT.humidity;
  
  gasM = (int)analogRead(gasOut)/256;
  gasL = (int)analogRead(gasOut)%256;

  fire = digitalRead(fireOut);

  reed = digitalRead(reed);

  digitalWrite(ledIn, LOW);
  delayMicroseconds(280);
  dustDensity = 0.17*(analogRead(dustOut)(5.0/4096))-0.1;
  delayMicroseconds(40);
  digitalWrite(ledIn, HIGH);
  delayMicroseconds(9680);
  if(dustDensity < 0) {dustDensity = 0.00;}
  dustM = (int)dustDensity/256;
  dustL = (int)dustDensity%256;
  dustD = (int)(dustDensity*100)%100;
    
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
    Serial.write(dustM);
    Serial.write(dustL);
    Serial.write(dustD);
    Serial.write(reed);
    Serial.write(fire);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}
