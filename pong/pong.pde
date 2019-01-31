// https://www.openprocessing.org/sketch/418048/
// credit: Samabibou

Pad raquette1,raquette2;
Balle balle1;
float vitraq;

void setup(){
  size(1200,800);
  rectMode(CENTER);
  raquette1 = new Pad(30,20,100);
  raquette2 = new Pad(width-30,20,100);
  balle1 = new Balle(1);
  vitraq = 5;
}

void draw(){
  background(0);
  stroke(255);
  line(0,0,width-1,0);   line(width-2,0,width-2,height-2);
  line(width-2,height-2,0,height-2);   line(0,0,0,height-2);
  line(width/2,0,width/2,height);
  raquette1.deplace();  raquette2.deplace(); balle1.deplace();
  raquette1.affiche();  raquette2.affiche(); balle1.affiche();
}

void keyPressed() {
  int k = keyCode;
  if      (k == 'A')    raquette1.vitesse = -vitraq; 
  else if (k == 'Q')    raquette1.vitesse =  vitraq;
  else if (k == UP )    raquette2.vitesse = -vitraq;
  else if (k == DOWN )    raquette2.vitesse = vitraq;
   }
 
void keyReleased() {
  int k = keyCode;
  if ( k == 'A'  &&  raquette1.vitesse < 0  || k == 'Q'  &&  raquette1.vitesse > 0 )
    raquette1.vitesse = 0;
  else if ( k == UP &&  raquette2.vitesse < 0  || k == DOWN    &&  raquette2.vitesse > 0 )
    raquette2.vitesse = 0;
}