#include <VirtualWire.h>

#define DEBUG 0

char* prefix = "BREDA";

int ledPin = 13;
int dataPin = 8;

char buf[6];
char rx_data;

void setup() {
  Serial.begin(9600);

  vw_set_ptt_inverted(true);
  vw_setup(2000);
  vw_set_tx_pin(dataPin);
}

void loop() {
  
   Serial.println("LOL");
/*
    sprintf(buf, "%s%c", prefix, '1');
    const char *msg = (const char*) buf;
for(int i=0; i < 10; i++) {
    vw_send((uint8_t *)msg, strlen(msg));
    vw_wait_tx();
    delay(200);
}
*/
  if (Serial.available()) {
   char rx_data = (char)Serial.read();
   sprintf(buf, "%s%c", prefix, rx_data);
   const char *msg = (const char*) buf;
   Serial.println(msg);
  vw_send((uint8_t *)msg, strlen(msg));
  vw_wait_tx();
  }

}

