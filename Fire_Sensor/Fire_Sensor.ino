const int outPin = 5;
const int LED = 2;

int fire;
void setup() {
  Serial.begin(115200);
  pinMode(outPin, INPUT);
  pinMode(LED, OUTPUT);
}

void loop() {
  fire = digitalRead(outPin);
  if (fire == 0) {
    Serial.print("Fire alarm\n");
    digitalWrite(LED, HIGH);
  }
  else {
    Serial.print(".\n");
  }
  delay(500);
  digitalWrite(LED, LOW);
  delay(500);
}
