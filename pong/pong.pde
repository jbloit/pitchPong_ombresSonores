/*
The root App containing the Pitch-Pong game and the Audio-Shadows game.
 This allows switching from one game to another within the same App.
 */


import oscP5.*;
import netP5.*;

Scene pong;

// AUTO SWITCHING GAMES
enum GAME {
  SHADOWS, PONG
};
GAME currentGame = GAME.PONG  ;

// OSC
OscP5 oscP5;

// PONG globals
Pad padLeft, padRight;
Balle balle1;
float initPadSpeed;
int FPS = 60;

void setup() {
 size(800, 600, P2D);
// fullScreen(P2D);

  frameRate(FPS);  
  background(100);
  pong = new Scene(this);

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);

  oscP5.plug(this, "audioDescriptorsChan0", "/audio/chan_0");
  oscP5.plug(this, "audioDescriptorsChan1", "/audio/chan_1");
}

void draw() {
//   updateGameTimer();

  clear();
  if (currentGame == GAME.PONG) {
    pong.draw();
  }

  // fps
  fill(0, 255, 0);
  text("FPS: " + frameRate, 20, 20);
}



////////////////////////////////////////////////////
// OSC callbacks (audio descriptors)
// first channel is used for controlling the loudness shadow
// second channel is used for controlling the timbral shadow (voiced) 
public void audioDescriptorsChan0(float pitchVal, float ampVal, float voicedVal) {
  pong.setPitch(0, pitchVal);
}
public void audioDescriptorsChan1(float pitchVal, float ampVal, float voicedVal) {
  pong.setPitch(1, pitchVal);
}
