//Pong 1, 2 joueur(s) avec menu
// https://www.openprocessing.org/sketch/658932

//Déclaration des variables
float deplacementX, deplacementY;
float x, y;
int w, z;
int b, a;
int u=0;
int d=0;
int dx=0, dy=0;
int s=0;
int i=0;
int endgame=0;
float v=0;

//Définition des variables et mise en place du fond
void setup()
{
  size(400,400);
  background(0);
  x = 200;
  y = 200;
  deplacementX = 6;
  deplacementY = -3;
  w = 15;
  z = 60;
  b = 360;
  a = 100;
  u=0;
  v=0;
  d=0;
  s=0;
}

//Les différentes possibilité d'affichage
void draw()
{
  if(u==0 && endgame==0)
  {
  menu();
  lancement();
  }
  if(u==1 && endgame==0)
  {
  nettoyer();
  bouger1();
  dessiner1();
  rebondir1();
  point();
  game1();
  }
  if(u==2 && endgame==0)
  {
  nettoyer();
  bouger2();
  dessiner2();
  rebondir2();
  game2();
  }
  if(d==1)
  {
    //Projet de Bricks non réalisé
  }
  if (endgame==1)
  {
  keyboardR();
  }
}

//Affichage du menu
void menu()
{
  fill(255,255,255);
  rect(120,100,180,100);
  fill(0,0,0);
  textSize(20);
  text("One player",160,150);
  textSize(16);
  text("Press O",180,170);
  fill(255,255,255);
  rect(120,200,180,100);
  fill(0,0,0);
  textSize(20);
  text("Two players",160,250);
  textSize(16);
  text("Press T",180,270);
  if (s==1)
  {
  fill(255,255,255);
  rect(120,300,180,100);
  fill(0,0,0);
  textSize(20);
  text("Bricks",180,360);
  }
}

//Touches ayant des fonctions
void lancement()
{
  dx=(mouseX);
  dy=(mouseY);
  if(key=='o')//Pour jouer au Pong 1 joueur
  {
    u=1;
  }
  if(key=='t')//Pour jouer au Pong 2 joueurs
  {
    u=2;
  }
  if(key=='r')//Pour recommencer
  {
    if(endgame==1)
    {
    endgame=0;
    restart();
    }
  }
  if(key=='p')//Pour afficher la possibilité de jouer au Brics
  {
    s=1;
  }
  if(key=='b')//Pour jouer au Brics
  {
    d=1;
  }
}

//Pour recommencer
void restart()
{
  u=0;
  endgame=0;
  setup();
}

//Pour revenir au menu
void keyboardR()
{
  if (key == 'r'){
    restart();
  }
}

//Pour que l'écran redevienne noir
void nettoyer()
{
  background(0);
}

//PONG 1 JOUEUR

//Création du rectangle (raquette) et de l'ellipse (balle)
void dessiner1()
{
  if (endgame==0)
  {
  fill(255,255,255);
  smooth();
  stroke(255);
  line(200,0,200,400);
  ellipse(x,y,20,20);
  rect(w,z,25,85);
  }
}

//Déplacements du rectangle (raquette) et de l'ellipse (balle)
void bouger1()
{
  x=x+deplacementX;
  y=y+deplacementY;
  z=(mouseY);
}

//Rebondissements de l'ellipse (balle) sur les parois et le rectangle (raquette)
void rebondir1()
{
if (x > width-10 && deplacementX > 0){
  deplacementX = -deplacementX;
}
if (y > width-10 && deplacementY > 0){
  deplacementY = -deplacementY;
}
if (y < 10 && deplacementY < 0){
  deplacementY = abs(deplacementY);
}
if (x < w+35 && y > z && y < z+85){
  deplacementX = -(deplacementX-v);
}
}

//Comptage des points et accélération
void point()
{
if (x < w+35 && y > z && y < z+85){ 
    i++;
    v = v + 0.75;
  }
}

//Affichage après avoir perdu au Pong 1 joueur
void game1()
{
  if (x < 10 && deplacementX < 0){
    smooth();
    nettoyer();
    textSize(28);
    fill(255,255,255);
    text("Game Over",120,150);
    textSize(16);
    text("Your number of points is "+i,100,200);
    text("To restart, press R",125,250);
    endgame=1;
    u=0;
  }
}

//PONG 2 JOUEURS

//Création des deux rectangles (raquettes) et de l'ellipse (balle)
void dessiner2()
{
  fill(255,255,255);
  smooth();
  stroke(255);
  line(200,0,200,400);
  ellipse(x,y,20,20);
  rect(w,z,25,85);
  rect(b,a,25,85);
}

//Déplacements de l'ellipse (balle) et du rectangle de gauche (raquette de gauche)
void bouger2()
{
  x=x+deplacementX;
  y=y+deplacementY;
  z=(mouseY);
}

//Déplacement du rectangle de droite (raquette de droite) avec le clavier
void keyPressed()
{
  if (keyCode==UP)
  {
    a=a-40;
  }
  if (keyCode==DOWN)
  {
    a=a+40;
  }
}

//Rebondissements de l'ellipse (balle) sur les parois et les rectangles (raquettes)
void rebondir2()
{
if (y > width-10 && deplacementY > 0){
  deplacementY = -deplacementY;
}
if (y < 10 && deplacementY < 0){
  deplacementY = abs(deplacementY);
}
if (x < w+35 && y > z && y < z+85){
  deplacementX = -deplacementX;
}
if (x > b && y > a && y < a+85){
  deplacementX = -deplacementX;
}
}

//Affichage après avoir perdu au Pong 2 joueurs
void game2()
{
  if (x < 10 && deplacementX < 0){
    smooth();
    nettoyer();
    textSize(28);
    text("Game Over",120,150);
    textSize(16);
    text("The winner is the one using the keyboard",45,200);
    text("To restart, press R",125,250);
    endgame=1;
  }
  if (x > 400 && deplacementX > 0){
    smooth();
    nettoyer();
    textSize(28);
    text("Game Over",120,150);
    textSize(16);
    text("The winner is the one using the mouse",55,200);
    text("To restart, press R",125,250);
    endgame=1;
  }
}