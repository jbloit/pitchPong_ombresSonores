class Pad {

  PVector frameOrigin = new PVector(0, 0);
  float x, y, padWidth, padHeight, padSpeed, frameW, frameH;

  Pad(float abscisse, float _width, float _height, PVector _frameOrigin, float _frameW, float _frameH) {
    frameW = _frameW;
    frameH = _frameH;
    frameOrigin = _frameOrigin;
    y = frameH / 2;
    x = abscisse;
    padWidth = _width;
    padHeight = _height;
  }

  void update() {
    if (y < padHeight/2) y = padHeight/2;
    if (y>frameH-padHeight/2) y=frameH-padHeight/2;
  }

  void display() {
    fill(255);
    rect(x, y, padWidth, padHeight);
  }
}
