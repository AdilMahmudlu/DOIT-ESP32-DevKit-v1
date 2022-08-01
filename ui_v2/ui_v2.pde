import controlP5.*;
import processing.serial.*;

Serial port;
int[] serialArray = new int[6];
int serialCount = 0;

ControlP5 cp5;
PFont font;

boolean tempSensor = false;
boolean gasSensor = false;
boolean ultrasoundSensor = false;
boolean firstContact = false;

int temp;
int hum;
int gasM;
int gasL;
int dist_1;
int dist_2;

void setup() {
  size(500, 600);
  port = new Serial(this, "COM4", 9600);
  cp5 = new ControlP5(this);
  
  font = createFont("cambria math", 20);
  
  cp5.addToggle("tempSensor").setPosition(175, 100)
  .setSize(150, 120)
  .setFont(font)
  .setValue(false)
  .setCaptionLabel("Temperature \nand Humidity")
  .setColorLabel(color(0, 20, 20))
  .setColorBackground(color(0, 100, 100))
  .setColorForeground(color(0, 150, 150))
  .setColorActive(color(0, 200, 200))
  .getCaptionLabel()
  .toUpperCase(false)
  //.align(CENTER, CENTER)
  .setPaddingX(20)
  .setPaddingY(-80);
  
  cp5.addToggle("gasSensor").setPosition(175, 275)
  .setSize(150, 120)
  .setFont(font)
  .setValue(false)
  .setCaptionLabel("Gas")
  .setColorLabel(color(0, 20, 20))
  .setColorBackground(color(0, 100, 100))
  .setColorForeground(color(0, 150, 150))
  .setColorActive(color(0, 200, 200))
  .getCaptionLabel()
  .toUpperCase(false)
  .align(CENTER, CENTER);
  
  cp5.addToggle("ultrasoundSensor").setPosition(175, 450)
  .setSize(150, 120)
  .setFont(font)
  .setValue(false)
  .setCaptionLabel("Ultrasound \n Distance")
  .setColorLabel(color(0, 20, 20))
  .setColorBackground(color(0, 100, 100))
  .setColorForeground(color(0, 150, 150))
  .setColorActive(color(0, 200, 200))
  .getCaptionLabel()
  .toUpperCase(false)
  .align(CENTER, CENTER);
  
  cp5.addTextfield("temp")
  .setPosition(50,125)
  .setSize(80,30)
  .setFont(font)
  .setFocus(false)
  .setColor(color(0,0,0))
  .setCaptionLabel("Temperature")
  .setColorBackground(color(200, 255, 255))
  .setColorLabel(color(50, 100, 100))
  .getCaptionLabel()
  .toUpperCase(false)
  ;
}

void draw() {
  background(255, 200, 150);
  fill(0, 0, 0);
  textFont(font);
  text("Welcome", 225, 50);
  if(tempSensor == true) {
    text(temp, 400, 125);
    text(hum, 400, 140);
  }
  if(gasSensor == true) {
    text(gasM*256+gasL, 400, 325);
  }
  if(ultrasoundSensor == true) {
    text(dist_1+dist_2/100.0, 400, 500);
  }
}

void serialEvent(Serial port) {
  int inByte = port.read();
  if(firstContact == false) {
    if(inByte == 'A') {
      port.clear();
      firstContact = true;
      port.write('A');
    }
  }
  else {
    serialArray[serialCount] = inByte;
    serialCount++;
    if(serialCount > 5) {
       temp = serialArray[0];
       hum = serialArray[1];
       gasM = serialArray[2];
       gasL = serialArray[3];
       dist_1 = serialArray[4];
       dist_2 = serialArray[5];
       port.write('A');
       serialCount = 0;
    }
  }
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println(theEvent.getName() + ": " + theEvent.getStringValue());
  }
}
