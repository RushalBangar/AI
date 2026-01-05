#include <SoftwareSerial.h>

SoftwareSerial esp8266(2, 3); // RX, TX

String ssid = "Aditya";
String password = "12345678";
String apiKey = "Q3DL9OGVNT5YKHJL";
String server = "api.thingspeak.com";

void setup() {
  Serial.begin(9600);
  esp8266.begin(115200);

  delay(2000);

  sendCommand("AT", 2000);
  sendCommand("AT+CWMODE=1", 2000);

  String cmd = "AT+CWJAP=\"" + ssid + "\",\"" + password + "\"";
  sendCommand(cmd, 6000);
}

void loop() {
  int adcValue = analogRead(A0);

  // Convert ADC → Voltage → Temperature
  float voltage = adcValue * (5.0 / 1023.0);
  float temperature = voltage * 100.0;

  Serial.print("Temperature: ");
  Serial.println(temperature);

  sendDataToCloud(temperature);

  delay(15000); // ThingSpeak limit
}

// -------- Functions --------

void sendDataToCloud(float temp) {
  String data = "GET /update?api_key=" + apiKey + "&field1=" + String(temp) + "\r\n";

  sendCommand("AT+CIPSTART=\"TCP\",\"" + server + "\",80", 3000);
  sendCommand("AT+CIPSEND=" + String(data.length()), 2000);
  esp8266.print(data);

  delay(2000);
  sendCommand("AT+CIPCLOSE", 1000);
}

void sendCommand(String command, int waitTime) {
  esp8266.println(command);
  delay(waitTime);

  while (esp8266.available()) {
    Serial.write(esp8266.read());
  }
}
