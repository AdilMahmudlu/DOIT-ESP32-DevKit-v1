const int outPin = 4;
float gas;

void setup() {
  Serial.begin(115200);
  pinMode(outPin, INPUT);
}

void loop() {
  gas = analogRead(outPin);
  Serial.print("PPM: ");
  Serial.println(gas);
  delay(1000);
}
