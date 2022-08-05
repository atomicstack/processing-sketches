int default_radius = 750;
int current_iteration = 1;
int default_square_size = 30;

void setup() {
  size(2000, 2000);
  background(50);
  translate(width/2, height/2);
  rectMode(RADIUS);
 
}

void draw() {
  clear();
  background(50);
  translate(width/2, height/2);
  rotate(5);
  for (int i = 0; i < 360; i += 10) {
    float theta = radians(i);
    float sin_theta = sin(theta);
    float cos_theta = cos(theta);
    
    int x = int(default_radius * sin_theta);
    int y = int(default_radius * cos_theta);
    int square_size = int( float(default_square_size) * ( abs(cos_theta) * 1.5 ) + 7 );
    
    pushMatrix();
    translate(x, y);
    rotate(radians(i+frameCount));
    fill(0);
    rect(0,0, square_size, square_size);
    popMatrix();
  }
}
