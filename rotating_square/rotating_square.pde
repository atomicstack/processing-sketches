int spacing;

void setup() {
  size(1200,800);
  frameRate(120);
  rectMode(CENTER);
  spacing = int(width / 11);
}

void draw() {
  clear();
  translate(0, height/2);
  for (int i = 1; i <= 10; i++) {
    pushMatrix();
    translate(i * spacing, 0);
    rotate(radians(frameCount * radians(frameCount)));
    rect(0, 0, 50, 50);
    popMatrix();
  }
}
