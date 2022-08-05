int default_radius = 500;
int current_iteration = 1;
int default_square_size = 30;
int step_size = 10;
PVector[] locations_by_degree = new PVector[360]; 


void setup() {
  size(1500, 1500);
  background(50);
  translate(width/2, height/2);
  rectMode(RADIUS);
  
  for (int i = 0; i < 360; i += step_size) {
    //float theta = map(i, 0, 360, -PI, PI);
    float theta = radians(i);
    float sin_theta = sin(theta);
    float cos_theta = cos(theta);
    
    int x = int(default_radius * sin_theta);
    int y = int(default_radius * cos_theta);
    int z = -int(i);
    locations_by_degree[i] = new PVector(x, y, z);
  }

  frameRate(60);
}

void draw() {
  clear();
  background(50);
  translate(width/2, height/2);
     
  for (int i = 0; i < 360; i += step_size) {
        
    PVector pv = locations_by_degree[i];
                    
    pushMatrix();
    translate(pv.x, pv.y);
    rotate(radians(pv.z + frameCount + (height-mouseY)/4));
    fill(0);
    rect(0,0, default_square_size * cos(radians(pv.z + frameCount + mouseX/8)), default_square_size * sin(radians(pv.z + frameCount + mouseX/8)));
    popMatrix();
  }
  
  //print(mouseX, mouseY, "\n");
}
