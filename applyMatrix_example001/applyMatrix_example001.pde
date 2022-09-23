void setup() {
  size(800, 800, P3D);
  frameRate(144);
}


void draw() {
  clear();
  noFill();
  translate(400,400, 0);
  rotateY(PI/6 + radians(frameCount)); 
  stroke(200,100,0);
  box(300);
  
  // Set rotation angles
  float ct = cos(PI/9.0);
  float st = sin(PI/9.0);          
  // Matrix for rotation around the Y axis
  applyMatrix(  ct, 0.0,  st,  0.0,
               0.0, 1.0, 0.0,  0.0,
               -st, 0.0,  ct,  0.0,
               0.0, 0.0, 0.0,  1.0);  
  stroke(255);
  box(400);
  
  rotateY(PI/6 + radians(frameCount));
  
  //translate(0,0,25); // same as below
  
  applyMatrix( 1.0, 0.0, 0.0,  0.0,
               0.0, 1.0, 0.0,  0.0,
               0.0, 0.0, 1.0, 25.0,
               0.0, 0.0, 0.0,  1.0);  
  
  stroke(255, 100, 50);
  box(500);
}
