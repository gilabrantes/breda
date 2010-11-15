#include <VirtualWire.h>
#include "Wire.h"
#include "WiiChuck.h"

#define DEBUG 0

char* prefix = "BREDA";

int ledPin = 13;
int dataPin = 8;

char buf[6];
char rx_data;

WiiChuck chuck = WiiChuck();
int angleStart, currentAngle;
int tillerStart = 0;

void setup() {
  Serial.begin(9600);

  vw_set_ptt_inverted(true);
  vw_setup(2000);
  vw_set_tx_pin(dataPin);

  chuck.begin();
  chuck.update();
}

void loop() {
  
  delay(20);
  chuck.update();
//Serial.print(chuck.readRoll());
 //   Serial.print(", ");  
  //Serial.print(chuck.readPitch());
   // Serial.print(", ");  

    Serial.print((int)chuck.readJoyX());
    Serial.print(", ");  
    Serial.print((int)chuck.readJoyY());
    Serial.print(", ");  

    Serial.println();
  

}

