class Balle {
  float x, y, xSpeed, ySpeed, radius, initSpeed, fpsYspeed, fpsXspeed;

  Balle(int player) {
    initSpeed = 5;
    x = width/2 ;
    y = height/2;
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
    if (x < (3 * radius)) {
      if (y>padLeft.y-(padLeft.padHeight)/2 && y<padLeft.y+(padLeft.padHeight)/2) {
        x= 30 + radius;
        xSpeed = - xSpeed;
        if (y>padLeft.y-(padLeft.padHeight)/2 && y<padLeft.y-(padLeft.padHeight)/4) ySpeed = ySpeed -2;
        if (y>padLeft.y+(padLeft.padHeight)/4 && y<padLeft.y+(padLeft.padHeight)/2) ySpeed = ySpeed +2;
        if (y>padLeft.y-(padLeft.padHeight)/4 && y<padLeft.y+(padLeft.padHeight)/4) ySpeed = ySpeed / 1.5;
      } else balle1 = new Balle(2);
    }

    if (x > width - 3*radius) {
      if (y>padRight.y-(padRight.padHeight)/2 && y<padRight.y+(padRight.padHeight)/2) {
        x = width - 3*radius;
        xSpeed = - xSpeed;
        if (y>padRight.y-(padRight.padHeight)/2 && y<padRight.y-(padRight.padHeight)/4) ySpeed = ySpeed -2;
        if (y>padRight.y+(padRight.padHeight)/4 && y<padRight.y+(padRight.padHeight)/2) ySpeed = ySpeed +2;
        if (y>padRight.y-(padRight.padHeight)/4 && y<padRight.y+(padRight.padHeight)/4) ySpeed = ySpeed / 1.5;
      } else balle1 = new Balle(1);
    }

    if (y<radius) {
      y = radius;
      ySpeed = - ySpeed;
    }
    if (y>height-radius) {
      y=height-radius;
      ySpeed = - ySpeed;
    }
  }
}
