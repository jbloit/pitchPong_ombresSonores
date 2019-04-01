import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;

class Shadows {

  PApplet parent;
  Kinect kinect;
  ArrayList <SkeletonData> bodies;
  PImage img;
  int kinectWidth = 640;
  int kinectHeight = 480;
  color c ;
  color white = color(255);
  color black = color (0);

  // origin for silhouette and skeleton image
  PVector kinectImgOffset = new PVector(50, 50);

  // For loudness shadow  
  int slices = 20;
  float pie_slice = TWO_PI/slices;
  float x, y, szX, szY, theta;

  public Shadows(PApplet _parent) {
    parent = _parent;
    kinect = new Kinect(parent);
    bodies = new ArrayList<SkeletonData>();
  }

  public void draw() {
    clear();
    background(255);


    // draw silhouette
    img = kinect.GetMask();
    img.loadPixels();

/*
    for (int x = 0; x < kinectWidth; x++) {
      for (int y = 0; y < kinectHeight; y++) {
        int index = x + y * kinectWidth;
        c = color(img.pixels[index]);
        float a = alpha(c);

        if (a>0) {
          img.pixels[index] = black;
        } else {
          img.pixels[index] = white;
        }
      }
    }

*/
    img.updatePixels();
    image(img, kinectImgOffset.x, kinectImgOffset.y);
  }
}
