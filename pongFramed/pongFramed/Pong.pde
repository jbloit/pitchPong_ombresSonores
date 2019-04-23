

class Pong {
  PApplet parent;
  boolean isSceneEmpty = true;

//    rect(240, 100, 600,600);

  PVector frameOrigin = new PVector(260,0);
  float frameW = width - (2 * 260);
  float frameH = 600;
  
  public Pong(PApplet _parent) {
    parent = _parent;

    padLeft = new Pad(30 + frameOrigin.x, 20, frameH/2, frameOrigin, frameW, frameH);
    padRight = new Pad(frameW-30 + frameOrigin.x, 20, frameH/2, frameOrigin, frameW, frameH);
    balle1 = new Balle(1, frameOrigin, frameW, frameH);

  }

  public void setPitch(int chan, float value) {
    if (chan == 0) {
      padLeft.y = (1.0 - value) * frameH;
    } else {
      padRight.y = (1.0 - value) * frameH;
    }
  }

  public void draw() {
    clear();
    rectMode(CENTER);

    background(0);
    stroke(255);
    line(frameOrigin.x, frameOrigin.y, frameOrigin.x + frameW-1, frameOrigin.y);   
    line(frameOrigin.x+frameW-2, frameOrigin.y, frameOrigin.x+frameW-2, frameOrigin.y + frameH-2);
 
    line(frameOrigin.x, frameOrigin.y + frameH-2, frameOrigin.x+frameW-2, frameOrigin.y + frameH-2);   
    
    line(frameOrigin.x, frameOrigin.y, frameOrigin.x, frameH-2);
   
    line(frameOrigin.x + frameW/2, frameOrigin.y, frameOrigin.x + frameW/2, frameOrigin.y + frameH);

    padLeft.update();  
    padRight.update(); 
    balle1.update();
    padLeft.display();  
    padRight.display(); 
    balle1.display();


  }
  
    
public void keyPressed(int k) {

  if      (k == 'A')    padLeft.padSpeed = -initPadSpeed; 
  else if (k == 'Q')    padLeft.padSpeed =  initPadSpeed;
  else if (k == UP )    padRight.padSpeed = -initPadSpeed;
  else if (k == DOWN )    padRight.padSpeed = initPadSpeed;
}

public void keyReleased(int k) {

  if ( k == 'A'  &&  padLeft.padSpeed < 0  || k == 'Q'  &&  padLeft.padSpeed > 0 )
    padLeft.padSpeed = 0;
  else if ( k == UP &&  padRight.padSpeed < 0  || k == DOWN    &&  padRight.padSpeed > 0 )
    padRight.padSpeed = 0;
}
  
}
