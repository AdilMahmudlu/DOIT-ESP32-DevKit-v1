const int outPin = 15;
float gas;

void setup() {
  Serial.begin(9600);
  pinMode(outPin, INPUT);
}

void loop() {
  gas = analogRead(outPin);
  Serial.print("PPM: ");
  Serial.println(gas);
  delay(1000);
}
