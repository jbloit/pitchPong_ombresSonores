/*
The root App containing the Pitch-Pong game and the Audio-Shadows game.
 This allows switching from one game to another within the same App.
 */


import oscP5.*;
import netP5.*;

Pong pong;
// UNCOMMENT
//Shadows shadows;

// AUTO SWITCHING GAMES
int now = millis();
int then = millis();
int switchGamePeriodMs = 120000;
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
int FPS = 30;

void setup() {

  size(800, 600);
//  fullScreen();

  frameRate(FPS);  
  background(100);
  pong = new Pong(this);
  
  // UNCOMMENT
  // shadows = new Shadows(this);

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
  } else {
    // UNCOMMENT
//    shadows.draw();
  }

  // fps
  fill(0, 255, 0);
  text("FPS: " + frameRate, 20, 20);
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


  
void keyPressed() {
    int k = keyCode;
  pong.keyPressed(k);
}

void keyReleased() {
    int k = keyCode;
  pong.keyReleased(k);
}




// UNCOMMENT
/*


////////////////////////////////////////////////////
// OSC callbacks (audio descriptors)
// first channel is used for controlling the loudness shadow
// second channel is used for controlling the timbral shadow (voiced) 
public void audioDescriptorsChan0(float pitchVal, float ampVal, float voicedVal) {
  pong.setPitch(0, pitchVal);
  shadows.setLoudness(ampVal);
}
public void audioDescriptorsChan1(float pitchVal, float ampVal, float voicedVal) {
  pong.setPitch(1, pitchVal);
  shadows.setVoiced(voicedVal, ampVal);
}



//////////// Kinect callbacks, need to be registered to a PApplet, not to a subclass like Shadows.
void appearEvent(SkeletonData _s) {
  shadows.appearEvent( _s);
}

void disappearEvent(SkeletonData _s) {
  shadows.disappearEvent( _s);
}

void moveEvent(SkeletonData _b, SkeletonData _a) {
  shadows.moveEvent( _b, _a);
}

*/
