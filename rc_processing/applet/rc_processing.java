import processing.core.*; 
import processing.xml.*; 

import processing.serial.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class rc_processing extends PApplet {



Serial port;

public void setup() {
  size(256, 150);
  println("Available serial ports:");
  println(Serial.list());

  port = new Serial(this, Serial.list()[0], 1200);
}

public void draw() {
//  port.write('0');

}

public void keyPressed() {
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

public void keyReleased() {
  port.write('0');
  delay(10);
  println("STOP");
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "rc_processing" });
  }
}
