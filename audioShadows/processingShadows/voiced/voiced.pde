



int sliceCount = 4;
float innerRadius;
float outerRadius;
float sliceAngle = TWO_PI / sliceCount ;
float halfSliceAngle = sliceAngle/2 ;
PVector[] controlPoints;
PVector[] outerVertices;
PVector[] innerVertices;
PVector center;

void setup(){
size(300,300);

innerRadius = width * 0.2;
outerRadius = width * 0.4;

center = new PVector(width/2, height/2);

controlPoints = new PVector[sliceCount*2]; // for outer vertices
outerVertices = new PVector[sliceCount];
innerVertices = new PVector[sliceCount];

}

void draw(){
clear();


center = new PVector(mouseX, mouseY);

//update shape

for (int i=0; i<sliceCount; i++){
  
  innerVertices[i] = new PVector(cos(sliceAngle * i) * innerRadius + center.x, sin(sliceAngle * i) * innerRadius + center.y);
  
  outerVertices[i] = new PVector(cos(sliceAngle * i + halfSliceAngle) * outerRadius + center.x, sin(sliceAngle * i + halfSliceAngle) * outerRadius + center.y);
  
}

// draw
beginShape();

for (int i=0; i<sliceCount; i++){
  vertex(innerVertices[i].x, innerVertices[i].y);
  vertex(outerVertices[i].x, outerVertices[i].y);
 
}

endShape(CLOSE);
}