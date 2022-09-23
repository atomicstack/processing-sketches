void setup() {
  size(800, 800, P3D);
}

void draw() {
  background(0);  
  if (mousePressed) {
    // draw with perspective variations
    float fov = PI/map(mouseX, 0, width, 3.0, 6.0);
    float cameraZ = (height/2.0) / tan(fov/2.0);
    perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
  } else {
    // draw with frustum variations
    frustum(-width/8, width/8, height/8, -height/8, map(mouseX, 0, width, 10, 200), 400);
  }
  
  // camera eye at 300 towards to you and looking at the center where Y is up in a (x/z) plane
  camera(0, 0, -300, 0, 0, 0, 0, 1, 0);
  
  // draw a box at the center position
  rotateX(frameCount/100.0);
  rotateY(frameCount/150.0);
  stroke(128);
  fill(255);
  box(100);
}
