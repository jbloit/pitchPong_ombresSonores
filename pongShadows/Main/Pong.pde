

class Pong {

  PApplet parent;


  boolean isSceneEmpty = true;

  public Pong(PApplet _parent) {
    parent = _parent;



  }
  public void draw() {
    clear();

        ellipse(width/2, height/2, 40, 40);
 
  }
}
