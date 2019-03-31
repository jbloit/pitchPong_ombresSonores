/*
This sketcth is tested only on windows 7, with a kinect xbox 360 (v1 - model 1414)

Prior to pluging the kinect for the first time, install the window sdk version 1.8 from 
https://www.microsoft.com/en-us/download/details.aspx?id=40278
as well as the developer tools (link provided at the end of the installation process above).

Then install the kinect4WinSDK processing library.

This example just shows the images aquired by the kinect camera

see the library API here: 
http://www.magicandlove.com/blog/research/kinect-for-processing-library/

*/



import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;

Kinect kinect;
ArrayList <SkeletonData> bodies;

void setup()
{
  size(640, 480);
  background(0);
  kinect = new Kinect(this);
  smooth();

}

void draw()
{
  background(0);
  image(kinect.GetImage(), 320, 0, 320, 240);
  image(kinect.GetDepth(), 320, 240, 320, 240);
  image(kinect.GetMask(), 0, 240, 320, 240);
}
