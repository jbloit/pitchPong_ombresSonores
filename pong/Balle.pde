class Balle {
  float x,y,vitx,vity, rayon, initSpeed;
  
  Balle(int joueur){
    initSpeed = 10;
    x = width/2 ;
    y = height/2;
    if (joueur==1) vitx = initSpeed;
    else vitx = -initSpeed;
    vity = random(-initSpeed,initSpeed);
    rayon = 15;
  }
  
  void affiche(){
    fill(#FC0505);
    ellipse(x,y,rayon,rayon);
  }
  
  void deplace(){
    x = x + vitx;
    y = y + vity;
    if (x<30+rayon) {
      if (y>raquette1.y-(raquette1.ha)/2 && y<raquette1.y+(raquette1.ha)/2) {
        x=30+rayon;
        vitx = - vitx;
      if (y>raquette1.y-(raquette1.ha)/2 && y<raquette1.y-(raquette1.ha)/4) vity = vity -2;
      if (y>raquette1.y+(raquette1.ha)/4 && y<raquette1.y+(raquette1.ha)/2) vity = vity +2;
      if (y>raquette1.y-(raquette1.ha)/4 && y<raquette1.y+(raquette1.ha)/4) vity = vity / 1.5;  
      }
      else balle1 = new Balle(2);}
    
    if (x>width-30-rayon) {
      if (y>raquette2.y-(raquette2.ha)/2 && y<raquette2.y+(raquette2.ha)/2) {
        x=width-30-rayon;
        vitx = - vitx;
            if (y>raquette2.y-(raquette2.ha)/2 && y<raquette2.y-(raquette2.ha)/4) vity = vity -2;
      if (y>raquette2.y+(raquette2.ha)/4 && y<raquette2.y+(raquette2.ha)/2) vity = vity +2;
      if (y>raquette2.y-(raquette2.ha)/4 && y<raquette2.y+(raquette2.ha)/4) vity = vity / 1.5;  
      }
      else balle1 = new Balle(1);}
    
    if (y<rayon) {y = rayon;vity = - vity;}
    if (y>height-rayon) {y=height-rayon;vity = - vity;}
  }
  
}
