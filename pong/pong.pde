// https://www.openprocessing.org/sketch/418048/
// credit: Samabibou

import oscP5.*;
import netP5.*;

OscP5 oscP5;

Pad raquette1,raquette2;
Balle balle1;
float vitraq;

void setup(){
  size(1200,800);
  rectMode(CENTER);
   
   /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  oscP5.plug(this,"audioLoudness","/audio/loudness");
  oscP5.plug(this,"audioPitch","/audio/pitch");
  
  raquette1 = new Pad(30,20,100);
  raquette2 = new Pad(width-30,20,100);
  balle1 = new Balle(1);
  vitraq = 5;
}

void draw(){
  background(0);
  stroke(255);
  line(0,0,width-1,0);   line(width-2,0,width-2,height-2);
  line(width-2,height-2,0,height-2);   line(0,0,0,height-2);
  line(width/2,0,width/2,height);
  raquette1.deplace();  raquette2.deplace(); balle1.deplace();
  raquette1.affiche();  raquette2.affiche(); balle1.affiche();
}

void keyPressed() {
  int k = keyCode;
  if      (k == 'A')    raquette1.vitesse = -vitraq; 
  else if (k == 'Q')    raquette1.vitesse =  vitraq;
  else if (k == UP )    raquette2.vitesse = -vitraq;
  else if (k == DOWN )    raquette2.vitesse = vitraq;
   }
 
void keyReleased() {
  int k = keyCode;
  if ( k == 'A'  &&  raquette1.vitesse < 0  || k == 'Q'  &&  raquette1.vitesse > 0 )
    raquette1.vitesse = 0;
  else if ( k == UP &&  raquette2.vitesse < 0  || k == DOWN    &&  raquette2.vitesse > 0 )
    raquette2.vitesse = 0;
}


// OSC callbacks
public void audioLoudness(float loudness_chan0, float loudness_chan1) {
// unused yet
}

public void audioPitch(float pitch_chan0, float pitch_chan1) {
  raquette1.y = (1.0 - pitch_chan0) * height;
  
  println("OSC IN " + pitch_chan0);
  
  // uncomment to activate mic on input 2
  // raquette2.y = (1.0 - pitch_chan1) * height;
}