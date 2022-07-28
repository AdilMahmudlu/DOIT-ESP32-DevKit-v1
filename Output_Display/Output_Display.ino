#include <DFRobot_DHT11.h>

const int tempOut = 21;

const int gasOut = 15;

const int usTrig = 5;
const int usEcho = 18;

int temp;
int  hum;
DFRobot_DHT11 DHT;

int gas;

long duration;
float distance;
float soundSpeed = 0.034;

int dist_1;
int dist_2;

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
  
  gas = analogRead(gasOut);
  
  digitalWrite(usTrig, LOW);
  delayMicroseconds(2);
  digitalWrite(usTrig, HIGH);
  delayMicroseconds(10);
  digitalWrite(usTrig, LOW);
  duration = pulseIn(usEcho, HIGH);
  distance = duration * soundSpeed/2;
  dist_1 = (int)distance;
  dist_2 = ((int)(distance*1000))%1000;
  
  if (Serial.available() > 0) {
    inByte = Serial.read();
    Serial.write(temp);
    Serial.write(hum);
    Serial.write(gas);
    Serial.write(dist_1);
    Serial.write(dist_2);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}
