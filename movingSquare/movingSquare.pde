int ROW_SIZE        = 4;
int TRANSITION_SIZE = 30;
int SQUARE_SIZE     = 90;
int SQUARE_OFFSET   = 45;
int FRAME_OFFSET    = 0;

PVector[] squares = new PVector[ROW_SIZE * ROW_SIZE];

void setup() {
  size(600,600);
  rectMode(CENTER);
  colorMode(HSB, 360-(TRANSITION_SIZE*2), 100, 100);
  frameRate(5);
  frameRate(60);
}

// void update() {
// }

void draw() {
  clear();
  background(0);
  stroke(0);
  strokeWeight(1);

  int thisFrame = frameCount + FRAME_OFFSET;

  for (int i = 0; i < ROW_SIZE; i++) {
    for (int j = 0; j < ROW_SIZE; j++) {
      float xLocation = SQUARE_SIZE + ( i * SQUARE_SIZE ) + ( i * SQUARE_OFFSET );
      float yLocation = SQUARE_SIZE + ( j * SQUARE_SIZE ) + ( j * SQUARE_OFFSET );
      pushMatrix();
      translate(xLocation, yLocation);
      rotate(radians(thisFrame));
      int thisFrameModulus = thisFrame % 360;
      float thisSquareSize = map(sin(radians(thisFrame)), -1, 1, SQUARE_SIZE * 0.4, SQUARE_SIZE);
      if (thisFrameModulus <= TRANSITION_SIZE) {
        int fadeInDistance = thisFrameModulus;
        float lerpDistance = map(fadeInDistance, 0, TRANSITION_SIZE, 0, 100);
        println("fadeIn lerpDistance: " + lerpDistance);
        // color colorFrom = color(0, 0, 100);
        // color colorTo = color(0, 100, 100);
        // color colorTo = color(0, 0, 100, 100);
        // color midColor = lerpColor(colorFrom, colorTo, lerpDistance);
        fill(0, lerpDistance, 100);
      }
      else if (thisFrameModulus > ( 360 - TRANSITION_SIZE ) ) {
        int fadeOutDistance = 360 - thisFrameModulus;
        float lerpDistance = map(fadeOutDistance, 1, TRANSITION_SIZE, 0, 100);
        println("fadeOut lerpDistance: " + lerpDistance);
        // color colorFrom = color(360-(TRANSITION_SIZE*2), 100, 100);
        // color colorTo = color(0, 0, 100);
        // color midColor = lerpColor(colorFrom, colorTo, lerpDistance);
        // fill(midColor);
        fill(360 - TRANSITION_SIZE*2, lerpDistance, 100);
      }
      else {
        // int fillValue = thisFrameModulus - (TRANSITION_SIZE*2);
        int fillValue = thisFrameModulus - TRANSITION_SIZE;
        fill(fillValue, 100, 100);
        println("fillValue:" + fillValue);
      }
      rect(0, 0, thisSquareSize, thisSquareSize);
      popMatrix();
    }
  }

  for (int i = 0; i < ROW_SIZE - 1; i++) {
    for (int j = 0; j < ROW_SIZE - 1; j++) {
      float xLocation = SQUARE_SIZE + ( i * SQUARE_SIZE ) + ( i * SQUARE_OFFSET ) + SQUARE_SIZE*0.75;
      float yLocation = SQUARE_SIZE + ( j * SQUARE_SIZE ) + ( j * SQUARE_OFFSET ) + SQUARE_SIZE*0.75;
      pushMatrix();
      translate(xLocation, yLocation);
      rotate(radians(thisFrame));
      int thisFrameModulus = thisFrame % 360;
      int colorModulus = ( thisFrame + 180 ) % 360;
      float thisSquareSize = map(sin(radians(thisFrame+180)), -1, 1, SQUARE_SIZE * 0.4, SQUARE_SIZE);
      if (colorModulus <= TRANSITION_SIZE) {
        int fadeInDistance = colorModulus;
        float lerpDistance = map(fadeInDistance, 0, TRANSITION_SIZE, 0, 100);
        println("fadeIn lerpDistance: " + lerpDistance);
        // color colorFrom = color(0, 0, 100);
        // color colorTo = color(0, 100, 100);
        // color colorTo = color(0, 0, 100, 100);
        // color midColor = lerpColor(colorFrom, colorTo, lerpDistance);
        fill(0, lerpDistance, 100);
      }
      else if (colorModulus > ( 360 - TRANSITION_SIZE ) ) {
        int fadeOutDistance = 360 - colorModulus;
        float lerpDistance = map(fadeOutDistance, 1, TRANSITION_SIZE, 0, 100);
        println("fadeOut lerpDistance: " + lerpDistance);
        // color colorFrom = color(360-(TRANSITION_SIZE*2), 100, 100);
        // color colorTo = color(0, 0, 100);
        // color midColor = lerpColor(colorFrom, colorTo, lerpDistance);
        // fill(midColor);
        fill(360 - TRANSITION_SIZE*2, lerpDistance, 100);
      }
      else {
        // int fillValue = thisFrameModulus - (TRANSITION_SIZE*2);
        int fillValue = colorModulus - TRANSITION_SIZE;
        fill(fillValue, 100, 100);
        println("fillValue:" + fillValue);
      }
      rect(0, 0, thisSquareSize, thisSquareSize);
      popMatrix();
    }
  }
}
