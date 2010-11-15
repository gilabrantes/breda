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
     
    int rx_data_i = decodeMsg(buf, buflen);

    switch(rx_data_i) {
      case STOP:
        stop();
        break;
      case FW:
        front();
        break;
      case RR:
        back();
        break;
      case TR:
        right();
        break;
      case TL:
        left();
        break;
      case ON:
        on();
        break;
      case OFF:
        off();
        break;
      case LEDON:
        ledOn();
        break;
      case LEDOFF:
        ledOff();
        break;
      default:
        blink_error();
    }
  }

}

void stop() {
  stopWheel(speedPinL, speedPin2L);
  stopWheel(speedPinR, speedPin2R);
}

void front() {
  runWheelFront(speedPinL, speedPin2L);
  runWheelFront(speedPinR, speedPin2R);
}

void back() {
  runWheelBack(speedPinL, speedPin2L);
  runWheelBack(speedPinR, speedPin2R);
}

void right() {
  runWheelFront(speedPinL, speedPin2L);
  runWheelBack(speedPinR, speedPin2R);
}

void left() {
  runWheelBack(speedPinL, speedPin2L);
  runWheelFront(speedPinR, speedPin2R);
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

void stopWheel(int _speedPin, int _speedPin2) {
  if (DEBUG) Serial.println("Stop!");
  digitalWrite(_speedPin, HIGH);
  digitalWrite(_speedPin2, HIGH);
}

void runWheelFront(int _speedPin, int _speedPin2) {
  if (DEBUG) Serial.println("front!");
  digitalWrite(_speedPin, HIGH);
  digitalWrite(_speedPin2, LOW);
}

void runWheelBack(int _speedPin, int _speedPin2) {
  if (DEBUG) Serial.println("Back!");
  digitalWrite(_speedPin, LOW);
  digitalWrite(_speedPin2, HIGH);
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

