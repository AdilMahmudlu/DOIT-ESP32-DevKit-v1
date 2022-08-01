#include <DFRobot_DHT11.h>

const int usV = 21;
const int usTrig = 19;
const int usEcho = 18;

const int tempV = 17;
const int tempOut = 16;

const int gasV = 2;
const int gasAOut = 15;

long duration;
float distance;
float soundSpeed = 0.034;

float temp;
//float hum;
DFRobot_DHT11 DHT;

float gas;

void setup() {
  Serial.begin(9600);
  pinMode(usV, OUTPUT);
  pinMode(tempV, OUTPUT);
  pinMode(gasV, OUTPUT);
  pinMode(usTrig, OUTPUT);
  pinMode(usEcho, INPUT);
  pinMode(gasAOut, INPUT);
}

void loop() {
  digitalWrite(usV, HIGH);
  digitalWrite(tempV, HIGH);
  digitalWrite(gasV, HIGH);

  
  DHT.read(tempOut);
  temp = DHT.temperature;
//  hum = DHT.humidity;

  gas = analogRead(gasAOut);
  
  digitalWrite(usTrig, LOW);
  delayMicroseconds(2);
  digitalWrite(usTrig, HIGH);
  delayMicroseconds(10);
  digitalWrite(usTrig, LOW);
  duration = pulseIn(usEcho, HIGH);
  distance = duration * soundSpeed/2;
  
  Serial.print((String)distance + "A" + (String)temp + "B" + (String)gas);
  
//  if(Serial.available()) {
//    int val = Serial.read();
//    Serial.print("S");
//    if(val%2 == 0) {
//      digitalWrite(usV, HIGH);
//      Serial.print(distance);
//    }
//    else {
//      digitalWrite(usV, LOW);
//    }
//    Serial.print("A");
//    if(val%3 == 0) {
//      digitalWrite(tempV, HIGH);
//      Serial.print(temp);
//    }
//    else {
//      digitalWrite(tempV, LOW);
//    }
//    Serial.print("B");
//    if(val%5 == 0) {
//      digitalWrite(gasV, HIGH);
//      Serial.print(gas);
//    }
//    else {
//      digitalWrite(gasV, LOW);
//    }
//    Serial.print("C");
//  }
  delay(1000);
}
