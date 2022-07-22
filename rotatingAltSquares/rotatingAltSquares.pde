int ROW_SIZE        = 7;
int TRANSITION_SIZE = 30;
int SQUARE_SIZE     = 100;
int SQUARE_OFFSET   = 50;
int FRAME_OFFSET    = 0;

int SQUARE_REPEATS  = 10;

PShader blurShader;

// used in draw()
int[][] result;
int samplesPerFrame = 5;
int numFrames = 360;        
float shutterAngle = .8;
boolean recording = false;
float t, c;


PVector[] squares = new PVector[ROW_SIZE * ROW_SIZE];

void setup() {
  size(1080,1080, P2D);
  rectMode(CENTER);
  colorMode(HSB, 360-(TRANSITION_SIZE*2), 100, 100);

  // blurShader = loadShader("gene-kogan-shader.glsl");
  // PVector blurVec = new PVector(1, 0); 
	// int blurSize = 16;
	// float blurAngle = 180;
	// blurVec.rotate(blurAngle);
	// blurShader.set("blurSize", blurSize);
	// blurShader.set("dx", blurVec.x);
	// blurShader.set("dy", blurVec.y);

  result = new int[width*height][3];
  // frameRate(5);
  frameRate(60);
}

// void update() {
// }

void _draw() {
  // clear();
  // filter(blurShader);
  background(0);
  // stroke(0);
  // strokeWeight(1);

  int thisFrame = frameCount + FRAME_OFFSET;

  for (int i = 0; i < ROW_SIZE; i++) {
    for (int j = 0; j < ROW_SIZE; j++) {
      float xLocation = SQUARE_SIZE*0.75 + ( i * SQUARE_SIZE ) + ( i * SQUARE_OFFSET );
      float yLocation = SQUARE_SIZE*0.75 + ( j * SQUARE_SIZE ) + ( j * SQUARE_OFFSET );
      for (int k = 0; k < SQUARE_REPEATS; k++ ) {
        float percentDone = 1/((float)SQUARE_REPEATS-k) * 100.0;

        pushMatrix();
        translate(xLocation, yLocation);
        rotate(radians(thisFrame));
        rotate(radians(k * 10));
        int thisFrameModulus = thisFrame % 360;
        float thisSquareSize = map(sin(radians(thisFrame)), -1, 1, SQUARE_SIZE * 0.4, SQUARE_SIZE);
        color fillColor;
        color strokeColor;
        if (thisFrameModulus <= TRANSITION_SIZE) {
          int fadeInDistance = thisFrameModulus;
          float lerpDistance = map(fadeInDistance, 0, TRANSITION_SIZE, 0, 100);
          // println("fadeIn lerpDistance: " + lerpDistance);
          // color colorFrom = color(0, 0, 100);
          // color colorTo = color(0, 100, 100);
          // color colorTo = color(0, 0, 100, 100);
          // color midColor = lerpColor(colorFrom, colorTo, lerpDistance);

          // fill(0, lerpDistance, 100);
          // stroke(0, lerpDistance, 100);
          fillColor = color(0, lerpDistance, 100, percentDone);
          strokeColor = fillColor;
        }
        else if (thisFrameModulus > ( 360 - TRANSITION_SIZE ) ) {
          int fadeOutDistance = 360 - thisFrameModulus;
          float lerpDistance = map(fadeOutDistance, 1, TRANSITION_SIZE, 0, 100);
          // println("fadeOut lerpDistance: " + lerpDistance);
          // color colorFrom = color(360-(TRANSITION_SIZE*2), 100, 100);
          // color colorTo = color(0, 0, 100);
          // color midColor = lerpColor(colorFrom, colorTo, lerpDistance);
          // fill(midColor);

          // fill(360 - TRANSITION_SIZE*2, lerpDistance, 100);
          // stroke(360 - TRANSITION_SIZE*2, lerpDistance, 100);
          fillColor = color(360 - TRANSITION_SIZE*2, lerpDistance, 100, percentDone);
          strokeColor = fillColor;
        }
        else {
          // int fillValue = thisFrameModulus - (TRANSITION_SIZE*2);
          int fillValue = thisFrameModulus - TRANSITION_SIZE;
          // println("fillValue:" + fillValue);

          // fill(fillValue, 100, 100, (4.0-k)*100.0);
          // stroke(fillValue, 100, 100, (4.0-k)*100.0);
          fillColor = color(fillValue, 100, 100, percentDone);
          strokeColor = fillColor;
        }
        fill(fillColor);
        stroke(strokeColor);
        rect(0, 0, thisSquareSize, thisSquareSize);
        popMatrix();
      }
    }
  }

  for (int i = 0; i < ROW_SIZE - 1; i++) {
    for (int j = 0; j < ROW_SIZE - 1; j++) {
      float xLocation = SQUARE_SIZE*0.75 + ( i * SQUARE_SIZE ) + ( i * SQUARE_OFFSET ) + SQUARE_SIZE*0.75;
      float yLocation = SQUARE_SIZE*0.75 + ( j * SQUARE_SIZE ) + ( j * SQUARE_OFFSET ) + SQUARE_SIZE*0.75;
      pushMatrix();
      translate(xLocation, yLocation);
      rotate(radians(thisFrame));
      int thisFrameModulus = thisFrame % 360;
      int colorModulus = ( thisFrame + 180 ) % 360;
      float thisSquareSize = map(sin(radians(thisFrame+180)), -1, 1, SQUARE_SIZE * 0.4, SQUARE_SIZE);
      if (colorModulus <= TRANSITION_SIZE) {
        int fadeInDistance = colorModulus;
        float lerpDistance = map(fadeInDistance, 0, TRANSITION_SIZE, 0, 100);
        // println("fadeIn lerpDistance: " + lerpDistance);
        // color colorFrom = color(0, 0, 100);
        // color colorTo = color(0, 100, 100);
        // color colorTo = color(0, 0, 100, 100);
        // color midColor = lerpColor(colorFrom, colorTo, lerpDistance);
        fill(0, lerpDistance, 100);
        stroke(0, lerpDistance, 100);
      }
      else if (colorModulus > ( 360 - TRANSITION_SIZE ) ) {
        int fadeOutDistance = 360 - colorModulus;
        float lerpDistance = map(fadeOutDistance, 1, TRANSITION_SIZE, 0, 100);
        // println("fadeOut lerpDistance: " + lerpDistance);
        // color colorFrom = color(360-(TRANSITION_SIZE*2), 100, 100);
        // color colorTo = color(0, 0, 100);
        // color midColor = lerpColor(colorFrom, colorTo, lerpDistance);
        // fill(midColor);
        fill(360 - TRANSITION_SIZE*2, lerpDistance, 100);
        stroke(360 - TRANSITION_SIZE*2, lerpDistance, 100);
      }
      else {
        // int fillValue = thisFrameModulus - (TRANSITION_SIZE*2);
        int fillValue = colorModulus - TRANSITION_SIZE;
        fill(fillValue, 100, 100);
        stroke(fillValue, 100, 100);
        // println("fillValue:" + fillValue);
      }
      rect(0, 0, thisSquareSize, thisSquareSize);
      popMatrix();
    }
  }
}

void draw() {

  if (!recording) {
    _draw();
    // t = mouseX*1.0/width;
    // c = mouseY*1.0/height;
    // if (mousePressed) {
    //   println(c);
    //   _draw();
    // }
  } else {
    for (int i=0; i<width*height; i++) {
      for (int a=0; a<3; a++) {
        result[i][a] = 0;
      }
    }

    c = 0;
    for (int sa=0; sa<samplesPerFrame; sa++) {
      t = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
      _draw();
      loadPixels();
      for (int i=0; i<pixels.length; i++) {
        result[i][0] += pixels[i] >> 16 & 0xff;
        result[i][1] += pixels[i] >> 8 & 0xff;
        result[i][2] += pixels[i] & 0xff;
      }
    }

    loadPixels();
    for (int i=0; i<pixels.length; i++) {
      pixels[i] = 0xff << 24 | 
        int(result[i][0]*1.0/samplesPerFrame) << 16 | 
        int(result[i][1]*1.0/samplesPerFrame) << 8 | 
        int(result[i][2]*1.0/samplesPerFrame);
    }
    updatePixels();

    // saveFrame("fr###.png");
    // println(frameCount,"/",numFrames);
    // if (frameCount==numFrames) {
    //   exit();
    // }
  }
}