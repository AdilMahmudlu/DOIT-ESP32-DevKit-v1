import controlP5.*;
import processing.serial.*;

Serial port;
int[] serialArray = new int[7];
int serialCount = 0;

ControlP5 cp5;
PFont font;

boolean tempSensor = false;
boolean gasSensor = false;
boolean ultrasoundSensor = false;
boolean firstContact = false;

int temp;
int hum;
int gas;
float dist;

float distLimit = -1;

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
  .setCaptionLabel("Ultrasound\n Distance")
  .setColorLabel(color(0, 20, 20))
  .setColorBackground(color(0, 100, 100))
  .setColorForeground(color(0, 150, 150))
  .setColorActive(color(0, 200, 200))
  .getCaptionLabel()
  .toUpperCase(false)
  .setPaddingX(30)
  .setPaddingY(-80);
  
  cp5.addTextfield("gas")
  .setPosition(50,325)
  .setSize(80,30)
  .setFont(font)
  .setFocus(false)
  .setAutoClear(false)
  .setColor(color(0,0,0))
  .setCaptionLabel("Gas")
  .setColorBackground(color(200, 255, 255))
  .setColorLabel(color(50, 100, 100))
  .getCaptionLabel()
  .toUpperCase(false)
  ;
  
  cp5.addTextfield("distance")
  .setPosition(50,475)
  .setSize(80,30)
  .setFont(font)
  .setFocus(false)
  .setAutoClear(false)
  .setColor(color(0,0,0))
  .setCaptionLabel("Distance")
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
    text(gas, 400, 325);
  }
  if(ultrasoundSensor == true) {
    text(dist, 400, 500);
    
    if (dist >= distLimit && distLimit > 0) {
      fill(255, 0, 0);
      circle(450, 550, 50);
    }
    
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
    if(serialCount > 6) {
       temp = serialArray[0];
       hum = serialArray[1];
       gas = serialArray[2]*256 + serialArray[3];
       dist = serialArray[4]*256 + serialArray[5] + serialArray[6]/100.0;
       port.write('A');
       serialCount = 0;
    }
  }
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    if (theEvent.getName() == "distance") {
      distLimit = float(theEvent.getStringValue());
    }
  }
}
