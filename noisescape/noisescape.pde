// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Landscape with height values according to Perlin noise

Landscape land;    
float theta = 0.0;

void setup() {

  size(1200,1200,P3D);

  // Create a landscape object
  land = new Landscape(20,2000,2000);
  colorMode(HSB);
}

void draw() {

  // Ok, visualize the landscape space
  background(0);
  pushMatrix();
  translate(width/2,height/2-400,50);
  rotateX(PI/5);
  rotateZ(theta);
  land.render(); 
  popMatrix();

  land.calculate();
  
  theta += 0.0025;
}
