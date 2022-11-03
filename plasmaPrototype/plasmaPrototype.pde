// Lifted from:
// https://rosettacode.org/wiki/Plasma_effect#Processing

/**
 Plasmas with Palette Looping
 https://lodev.org/cgtutor/plasma.html#Plasmas_with_Palette_Looping_
 */


int pal[] = new int[128];
int[] buffer;
float r = 42, g = 84, b = 126;
float xScale = 64.0, yScale = 48.0, xxyyScale = 64.0;
boolean rd, gd, bd;

void setup() {
  size(600, 600);
  frameRate(120);
  buffer = new int[width*height];
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {

      if (x < ( width / 4 )) {
        float adjust = random(-1.0, 1.0);
        if (false && random(0, 1) > 0.5) { xScale += adjust; }
        if (false && random(0, 1) > 0.5) { yScale += adjust; }
        if (false && random(0, 1) > 0.5) { xxyyScale += adjust; }
      }

      // original buffer code
      /*

      buffer[x+y*width] = int((
        (128+(128*sin(x/xScale)))
        +(128+(128*sin(y/yScale)))
        // +(128+(128*cos(x*y/1024)))

        // (128+(128*sin((x*x)/xScale)))
        // +(128+(128*cos(y/yScale))) 
        // +(128+(128*sin(sqrt((x*x+y*y))/xxyyScale)))
      )/4);

      */

      buffer[x+y*width] = int((
        (
          128.0 + (128.0 * sin(x / 16.0))
        + 128.0 + (128.0 * sin(y / 16.0))
        ) / 2
      ));
    }
  }
}

void draw() {
  if (r > 128) rd = true;
  if (!rd) r++;
  else r--;
  if (r < 0) rd = false;
  if (g > 128) gd = true;
  if (!gd) g++;
  else g--;
  if (r < 0) gd = false; 
  if (b > 128) bd = true;
  if (!bd) b++;
  else b--;
  if (b < 0){ bd = false;}
  float s_1, s_2;
  for (int i = 0; i < 128; i++) {
    s_1 = sin(i*PI/25);
    s_2 = sin(i*PI/50+PI/4);
    pal[i] = color(r+s_1*128, g+s_2*128, b+s_1*128);
  }
  loadPixels();
  for (int i = 0; i < buffer.length; i++) {                    
    pixels[i] =  pal[(buffer[i]+frameCount)&127];
  }
  updatePixels();
}
