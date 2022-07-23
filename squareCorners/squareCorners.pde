float MARGIN_SIZE = 16.0;
int ROW_SIZE = 10;
float MAX_SQUARE_SIZE = 0.0;
float NOISE_SCALE = 0.000125;
float SQUARE_INTERVAL = 0.0;
PVector[] squares = new PVector[ROW_SIZE * ROW_SIZE];
int[] buckets = new int[4];

void setup() {
  println("setup() starting...");
  size(600,600);
  SQUARE_INTERVAL = ( width / ROW_SIZE);
  MAX_SQUARE_SIZE = SQUARE_INTERVAL * 0.8;
  MARGIN_SIZE = ( SQUARE_INTERVAL - MAX_SQUARE_SIZE ) / 2.0;
  squares = prepare_squares();
  println("setup() finished.");
  // frameRate(15);
  noLoop();
}

void mouseClicked() {
  squares = prepare_squares();
  NOISE_SCALE = mouseY;
  MAX_SQUARE_SIZE = mouseX / 2.0;
  println("NOISE_SCALE="+NOISE_SCALE+", MAX_SQUARE_SIZE="+MAX_SQUARE_SIZE);
}

void draw() {
  println("draw() starting...");
  clear();
  for (PVector square : squares) {
    // float cornerNoiseValue = noise(square.x / NOISE_SCALE, square.y / NOISE_SCALE, frameCount / NOISE_SCALE);
    float cornerNoiseValue = noise(square.x / NOISE_SCALE, square.y / NOISE_SCALE);
    // stroke(255, 0, 255);
    stroke(0);
    fill(255, 255, 255);
    // fill(58, 110, 165);
    rectMode(CORNER);
    rect(square.x, square.y, MAX_SQUARE_SIZE, MAX_SQUARE_SIZE);
    drawCorner(square, cornerNoiseValue);
  }
  println("buckets: "+buckets[0]+"-"+buckets[1]+"-"+buckets[2]+"-"+buckets[3]);
}

void drawCorner(PVector square, float noiseValue) {
  PVector corner = new PVector(0, 0);

  float ornamentSideLength = 5.0;
  float ornamentMargin = floor(ornamentSideLength * 0.8);
  ornamentMargin = ornamentSideLength;

  // top left
  if (noiseValue < 0.25) {
    corner = new PVector(square.x + ornamentMargin, square.y + ornamentMargin);
    buckets[0]++;
  }
  // top right
  else if (noiseValue < 0.5) {
    corner = new PVector(square.x + MAX_SQUARE_SIZE - ornamentMargin + 1, square.y + ornamentMargin);
    buckets[1]++;
  }
  // bottom right
  else if (noiseValue < 0.75) {
    corner = new PVector(square.x + MAX_SQUARE_SIZE - ornamentMargin + 1, square.y + MAX_SQUARE_SIZE - ornamentMargin + 1);
    buckets[2]++;
  }
  // bottom left
  else if (noiseValue <= 1.0) {
    corner = new PVector(square.x + ornamentMargin, square.y + MAX_SQUARE_SIZE - ornamentMargin);
    buckets[3]++;
  }

  // stroke(255,0,255);
  // fill(58,110,165);
  stroke(127);
  fill(64);
  rectMode(CENTER);
  rect(corner.x, corner.y, ornamentSideLength, ornamentSideLength);
}

PVector[] prepare_squares() {
  println("prepare_squares() starting...");

  int currentRow = 0;

  for (int i = 0; i < squares.length; i++) {
    int modulus = i % ROW_SIZE;

    float squareX = ( modulus * SQUARE_INTERVAL ) + MARGIN_SIZE;
    float squareY = ( currentRow * SQUARE_INTERVAL ) + MARGIN_SIZE;
    // println("xy="+squareX + "/" + squareY + ";mod="+modulus);
    PVector xy = new PVector(squareX, squareY);

    squares[i] = xy;
    if ((modulus+1) == ROW_SIZE) {
      currentRow++;
    }
  }

  return squares;
}
