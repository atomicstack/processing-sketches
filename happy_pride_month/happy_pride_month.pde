/**
 * Letters. 
 * 
 * Draws letters to the screen. This requires loading a font, 
 * setting the font, and then drawing the letters.
 */

PFont f;

void setup() {
  size(1000, 1000, P3D);
  background(0);

  // Create the font
  printArray(PFont.list());
  f = createFont("SourceCodePro-Regular.ttf", 24);
  textFont(f);
  textAlign(CENTER, CENTER);
  frameRate(144);
  colorMode(HSB, 100);
} 

void draw() {
  background(0);

  // Set the left and top margin
  int margin = 10;
  translate(margin*4, margin*4);

  int gap = 46;
  int counter = 35;
  
  for (int y = 0; y < height-gap; y += gap) {
    for (int x = 0; x < width-gap; x += gap) {

      char letter = char(counter);
      float hue = ( counter - 15 + frameCount/4 ) % 100;
      fill(hue, 127, 127);

      pushMatrix();
      translate(x,y);
      rotateY(radians(frameCount*2 + x + y));
      // Draw the letter to the screen
      text(letter, 0, 0);
      popMatrix();

      // Increment the counter
      counter++;
    }
  }
}
