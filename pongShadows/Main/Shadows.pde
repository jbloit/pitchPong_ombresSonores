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
  
  

  /////////////////////////////////
  // Audio analysis current values. The voiced animation needs 2 control parameters, value(the actual timbre descriptor)
  // and gain (so that nothing shows when no sound is present)
  float ampValue = 0;
  float voicedValue = 0; 
  float voicedGain = 0;

  // Origin for silhouette and skeleton image
  PVector kinectImgOffset = new PVector(50, 50);

  /////////////////////////////////
  // For loudness shadow  
  int slices = 20;
  float pie_slice = TWO_PI/slices;
  float x, y, szX, szY, theta;


  /////////////////////////////////
  // For Voiced shadow
  int sliceCount = 10;
  float innerRadius;
  float outerRadius;
  float midRadius;
  float sliceAngle = TWO_PI / sliceCount ;
  float halfSliceAngle = sliceAngle/2 ;
  float quarterSliceAngle = halfSliceAngle ;
  PVector[] controlPoints;
  PVector[] outerVertices;
  PVector[] innerVertices;
  PVector center;

  /////////////////////////////////
  // Constructor
  public Shadows(PApplet _parent) {
    parent = _parent;
    kinect = new Kinect(parent);
    bodies = new ArrayList<SkeletonData>();


    ////////// For booba/kiki shadow
    innerRadius = width * 0.1;
    outerRadius = width * 0.4;
    midRadius = width * 0.2;
    controlPoints = new PVector[sliceCount*2]; // for outer vertices
    outerVertices = new PVector[sliceCount];
    innerVertices = new PVector[sliceCount];
  }

  public void draw() {
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

    // println(bodies.size());

    // For each detected person, draw the skeleton/and or animation
    for (int i=0; i<bodies.size(); i++) {
      drawSkeleton(bodies.get(i));
    }
  }

  /////////////////////////////////////////////////////////////////////////
  // sombrero shadow, reacts to audio Loudness
  void drawLoudnessShadow(float centerX, float centerY) {
    fill(0);
    y = map(theta, 0, 1, 0, -150);
    szY = height/4 + y ;
    szX = 200; 
    for (int i=0; i<slices; i++) {
      pushMatrix();
      translate(centerX, centerY);   
      rotate(i*pie_slice);
      arc(0, y, szX, szY, (PI*1.5)-(pie_slice/2), (PI*1.5)+(pie_slice/2));
      popMatrix();
    } 
    theta = ampValue ;
    //  draw inner circle
    float w = 50 + 100 * ampValue; 
    float h = w;
    ellipse(centerX, centerY, w, h);
  }


  /////////////////////////////////////////////////////////////////////////
  // bouba/kiki shadow, reacts to audio amplitude and voiced feature
  void drawVoicedShadow(float centerX, float centerY) {

    quarterSliceAngle = map(this.voicedValue, 1, 0, -sliceAngle, sliceAngle);
    outerRadius = map(this.voicedGain, 0, 1, innerRadius, kinectWidth );
    midRadius = map(this.voicedValue, 1, 0, outerRadius, innerRadius);

    for (int i=0; i<sliceCount; i++) {
      innerVertices[i] = new PVector(cos(sliceAngle * i) * innerRadius + centerX, sin(sliceAngle * i) * innerRadius + centerY);
      outerVertices[i] = new PVector(cos(sliceAngle * i + halfSliceAngle) * outerRadius + centerX, sin(sliceAngle * i + halfSliceAngle) * outerRadius + centerY);
      controlPoints[i*2] = new PVector(cos(sliceAngle * i - quarterSliceAngle) * midRadius + centerX, sin(sliceAngle * i - quarterSliceAngle) * midRadius + centerY);
      controlPoints[i*2 + 1] = new PVector(cos(sliceAngle * i + quarterSliceAngle) * midRadius + centerX, sin(sliceAngle * i + quarterSliceAngle) * midRadius + centerY);
    }

    // draw
    fill(0);
    beginShape();
    for (int i=0; i<sliceCount; i++) {
      vertex(innerVertices[i].x, innerVertices[i].y);
      bezierVertex(controlPoints[i*2].x, controlPoints[i*2].y, controlPoints[i*2 + 1].x, controlPoints[i*2 +1 ].y, outerVertices[i].x, outerVertices[i].y);
    }
    vertex(innerVertices[0].x, innerVertices[0].y);
    endShape();
  }


  void drawSkeleton(SkeletonData _s) 
  {

    // Head, this one embeds the head shadow animations 
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
      float headX = _s.skeletonPositions[_j1].x * kinectWidth + kinectImgOffset.x;
      float headY = _s.skeletonPositions[_j1].y * kinectHeight + kinectImgOffset.y;
      ellipse(_s.skeletonPositions[_j1].x * kinectWidth + kinectImgOffset.x, _s.skeletonPositions[_j1].y * kinectHeight + kinectImgOffset.y, 30, 30);

      // draw audio shadow
      if (headX < width/2) {
        drawLoudnessShadow(headX, headY);
      } else {
        drawVoicedShadow(headX, headY);
      }
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

  //////////////////////////////////////////////////////////////////
  // Audio analysis callbacks

  public void setLoudness(float ampVal) {
    this.ampValue = ampVal;
  }  

  public void setVoiced(float voicedVal, float ampVal) {
    this.voicedValue = voicedVal;
    this.voicedGain = ampVal;
  }



  //////////////////////////////////////////////////////////////////
  // Kinect callbacks

  public void appearEvent(SkeletonData _s) 
  {
    if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
    {
      return;
    }
    synchronized(bodies) {
      bodies.add(_s);
    }
  }

  public void disappearEvent(SkeletonData _s) 
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

  public void moveEvent(SkeletonData _b, SkeletonData _a) 
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
}
