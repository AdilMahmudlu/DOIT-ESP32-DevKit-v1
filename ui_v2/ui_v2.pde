import controlP5.*;
import processing.serial.*;

Serial port;
int[] serialArray = new int[12];
int serialCount = 0;

ControlP5 cp5;
PFont font;

boolean tempSensor = false;
boolean gasSensor = false;
boolean ultrasoundSensor = false;
boolean dustSensor = false;
boolean magneticSensor = false;
boolean fireSensor = false;

boolean firstContact = false;

int temp;
int hum;
int gas;
float dist;
float dust;
int magnetic;
int fire;

int tempLimit = -1;
int humLimit = -1;
int gasLimit = -1;
float distLimit = -1;
float dustLimit = -1;

void setup() {
  size(800, 700);
  noSmooth();
  port = new Serial(this, "COM4", 9600);
  cp5 = new ControlP5(this);

  font = createFont("cambria math", 20);


  cp5.addToggle("tempSensor").setPosition(45, 65)
    .setSize(150, 120)
    .setFont(font)
    .setValue(false)
    .setCaptionLabel("Temperature \nand Humidity")
    .setColorLabel(color(0, 20, 20))
    .setColorBackground(color(0, 140, 140))
    .setColorForeground(color(30, 160, 160))
    .setColorActive(color(50, 180, 180))
    .getCaptionLabel()
    .toUpperCase(false)
    .setPaddingX(20)
    .setPaddingY(-80)
    ;

  cp5.addToggle("gasSensor").setPosition(45, 290)
    .setSize(150, 120)
    .setFont(font)
    .setValue(false)
    .setCaptionLabel("Gas")
    .setColorLabel(color(0, 20, 20))
    .setColorBackground(color(0, 140, 140))
    .setColorForeground(color(30, 160, 160))
    .setColorActive(color(50, 180, 180))
    .getCaptionLabel()
    .toUpperCase(false)
    .align(CENTER, CENTER)
    ;

  cp5.addToggle("magneticSensor").setPosition(45, 515)
    .setSize(150, 120)
    .setFont(font)
    .setValue(false)
    .setCaptionLabel("Magnetic")
    .setColorLabel(color(0, 20, 20))
    .setColorBackground(color(0, 140, 140))
    .setColorForeground(color(30, 160, 160))
    .setColorActive(color(50, 180, 180))
    .getCaptionLabel()
    .toUpperCase(false)
    .align(CENTER, CENTER)
    ;

  cp5.addToggle("ultrasoundSensor").setPosition(435, 65)
    .setSize(150, 120)
    .setFont(font)
    .setValue(false)
    .setCaptionLabel("Ultrasound\n Distance")
    .setColorLabel(color(0, 20, 20))
    .setColorBackground(color(0, 140, 140))
    .setColorForeground(color(30, 160, 160))
    .setColorActive(color(50, 180, 180))
    .getCaptionLabel()
    .toUpperCase(false)
    .setPaddingX(30)
    .setPaddingY(-80)
    ;

  cp5.addToggle("dustSensor").setPosition(435, 290)
    .setSize(150, 120)
    .setFont(font)
    .setValue(false)
    .setCaptionLabel("Dust")
    .setColorLabel(color(0, 20, 20))
    .setColorBackground(color(0, 140, 140))
    .setColorForeground(color(30, 160, 160))
    .setColorActive(color(50, 180, 180))
    .getCaptionLabel()
    .toUpperCase(false)
    .align(CENTER, CENTER)
    ;

  cp5.addToggle("fireSensor").setPosition(435, 515)
    .setSize(150, 120)
    .setFont(font)
    .setValue(false)
    .setCaptionLabel("Fire")
    .setColorLabel(color(0, 20, 20))
    .setColorBackground(color(0, 140, 140))
    .setColorForeground(color(30, 160, 160))
    .setColorActive(color(50, 180, 180))
    .getCaptionLabel()
    .toUpperCase(false)
    .align(CENTER, CENTER)
    ;

  cp5.addTextfield("temperatureTF")
    .setPosition(210, 85)
    .setSize(80, 30)
    .setFont(font)
    .setFocus(false)
    .setAutoClear(false)
    .setColor(color(0, 0, 0))
    .setCaptionLabel("")
    .setColorBackground(color(180, 200, 255))
    ;

  cp5.addTextfield("humidityTF")
    .setPosition(210, 160)
    .setSize(80, 30)
    .setFont(font)
    .setFocus(false)
    .setAutoClear(false)
    .setColor(color(0, 0, 0))
    .setCaptionLabel("")
    .setColorBackground(color(180, 200, 255))
    ;

  cp5.addTextfield("gasTF")
    .setPosition(210, 350)
    .setSize(80, 30)
    .setFont(font)
    .setFocus(false)
    .setAutoClear(false)
    .setColor(color(0, 0, 0))
    .setCaptionLabel("")
    .setColorBackground(color(180, 200, 255))
    ;

  cp5.addTextfield("distanceTF")
    .setPosition(600, 125)
    .setSize(80, 30)
    .setFont(font)
    .setFocus(false)
    .setAutoClear(false)
    .setColor(color(0, 0, 0))
    .setCaptionLabel("")
    .setColorBackground(color(180, 200, 255))
    ;
    
  cp5.addTextfield("dustTF")
    .setPosition(600, 350)
    .setSize(80, 30)
    .setFont(font)
    .setFocus(false)
    .setAutoClear(false)
    .setColor(color(0, 0, 0))
    .setCaptionLabel("")
    .setColorBackground(color(180, 200, 255))
    ;
}

void draw() {
  background(90, 120, 200);
  fill(180, 200, 255);
  stroke(180, 200, 255);
  rect(30, 25, 350, 200, 20);
  rect(30, 250, 350, 200, 20);
  rect(30, 475, 350, 200, 20);
  rect(420, 25, 350, 200, 20);
  rect(420, 250, 350, 200, 20);
  rect(420, 475, 350, 200, 20);
  
  fill(75, 0, 0);
  circle(335, 85, 40);
  circle(335, 160, 40);
  circle(335, 340, 40);
  circle(335, 575, 40);
  circle(725, 115, 40);
  circle(725, 340, 40);
  circle(725, 575, 40);
  
  textFont(font);
  
  if (tempSensor == true) {
    fill(0, 0, 0);
    text(temp, 210, 75);
    text(hum, 210, 150);
    
    if (temp >= tempLimit && tempLimit > 0) {
      fill(243, 32, 19);
      circle(335, 85, 40);
    }
    if (hum >= humLimit && humLimit > 0) {
      fill(243, 32, 19);
      circle(335, 160, 40);
    }
  }
  
  if (gasSensor == true) {
    fill(0, 0, 0);
    text(gas, 210, 330);
    
    if (gas >= gasLimit && gasLimit > 0) {
      fill(243, 32, 19);
      circle(335, 340, 40);
    }
  }
  
  if (ultrasoundSensor == true) {
    fill(0, 0, 0);
    text(dist, 600, 105);

    if (dist >= distLimit && distLimit > 0) {
      fill(243, 32, 19);
      circle(725, 115, 40);
    }
  }
  
  if (dustSensor == true) {
    fill(0, 0 , 0);
    text(dust, 600, 330);
    
    if (dust >= dustLimit && dustLimit > 0) {
      fill(243, 32, 19);
      circle(725, 340, 40);
    }
  }
  
  if (magneticSensor == true && magnetic == 1) {
    fill(243, 32, 19);
    circle(335, 575, 40);
  }
  
  if (fireSensor == true && fire == 1) {
    fill(243, 32,  19);
    circle(725, 575, 40);
  }
}

void serialEvent(Serial port) {
  int inByte = port.read();
  if (firstContact == false) {
    if (inByte == 'A') {
      port.clear();
      firstContact = true;
      port.write('A');
    }
  } else {
    serialArray[serialCount] = inByte;
    serialCount++;
    if (serialCount > 11) {
      temp = serialArray[0];
      hum = serialArray[1];
      gas = serialArray[2]*256 + serialArray[3];
      dist = serialArray[4]*256 + serialArray[5] + serialArray[6]/100.0;
      dust = serialArray[7]*256 + serialArray[8] + serialArray[9]/100.0;
      magnetic = serialArray[10];
      fire = serialArray[11];
      port.write('A');
      serialCount = 0;
    }
  }
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    if (theEvent.getName() == "temperatureTF") {
      tempLimit = int(theEvent.getStringValue());
    }
    if (theEvent.getName() == "humidityTF") {
      humLimit = int(theEvent.getStringValue());
    }
    if (theEvent.getName() == "gasTF") {
      gasLimit = int(theEvent.getStringValue());
    }
    if (theEvent.getName() == "distanceTF") {
      distLimit = float(theEvent.getStringValue());
    }
    if (theEvent.getName() == "dustTF") {
      dustLimit = float(theEvent.getStringValue());
    }
  }
}
