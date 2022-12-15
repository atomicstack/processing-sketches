// a processing port of the following p5.js sketch:
// https://openprocessing.org/sketch/1165174

float tileSize = 50;
float sin30 = 0.5;
float cos30 = (float)(Math.sqrt(3) / 2);
float halfTileLength = tileSize * cos30;
float halfTileBreadth = tileSize * sin30;
float tileLength = halfTileLength * 2;
float tileBreadth = halfTileBreadth * 2;

color topColor = color(166, 166, 166);
color leftColor = color(100, 100, 100);
color rightColor = color(33, 33, 33);
color[] colors = new color [] { topColor, leftColor, rightColor };

float noiseScale = 0.0125;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void setup() {
  size(800,800, P3D);
  // angleMode(DEGREES);
  smooth(8);
  // noLoop();
  frameRate(30);

  // println("sin30: "+sin30);
  // println("cos30: "+cos30);
  // println("halfTileLength: "+halfTileLength);
  // println("halfTileBreadth: "+halfTileBreadth);
  // println("tileLength: "+tileLength);
  // println("tileBreadth: "+tileBreadth);
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void draw() {
  int row = 0;
  int col = 0;
  // noStroke();
  strokeWeight(1);
  for (float y = 0;
       y < height + tileBreadth;
       y += tileSize + halfTileBreadth) {
    for (float x = (row % 2) * -halfTileLength;
         x < width + halfTileLength;
         x += tileLength) {
      
      float d = dist(x, y, mouseX, mouseY);
      float b = max(0.0, 100.0 - d / 2.0);
      
      // Draw the "top" rhombus
      // fill(b + map(y - mouseY, -height, height, 50, 250));
      // fill(topColor);
      // fill(colors[int(random(colors.length))]);
      fill(noise(x * noiseScale, y * noiseScale, frameCount * noiseScale) * 255.0);
      quad(
        x, y,
        x - halfTileLength, y - halfTileBreadth,
        x, y - tileBreadth,
        x + halfTileLength, y - halfTileBreadth
      );

      // Draw the "left" rhombus
      // fill(b + map(mouseX - x, -width, width, 250, 50));
      // fill(leftColor);
      // fill(colors[int(random(colors.length))]);
      fill(noise(x * noiseScale, y * noiseScale, frameCount * noiseScale) * 180.0);
      quad(
        x, y,
        x, y + tileSize,
        x - halfTileLength, y - halfTileBreadth + tileSize,
        x - halfTileLength, y - halfTileBreadth
      );

      // Draw the "right" rhombus
      // fill(b + map(mouseX - x, -width, width, 50, 250));
      // fill(rightColor);
      // fill(colors[int(random(colors.length))]);
      fill(noise(x * noiseScale, y * noiseScale, frameCount * noiseScale) * 110.0);
      quad(
        x, y,
        x + halfTileLength, y - halfTileBreadth,
        x + halfTileLength, y - halfTileBreadth + tileSize,
        x, y + tileSize
      );

      col++;
    }
    row++;
    col = 0;
  }
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
    }
    else if (keyCode == DOWN) {
    } 
  } else {
    if (key == 'q') { exit(); }
    else if (key == 'r') { redraw(); }
  }
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void mouseMoved() {
  // redraw();  
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void mousePressed() {
  redraw();
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
