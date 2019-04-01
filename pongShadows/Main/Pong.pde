

class Pong {
  PApplet parent;
  boolean isSceneEmpty = true;

  public Pong(PApplet _parent) {
    parent = _parent;

    padLeft = new Pad(30, 20, height/5);
    padRight = new Pad(width-30, 20, height/5);
    balle1 = new Balle(1);
    initPadSpeed = 20;
  }

  public void setPitch(int chan, float value) {
    if (chan == 0) {
      padLeft.y = (1.0 - value) * height;
    } else {
      padRight.y = (1.0 - value) * height;
    }
  }

  public void draw() {
    clear();
    rectMode(CENTER);


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
}
