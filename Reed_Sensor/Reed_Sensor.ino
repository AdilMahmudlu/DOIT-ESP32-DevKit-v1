const int outPin = 4;
const int LED = 2;

float reed;
void setup() {
  Serial.begin(115200);
  pinMode(outPin, INPUT);
  pinMode(LED, OUTPUT);
}

void loop() {
  reed = digitalRead(outPin);
  if (reed) {
    digitalWrite(LED, HIGH);
  }
  else {
    digitalWrite(LED, LOW);
  }
  Serial.println(reed);
  delay(1000);
}