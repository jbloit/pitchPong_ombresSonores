class Balle {
  float x, y, xSpeed, ySpeed, radius, initSpeed, fpsYspeed, fpsXspeed, frameW, frameH;

  PVector frameOrigin = new PVector(0, 0);


  Balle(int player, PVector _frameOrigin, float _frameW, float _frameH) {
    frameOrigin = _frameOrigin;
    frameW = _frameW;
    frameH = _frameH;
    
    initSpeed = 5;
    x = frameOrigin.x + frameW/2 ;
    y = frameOrigin.y + frameH/2;
    if (player==1) xSpeed = initSpeed;
    else xSpeed = -initSpeed;
    ySpeed = random(-initSpeed, initSpeed);
    radius = 15;
  }

  void display() {
    fill(#FFFFFF);
    rect(x, y, radius, radius);
  }

  void update() {
    fpsXspeed = FPS / frameRate * xSpeed;
    fpsYspeed = FPS / frameRate * ySpeed;
    x = x + fpsXspeed;
    y = y + fpsYspeed;
    
    // ball reaches left side
    if (x < (3 * radius + frameOrigin.x)) {
      // if it is cqught, bounce
      if (y > padLeft.y - (padLeft.padHeight)/2 && y<padLeft.y+(padLeft.padHeight)/2) { //<>//
        x= 30 + radius;
        xSpeed = - xSpeed;
        
        /*
        if (y > padLeft.y - (padLeft.padHeight) / 2 && y < padLeft.y - (padLeft.padHeight)/4) ySpeed = ySpeed - 2;
        if (y>padLeft.y+(padLeft.padHeight)/4 && y<padLeft.y+(padLeft.padHeight)/2) ySpeed = ySpeed + 2;
        if (y>padLeft.y-(padLeft.padHeight)/4 && y<padLeft.y+(padLeft.padHeight)/4) ySpeed = ySpeed / 1.5;
        */
      } else balle1 = new Balle(2,  frameOrigin, frameW, frameH);
    }

    // ball goes out on right side
    if (x >  frameOrigin.x + frameW - 3*radius) {
      if (y>padRight.y-(padRight.padHeight)/2 && y<padRight.y+(padRight.padHeight)/2) {
        x = frameW - 3*radius;
        xSpeed = - xSpeed;
        if (y>padRight.y-(padRight.padHeight)/2 && y<padRight.y-(padRight.padHeight)/4) ySpeed = ySpeed -2;
        if (y>padRight.y+(padRight.padHeight)/4 && y<padRight.y+(padRight.padHeight)/2) ySpeed = ySpeed +2;
        if (y>padRight.y-(padRight.padHeight)/4 && y<padRight.y+(padRight.padHeight)/4) ySpeed = ySpeed / 1.5;
      } else balle1 = new Balle(1,  frameOrigin, frameW, frameH);
    }

    if (y < radius) {
      y = radius;
      ySpeed = - ySpeed;
    }
    if (y > frameH - radius) {
      y = frameH - radius;
      ySpeed = - ySpeed;
    }
  }
}
