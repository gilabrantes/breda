#include <VirtualWire.h>
#include <stdlib.h>

#define DEBUG 1
#define LEDON 99
#define LEDOFF 98

#define STOP 0
#define FW 1
#define RR 2
#define OFF 3
#define ON 4
#define TR 5
#define TL 6

char prefix[] = "BREDA";

int enablePinL = 5;
int speedPinL = 6;
int speedPin2L = 7;
int ledPin = 13;

int enablePinR = 2;
int speedPinR = 4;
int speedPin2R = 3;

// rx pins
int rxPin = 8;

void setup() {

  if (DEBUG) {
    Serial.begin(9600);
  }

  pinMode(enablePinL, OUTPUT);
  pinMode(ledPin, OUTPUT);
  pinMode(speedPinL, OUTPUT);
  pinMode(speedPin2L, OUTPUT);

  pinMode(enablePinR, OUTPUT);
  pinMode(speedPinR, OUTPUT);
  pinMode(speedPin2R, OUTPUT);

  //serial connection
  vw_set_ptt_inverted(true);
  vw_setup(2000);
  vw_set_rx_pin(rxPin);
  vw_rx_start();

  // start engine
  on();

}

void loop() {

  uint8_t buf[VW_MAX_MESSAGE_LEN];
  uint8_t buflen = VW_MAX_MESSAGE_LEN;

  if (vw_get_message(buf, &buflen)) {
    if (DEBUG) Serial.println("New message!");
    on();
     
    // get x/y values
    int[] rx_data_i = decodeMsg(buf, buflen);

    


}

void on() {
  digitalWrite(enablePinL, HIGH);
  digitalWrite(enablePinR, HIGH);
}

void off() {
  digitalWrite(enablePinL, LOW);
  digitalWrite(enablePinR, LOW);
}

void blink_error() {
  for(int i=0; i < 10; i++) {
    digitalWrite(ledPin, HIGH);
    delay(30);
    digitalWrite(ledPin, LOW);
  }
}

void stopWheel(int _pin, int _pin2) {
  if (DEBUG) Serial.println("Stop!");
  digitalWrite(_pin, HIGH);
  digitalWrite(_pin2, HIGH);
}

void runWheelFront(int _pin, int _pin2, int _enablePin, int speed) {
  if (DEBUG) Serial.println("front!");
  digitalWrite(_pin, HIGH);
  digitalWrite(_pin2, LOW);
  analogWrite(_enablePin, speed);
}

void runWheelBack(int _pin, int _pin2, int _enablePin, int speed) {
  if (DEBUG) Serial.println("Back!");
  digitalWrite(_pin, LOW);
  digitalWrite(_pin2, HIGH);
  analogWrite(_enablePin, speed);
}

void ledOn() {
  if (DEBUG) Serial.println("Led ON!");
  digitalWrite(ledPin, HIGH);
}

void ledOff() {
  if (DEBUG) Serial.println("Led OFF!");
  digitalWrite(ledPin, LOW);
}

int decodeMsg(uint8_t* buf, uint8_t buflen) {

  int key = -1;
  char result[buflen+1];

  for (int i=0; i < buflen; i++) {
    result[i] = (char)buf[i];
  }
  result[buflen] = '\0';


  if (strncmp(result, prefix, 4) == 0) {
    key = (int)strtol(result+5, NULL, 10);
  }

  if (DEBUG) {
    Serial.print("Decoded message: ");
    Serial.print(result);
    Serial.println(" ");
    Serial.print(key);
    Serial.println(" ");
  }

  return key;
}

