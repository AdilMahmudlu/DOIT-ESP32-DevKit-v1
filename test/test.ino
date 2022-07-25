const int outPin1 = 5;
const int outPin2 = 18;
const int outPin3 = 21;

void setup() {
  Serial.begin(115200);
  pinMode(outPin1, OUTPUT);
  pinMode(outPin2, OUTPUT);
  pinMode(outPin3, OUTPUT);
}

void loop() {
  if(Serial.available()) {
    int val = Serial.read();

    if(val%2 == 1) {
      digitalWrite(outPin1, HIGH);
    }
    else {
      digitalWrite(outPin1, LOW);
    }
    if(val%3 == 1) {
      digitalWrite(outPin2, HIGH);
    }
    else {
      digitalWrite(outPin2, LOW);
    }
    if(val%5 == 1) {
      digitalWrite(outPin3, HIGH);
    }
    else {
      digitalWrite(outPin3, LOW);
    }
  }
}
