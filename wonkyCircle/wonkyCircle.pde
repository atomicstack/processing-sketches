OpenSimplexNoise noise;

void setup(){
  size(1600,1600,P3D);
  
  noise = new OpenSimplexNoise();
  frameRate(120);
  // frameRate(30);
}

void draw() {
  background(0);
  float chunk = width / 10;
  float half = chunk / 2;
  // drawCircle(width/2, height/2, 500, 600);
  for (int row = 0; row < 10; row++) {
    for (int column = 0; column < 10; column++) {
      drawCircle(
        (int)((row * chunk) + half),
        (int)((column * chunk) + half),
        (int)(10 + ( 10 * row * 0.5 )),
        (int)(20 + ( 20 * row * 0.5 ))
      );
    }
  }
  // noLoop();
}

void drawCircle(int centerX, int centerY, int minRadius, int maxRadius) {
  // println(centerX + "/" + centerY + "/" + minRadius + "/" + maxRadius);
  pushMatrix();
  translate(centerX, centerY);
  stroke(255);
  noFill();
  beginShape();
  for (float i = 0; i < TWO_PI; i += 0.05) {
    float xoff = cos(i) + 1;
    float yoff = sin(i) + 1;
    float r = map(noise(xoff, yoff, frameCount * 0.05), 0, 1, minRadius, maxRadius);
    float x = r * cos(i);
    float y = r * sin(i);
    vertex(x,y);
  }
  endShape(CLOSE);
  popMatrix();
}
