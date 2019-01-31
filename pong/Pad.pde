class Pad {
  
   float x,y,ep, ha,vitesse;
       
    Pad(float abscisse, float epaisseur, float hauteur){
      y = height/2;
      x = abscisse;
      ep = epaisseur;
      ha = hauteur;
      vitesse = 0;
    }
    
    void deplace() {
      y += vitesse;
    if (y<ha/2) y=ha/2;
  if (y>height-ha/2) y=height-ha/2; }
      
    void affiche(){
      fill(255);
      rect(x,y,ep,ha);
    }
  }