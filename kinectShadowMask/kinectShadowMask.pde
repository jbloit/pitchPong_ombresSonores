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

void setup()
{
  
  //should be greater than kinect image dimensions
  size(800, 600);


  background(0);
  kinect = new Kinect(this);

  bodies = new ArrayList<SkeletonData>();
}

void draw()
{


  // draw silhouette
  img = kinect.GetMask();
  img.loadPixels();
  for (int x = 0; x < kinectWidth; x++) {
    for (int y = 0; y < kinectHeight; y++) {
      int index = x + y * kinectWidth;
      color c = color(img.pixels[index]);
      float a = alpha(c);

      if (a>0) {
        img.pixels[index] = color(0, 0, 0);
      } else {
        img.pixels[index] = color(100, 0, 200);
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

  fill(255);
  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    ellipse(_s.skeletonPositions[_j1].x * kinectWidth + kinectImgOffset.x, _s.skeletonPositions[_j1].y * kinectHeight + kinectImgOffset.y, 30, 30);
  }
}

void DrawBone(SkeletonData _s, int _j1, int _j2) 
{
  noFill();
  stroke(255, 255, 0);
  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    line(_s.skeletonPositions[_j1].x*width, 
      _s.skeletonPositions[_j1].y*height, 
      _s.skeletonPositions[_j2].x*width, 
      _s.skeletonPositions[_j2].y*height);
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
