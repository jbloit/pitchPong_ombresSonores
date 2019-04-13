// https://www.openprocessing.org/sketch/418048/
// credit: Samabibou

import oscP5.*;
import netP5.*;

OscP5 oscP5;

Pad padLeft, padRight;
Balle balle1;
float initPadSpeed;

void setup() {
  size(800, 600, P2D);
//  fullScreen();
  rectMode(CENTER);
  frameRate(30);

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);
  
  oscP5.plug(this, "audioDescriptorsChan0", "/audio/chan_0");
  oscP5.plug(this, "audioDescriptorsChan1", "/audio/chan_1");

  padLeft = new Pad(30, 20, height/5);
  padRight = new Pad(width-30, 20, height/5);
  balle1 = new Balle(1);
  initPadSpeed = 20;
}


void update(){
  padLeft.update();  
  padRight.update(); 
  balle1.update();

}
void draw() {
  background(0);
  stroke(255);
  line(0, 0, width-1, 0);   
  line(width-2, 0, width-2, height-2);
  line(width-2, height-2, 0, height-2);   
  line(0, 0, 0, height-2);//
  //update();
  thread("update");
  padLeft.display();  
  padRight.display(); 
  balle1.display();
  
  
  textSize(30);
  fill(255);
  text("FPS " + frameRate, 30, 30);
  
  
}
  
void keyPressed() {
  int k = keyCode;
  if      (k == 'A')    padLeft.padSpeed = -initPadSpeed; 
  else if (k == 'Q')    padLeft.padSpeed =  initPadSpeed;
  else if (k == UP )    padRight.padSpeed = -initPadSpeed;
  else if (k == DOWN )    padRight.padSpeed = initPadSpeed;
}

void keyReleased() {
  int k = keyCode;
  if ( k == 'A'  &&  padLeft.padSpeed < 0  || k == 'Q'  &&  padLeft.padSpeed > 0 )
    padLeft.padSpeed = 0;
  else if ( k == UP &&  padRight.padSpeed < 0  || k == DOWN    &&  padRight.padSpeed > 0 )
    padRight.padSpeed = 0;
}


// OSC callbacks

public void audioDescriptorsChan0(float pitchVal, float ampVal, float voicedVal){
      
        padLeft.y = (1.0 - pitchVal) * height;
}

public void audioDescriptorsChan1(float pitchVal, float ampVal, float voicedVal){
      
        padRight.y = (1.0 - pitchVal) * height;
}
