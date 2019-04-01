

Pong pong;
Shadows shadows;

int now = millis();
int then = millis();
int switchGamePeriodMs = 3000;
enum GAME {
  PONG, SHADOWS
};
GAME currentGame = GAME.PONG;



void setup() {
  
 // size(400, 400);
  
  fullScreen();
  frameRate(30);  
  background(255);
  pong = new Pong(this);
  shadows = new Shadows(this);
}

void draw() {
  updateGameTimer();
  
  clear();
  if (currentGame == GAME.PONG){
    pong.draw();
  } else {
    shadows.draw();
  }
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
