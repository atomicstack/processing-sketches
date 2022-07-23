int TOTAL_CIRCLES = 64;
float NOISE_SCALE = 17.0;
float MAX_CIRCLE_SIZE = 50.0;
float margin = 35.0;
PVector[] circles = new PVector[TOTAL_CIRCLES];

void setup() {
  println("setup() starting...");
  size(600,600, P3D);
  // ellipseMode(CORNER);
  circles = prepare_circles();
  println("setup() finished...");
  // frameRate(30);
}

void mouseClicked() {
  circles = prepare_circles();
  NOISE_SCALE = mouseY;
  MAX_CIRCLE_SIZE = mouseX;
  println("NOISE_SCALE="+NOISE_SCALE+", MAX_CIRCLE_SIZE="+MAX_CIRCLE_SIZE);
}

void draw() {
  // println("draw() about to run...");
  clear();
  for (PVector circle : circles) {
    float circleNoise = noise(circle.x, circle.y, frameCount / NOISE_SCALE);
    float circleAlpha = 255.0 * ( 1.0 - circleNoise );
    float circleSize = MAX_CIRCLE_SIZE * circleNoise;
    stroke(0);
    fill(180, 180, 180, circleAlpha);
    circle(circle.x, circle.y, circleSize);
  }
}

PVector[] prepare_circles() {
  println("prepare_circles() about to run...");

  float squareRoot = ceil(sqrt(TOTAL_CIRCLES));
  float rowHeight = height / squareRoot;
  float rowWidth  = width  / squareRoot;
  // println("squareRoot="+squareRoot);

  int currentRow = 0;

  for (int i = 0; i < TOTAL_CIRCLES; i++) {
    float modulus = i % squareRoot;
    float circleX = ( modulus * rowWidth ) + margin;
    float circleY = ( currentRow * rowHeight ) + margin;
    println("xy="+circleX + "/" + circleY + ";mod="+modulus);
    PVector xy = new PVector(circleX, circleY);
    circles[i] = xy;
    if ( modulus == squareRoot - 1.0 ) {
      currentRow++;
    }
  }

  return circles;
}

// PVector[] prepare_circles() {
//   println("prepare_circles() about to run...");
//   for (int i=0; i<TOTAL_CIRCLES; i++) {
//     float circleX = random(0, width);
//     float circleY = random(0, height);
//     PVector xy = new PVector(circleX, circleY);
//     circles[i] = xy;
//   }
// 
//   return circles;
// }
