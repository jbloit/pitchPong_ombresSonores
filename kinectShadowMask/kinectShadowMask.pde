/*
This sketcth is tested only on windows 7, with a kinect xbox 360 (v1 - model 1414)
 
 Prior to pluging the kinect for the first time, install the window sdk version 1.8 from 
 https://www.microsoft.com/en-us/download/details.aspx?id=40278
 as well as the developer tools (link provided at the end of the installation process above).
 
 Then install the kinect4WinSDK processing library.
 
 see the library API here: 
 http://www.magicandlove.com/blog/research/kinect-for-processing-library/
 
 
 This example is meant to show only pixeles within a depth range.
 
 */

import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;

Kinect kinect;
ArrayList <SkeletonData> bodies;
PImage img;
int kinectWidth = 640;
int kinectHeight = 480;

// origin for silhouette and skeleton image
PVector kinectImgOffset = new PVector(50, 50);

// For loudness shadow  
int slices = 20;
float pie_slice = TWO_PI/slices;
float x, y, szX, szY, theta;

void setup()
{

  size(800, 600);
  //fullScreen();

  background(255);
  kinect = new Kinect(this);

  bodies = new ArrayList<SkeletonData>();
}

color c ;
color white = color(255);
color black = color (0);
void draw()
{
  clear();
  background(255);


  // draw silhouette
  img = kinect.GetMask();
  
  
  
  img.loadPixels();


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


  img.updatePixels();
  image(img, kinectImgOffset.x, kinectImgOffset.y);


  // draw head pointer
  for (int i=0; i<bodies.size (); i++) 
  {
    drawSkeleton(bodies.get(i));
  }

  // fps
  fill(0, 255, 0);
  text("FPS: " + frameRate, 20, 20);
}

void drawLoudnessShadow(float centerX, float centerY) {
  fill(0);

  y = map(sin(theta), -1, 1, -20, -150);
  //y = -30;
  szY = height/2+y ;
  szX = 200; 
  for (int i=0; i<slices; i++) {
    pushMatrix();
    translate(centerX, centerY);   
    rotate(i*pie_slice);
    arc(0, y, szX, szY, (PI*1.5)-(pie_slice/2), (PI*1.5)+(pie_slice/2));
    popMatrix();
  }   
  theta += 0.0523;
  //theta += 1.0;
}


void drawSkeleton(SkeletonData _s) 
{

  // Head
  DrawHead(_s, Kinect.NUI_SKELETON_POSITION_HEAD);

  /*
 // Body
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_HEAD, 
   Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
   Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
   Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
   Kinect.NUI_SKELETON_POSITION_SPINE);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, 
   Kinect.NUI_SKELETON_POSITION_SPINE);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, 
   Kinect.NUI_SKELETON_POSITION_SPINE);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_SPINE, 
   Kinect.NUI_SKELETON_POSITION_HIP_CENTER);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_HIP_CENTER, 
   Kinect.NUI_SKELETON_POSITION_HIP_LEFT);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_HIP_CENTER, 
   Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_HIP_LEFT, 
   Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);
   
   // Left Arm
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, 
   Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT, 
   Kinect.NUI_SKELETON_POSITION_WRIST_LEFT);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_WRIST_LEFT, 
   Kinect.NUI_SKELETON_POSITION_HAND_LEFT);
   
   // Right Arm
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, 
   Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT, 
   Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT, 
   Kinect.NUI_SKELETON_POSITION_HAND_RIGHT);
   
   // Left Leg
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_HIP_LEFT, 
   Kinect.NUI_SKELETON_POSITION_KNEE_LEFT);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_KNEE_LEFT, 
   Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT, 
   Kinect.NUI_SKELETON_POSITION_FOOT_LEFT);
   
   // Right Leg
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_HIP_RIGHT, 
   Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT, 
   Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT);
   DrawBone(_s, 
   Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT, 
   Kinect.NUI_SKELETON_POSITION_FOOT_RIGHT);
   */
}

void DrawHead(SkeletonData _s, int _j1) {


  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    fill(100);
    // head marker
    ellipse(_s.skeletonPositions[_j1].x * kinectWidth + kinectImgOffset.x, _s.skeletonPositions[_j1].y * kinectHeight + kinectImgOffset.y, 30, 30);

    // audio loudness shadow
    drawLoudnessShadow(_s.skeletonPositions[_j1].x * kinectWidth + kinectImgOffset.x, _s.skeletonPositions[_j1].y * kinectHeight + kinectImgOffset.y);
  }
}


void DrawBone(SkeletonData _s, int _j1, int _j2) 
{
  noFill();
  stroke( 0);
  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    line(_s.skeletonPositions[_j1].x * kinectWidth + kinectImgOffset.x, 
      _s.skeletonPositions[_j1].y*  kinectHeight + kinectImgOffset.y, 
      _s.skeletonPositions[_j2].x * kinectWidth + kinectImgOffset.x, 
      _s.skeletonPositions[_j2].y * kinectHeight + kinectImgOffset.y);
  }
}

void appearEvent(SkeletonData _s) 
{
  if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
  }
}

void disappearEvent(SkeletonData _s) 
{
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_s.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.remove(i);
      }
    }
  }
}

void moveEvent(SkeletonData _b, SkeletonData _a) 
{
  if (_a.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}
