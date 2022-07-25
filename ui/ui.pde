import controlP5.*;
import processing.serial.*;

Serial port;

ControlP5 cp5;
PFont font;
int a;
boolean five = false;
boolean eighteen = false;
boolean twentyone = false;
void setup() {
  size(500, 600);
  port = new Serial(this, "COM4", 115200);
  
  cp5 = new ControlP5(this);
  font = createFont("cambria math", 20);
  
  
  cp5.addToggle("five").setPosition(175, 100).setSize(150, 120).setFont(font).setValue(false);
  cp5.addToggle("eighteen").setPosition(175, 275).setSize(150, 120).setFont(font).setValue(false);
  cp5.addToggle("twentyone").setPosition(175, 450).setSize(150, 120).setFont(font).setValue(false);
}

void draw() {
  background(200, 200, 200);
  a = 1;
  fill(0, 0, 0);
  textFont(font);
  text("TEST", 225, 50);
  if(five == true) {
    a = a*2;
  }
  if(eighteen == true) {
    a = a*3;
  }
  if(twentyone == true) {
    a = a*5;
  }
  port.write(a+1);
}
