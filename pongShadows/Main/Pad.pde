class Pad {

  float x, y, padWidth, padHeight, padSpeed;

  Pad(float abscisse, float _width, float _height) {
    y = height/2;
    x = abscisse;
    padWidth = _width;
    padHeight = _height;
    padSpeed = 0;
  }

  void update() {
    y += padSpeed;
    if (y < padHeight/2) y = padHeight/2;
    if (y>height-padHeight/2) y=height-padHeight/2;
  }

  void display() {
    fill(255);
    rect(x, y, padWidth, padHeight);
  }
}
