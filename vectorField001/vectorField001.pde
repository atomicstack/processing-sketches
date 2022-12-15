int cols, rows;
float x, y, z;

void setup() {
  size(1000, 1000);
  cols = 30;
  rows = 30;
  x = 0;
  y = 0;
  z = 0;
}

void draw() {
  background(0);

  pushMatrix();
  translate(width/2, height/2);
  
  for (int i = 0; i <= cols; i++) {
    for (int j = 0; j <= rows; j++) {
      float x = map(i, 0, cols, -width/2, width/2);
      float y = map(j, 0, rows, -height/2, height/2);
      float angle = atan2(y, x);
      float magnitude = noise(x/100.0, y/100.0, z);
      float vx = cos(angle) * magnitude;
      float vy = sin(angle) * magnitude;
      
      stroke(255);
      strokeWeight(2);
      pushMatrix();
      translate(x, y);
      rotate(angle);
      line(0, 0, magnitude * 10, 0);
      popMatrix();
    }
  }
  
  z += 0.01;
  popMatrix();
}
