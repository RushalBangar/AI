int pirPin = 2;      // PIR sensor output pin
int ledPin = 13;    // LED pin
int pirState = LOW; // Current state
int val = 0;        // Variable to read PIR sensor

void setup() {
  pinMode(pirPin, INPUT);
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  val = digitalRead(pirPin);  // Read PIR sensor value

  if (val == HIGH) {          // Motion detected
    digitalWrite(ledPin, HIGH);
    if (pirState == LOW) {
      Serial.println("Motion detected!");
      pirState = HIGH;
    }
  } 
  else {                      // No motion
    digitalWrite(ledPin, LOW);
    if (pirState == HIGH) {
      Serial.println("Motion ended!");
      pirState = LOW;
    }
  }
}
