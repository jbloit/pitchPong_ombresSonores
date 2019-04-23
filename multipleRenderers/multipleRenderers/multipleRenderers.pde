import java.awt.*;
import javax.swing.JFrame;
public PImage a;
public int mmx;
public int mmy;
public JFrame new_window;
MApplet sketchviewer;
public int frameWidth =0;//10
public int frameHeight =0; //25
public String rmode = "P3D";


int w;
int h;

void setup(){
//  size(300,300);
  w=255;
  h=255;
  a=createImage(w,h,ARGB);
  size(w,h,P3D);

  background(233,23,23);
}



void keyPressed(){
  if(key=='n')   loadNewWindow();
  if (key=='r')setup();

  if (key=='1') {
    rmode  = "P3D";
    loadNewWindow();
  }
  if (key=='2') {
    rmode  = "P2D";
    loadNewWindow();
  }
  if (key=='3') {
    rmode  = "JAVA2D";
    loadNewWindow();
  }

}

void draw(){
  if (pmouseX!=mouseX && pmouseY!=mouseY)
  { 
    this.frame.setTitle(str(mouseX)+ " - " + str(mouseY));
  }
  else
  {
    this.frame.setTitle(str(mmx)+ " - " + str(mmy));
  }
  if (a!=null)background(a);
  mmx= mouseX;
  mmy=mouseY;
  ellipse(mouseX,mouseY,20,20);
}


void loadNewWindow()
{

  // if(new_window == null){ // omitting this allows multiple windows
  new_window = new JFrame();

  sketchviewer = new MApplet();

//  new_window.getContentPane().add(sketchviewer, BorderLayout.CENTER);



  new_window.setVisible(true);

//  sketchviewer.init();
  //  }


  new_window.setSize(w + frameWidth, h + frameHeight);


}

public class MApplet extends PApplet{
  public PApplet pgx;

  //<Insert sketch Code here>
  // Shining Particle by harukit
  // Created with Processing 68 alpha on September 11 , 2004
  // http://www.harukit.com 


  int pNum =4;
  Particle[] p = new Particle[pNum];
  float rr,gg,bb,dis;
  int gain = 5;
  float[] cc = new float[3];

  public void setup(){
    if (rmode=="P3D") size(w,h,P3D);
    if (rmode=="P2D") size(w,h,P2D);
    if (rmode=="JAVA2D")size(w,h,JAVA2D);
    loadPixels();
    noStroke();
    background(0);
    for(int i=0;i<3;i++){
      cc[i]=random(40)+random(40)+random(40)+random(40)+random(40);
    }
    for(int i=0;i<pNum;i++){
      p[i] = new Particle(random(width),random(height),random(0.1,0.3));
    }
  }

  public void draw(){

    mouseX=mmx;
    mouseY=mmy;
    //  for(int i=0;i<pNum;i++){
    //    p[i].update();
    //  }
    for(int y=0;y<height;y++){
      for(int x=0;x<width;x++){
        int pos=y*width+x;
        color col = pixels[pos];
        rr = col >> 16 & 0xff;
        gg = col >> 8 & 0xff;
        bb = col  & 0xff;
        // for(int i=0;i<pNum;i++){
        // dis =dist(p[i].xpos,p[i].ypos,x,y)/2;
        dis = dist(mouseX,mouseY,x,y)/2;
        rr += cc[0]/dis-gain;
        gg += cc[1]/dis-gain;
        bb += cc[2]/dis-gain;
        //  }
        pixels[pos]=color(rr,gg,bb);
        a.pixels[pos]=color(rr,gg,bb);
      }
    }
    if (rmode=="JAVA2D"){
      updatePixels(); 
    }
  }

  public void mousePressed(){
    //  background(0);
    Particle[] p = new Particle[pNum];
  }

  public void mouseReleased(){
    for(int i=0;i<3;i++){
      cc[i]=random(40)+random(40)+random(40)+random(40)+random(40);
    }
    // background(0);
    for(int i=0;i<pNum;i++){
      p[i] = new Particle(random(width),random(height),random(0.1,0.3));
    }
  }

  class Particle{
    float xpos,ypos,del;
    Particle(float x,float y,float d){
      xpos=x;
      ypos=y;
      del = d;
    }
    void update(){
      xpos += (mouseX-xpos)*del;
      ypos += (mouseY-ypos)*del;
    }
  }

}
