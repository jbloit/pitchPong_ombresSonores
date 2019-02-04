// https://www.openprocessing.org/sketch/418048/
// credit: Samabibou

import oscP5.*;
import netP5.*;

OscP5 oscP5;

Pad padLeft, padRight;
Balle balle1;
float padSpeed;

void setup() {
  size(1200, 800);
  rectMode(CENTER);
  frameRate(30);

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);
  oscP5.plug(this, "audioLoudness", "/audio/loudness");
  oscP5.plug(this, "audioPitch", "/audio/pitch");

  padLeft = new Pad(30, 20, height/5);
  padRight = new Pad(width-30, 20, height/5);
  balle1 = new Balle(1);
  padSpeed = 20;
}

void draw() {
  background(0);
  stroke(255);
  line(0, 0, width-1, 0);   
  line(width-2, 0, width-2, height-2);
  line(width-2, height-2, 0, height-2);   
  line(0, 0, 0, height-2);
  line(width/2, 0, width/2, height);
  padLeft.update();  
  padRight.update(); 
  balle1.update();
  padLeft.display();  
  padRight.display(); 
  balle1.display();
}

void keyPressed() {
  int k = keyCode;
  if      (k == 'A')    padLeft.padSpeed = -padSpeed; 
  else if (k == 'Q')    padLeft.padSpeed =  padSpeed;
  else if (k == UP )    padRight.padSpeed = -padSpeed;
  else if (k == DOWN )    padRight.padSpeed = padSpeed;
}

void keyReleased() {
  int k = keyCode;
  if ( k == 'A'  &&  padLeft.padSpeed < 0  || k == 'Q'  &&  padLeft.padSpeed > 0 )
    padLeft.padSpeed = 0;
  else if ( k == UP &&  padRight.padSpeed < 0  || k == DOWN    &&  padRight.padSpeed > 0 )
    padRight.padSpeed = 0;
}


// OSC callbacks
public void audioLoudness(float loudness_cpadHeightn0, float loudness_cpadHeightn1) {
  // unused yet
}

public void audioPitch(float pitch_cpadHeightn0, float pitch_cpadHeightn1) {
  padLeft.y = (1.0 - pitch_cpadHeightn0) * height;

  println("OSC IN " + pitch_cpadHeightn0);

  // uncomment to activate mic on input 2
  // padRight.y = (1.0 - pitch_cpadHeightn1) * height;
}