public void settings(){
  size(640,640,P3D);
}

int MID_X;
int MID_Y;

void setup() {
  colorMode(HSB, 255, 255, 255, 255);
  MID_Y = height / 2;
  MID_X = width / 2;
  frameRate(60);
}

void draw() {
  clear();
  background(0);

  float yCos = cos(frameCount);
  float zSin = sin(frameCount);

  float yPosition = MID_Y + ( 100 * yCos ); 
  float zDepth = 100 * zSin;
  rotateY(radians(frameCount % 360));

  translate(MID_X, yPosition, zDepth);
  println("MID_X: "+MID_X+", yPosition: "+yPosition+", zDepth:" + zDepth);
  fill(255);
  box(150);
}
