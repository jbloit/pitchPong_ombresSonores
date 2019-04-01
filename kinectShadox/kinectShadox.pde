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


float minThresh = 100;
float maxThresh = 255;
boolean calibrationMode = true;

void setup()
{
  size(640, 480);
  background(0);
  kinect = new Kinect(this);
  smooth();
}

void draw()
{
  
  if (calibrationMode){
    minThresh = float(mouseX) / width *255.0 ;
    maxThresh = float(mouseY) / height * 255.0;
  }
  
  
  
  background(0);
  img = kinect.GetDepth();

  img.loadPixels();
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int index = x + y * img.width;
      float b = brightness(img.pixels[index]);
      if (b > minThresh && b < maxThresh) {
        img.pixels[index] = color(233, 0, 150);
      } else {
        img.pixels[index] = color(0, 0, 0);
      }
    }
  }
  img.updatePixels();
  image(img, 0, 0);
  
  if (calibrationMode){
    fill(255);
    textSize(20);
    text("min thresh " + str(minThresh) + " max thresh " + str(maxThresh), 0, 50);
  }
}
