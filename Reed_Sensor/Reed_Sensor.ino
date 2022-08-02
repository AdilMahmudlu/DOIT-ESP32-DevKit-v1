const int outPin = 4;
const int LED = 2;

int reed;
void setup() {
  Serial.begin(9600);
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
