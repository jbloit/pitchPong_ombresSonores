



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

void setup(){
size(300,300);
background(255);

innerRadius = width * 0.1;
outerRadius = width * 0.4;
midRadius = width * 0.2;

center = new PVector(width/2, height/2);

controlPoints = new PVector[sliceCount*2]; // for outer vertices
outerVertices = new PVector[sliceCount];
innerVertices = new PVector[sliceCount];

}

void draw(){
clear();
background(255);
fill(0);
center = new PVector(center.x, center.y);

//update shape

quarterSliceAngle = map(mouseX, 0, width, 0, sliceAngle);
outerRadius = map(mouseY , 0, height, innerRadius, width + 0.3);





for (int i=0; i<sliceCount; i++){
  
  innerVertices[i] = new PVector(cos(sliceAngle * i) * innerRadius + center.x, sin(sliceAngle * i) * innerRadius + center.y);
 
  outerVertices[i] = new PVector(cos(sliceAngle * i + halfSliceAngle) * outerRadius + center.x, sin(sliceAngle * i + halfSliceAngle) * outerRadius + center.y);
  controlPoints[i*2] = new PVector(cos(sliceAngle * i - quarterSliceAngle) * midRadius + center.x, sin(sliceAngle * i - quarterSliceAngle) * midRadius + center.y);
  controlPoints[i*2 + 1] = new PVector(cos(sliceAngle * i + quarterSliceAngle) * midRadius + center.x, sin(sliceAngle * i + quarterSliceAngle) * midRadius + center.y);
}



// draw
beginShape();

for (int i=0; i<sliceCount; i++){
  vertex(innerVertices[i].x, innerVertices[i].y);
  
  bezierVertex(controlPoints[i*2].x, controlPoints[i*2].y, controlPoints[i*2 + 1].x, controlPoints[i*2 +1 ].y, outerVertices[i].x, outerVertices[i].y);
  
  
  /*
  ellipseMode(CENTER);
  ellipse(controlPoints[i*2].x, controlPoints[i*2].y, 10, 10);
  
  ellipse(controlPoints[i*2 + 1].x, controlPoints[i*2 +1].y, 10, 10);
  */

}


vertex(innerVertices[0].x, innerVertices[0].y);

endShape();
/*
for (int i=0; i<sliceCount; i++){
  fill(200);
  ellipse(innerVertices[i].x,innerVertices[i].y, 10,10);

}

for (int i=0; i<sliceCount; i++){
  fill(100);
  ellipse(outerVertices[i].x,outerVertices[i].y, 10,10);

}
*/

}