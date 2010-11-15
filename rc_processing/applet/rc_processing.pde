import processing.serial.*;

Serial port;

void setup() {
  size(256, 150);
  println("Available serial ports:");
  println(Serial.list());

  port = new Serial(this, Serial.list()[0], 1200);
}

void draw() {
//  port.write('0');

}

void keyPressed() {
  switch(keyCode) {
    case UP:
      port.write('1');
      println("UP!");
      delay(200);
      break;
    case DOWN :
      port.write('2');
      println("DOWN!");
      delay(200);
      break;
    case RIGHT:
      port.write('5');
      println("RIGHT!");
      delay(10);
      break;
    case LEFT:
      port.write('6');
      println("LEFT!");
      delay(10);
      break;
    default:
      println("[RTFM]");
  }

}

void keyReleased() {
  port.write('0');
  delay(10);
  println("STOP");
}

