/*
The root App containing the Pitch-Pong game and the Audio-Shadows game.
 This allows switching from one game to another within the same App.
 */


import oscP5.*;
import netP5.*;

Pong pong;
Shadows shadows;

// AUTO SWITCHING GAMES
int now = millis();
int then = millis();
int switchGamePeriodMs = 10000;
enum GAME {
  PONG, SHADOWS
};
GAME currentGame = GAME.PONG;

// OSC
OscP5 oscP5;

// PONG globals
Pad padLeft, padRight;
Balle balle1;
float initPadSpeed;
int FPS = 30;

void setup() {

  size(800, 600);
  //fullScreen();

  frameRate(FPS);  
  background(255);
  pong = new Pong(this);
  shadows = new Shadows(this);

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);

  oscP5.plug(this, "audioDescriptorsChan0", "/audio/chan_0");
  oscP5.plug(this, "audioDescriptorsChan1", "/audio/chan_1");
}

void draw() {
  //updateGameTimer();

  clear();
  if (currentGame == GAME.PONG) {
    pong.draw();
  } else {
    shadows.draw();
  }

  // fps
  fill(0, 255, 0);
//  text("FPS: " + frameRate, 20, 20);
}


// Change game after some given time
void updateGameTimer() {
  now = millis();
  if ((now - then) > switchGamePeriodMs) {
    if (currentGame == GAME.PONG) {
      currentGame = GAME.SHADOWS;
      println("SWITCH GAME TO SHADOWS");
    } else {
      currentGame = GAME.PONG;
      println("SWITCH GAME TO PONG");
    }
    then = now;
  }
}

// OSC callbacks
public void audioDescriptorsChan0(float pitchVal, float ampVal, float voicedVal) {
  pong.setPitch(0, pitchVal);
}
public void audioDescriptorsChan1(float pitchVal, float ampVal, float voicedVal) {
  pong.setPitch(1, pitchVal);
}
