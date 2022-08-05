import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class circle_of_rotating_and_expanding_squares extends PApplet {

int default_radius = 750;
int current_iteration = 1;
int default_square_size = 30;
int step_size = 10;
PVector[] locations_by_degree = new PVector[360]; 


public void setup() {
  
  background(50);
  translate(width/2, height/2);
  rectMode(RADIUS);
  
  for (int i = 0; i < 360; i += step_size) {
    //float theta = map(i, 0, 360, -PI, PI);
    float theta = radians(i);
    float sin_theta = sin(theta);
    float cos_theta = cos(theta);
    
    int x = PApplet.parseInt(default_radius * sin_theta);
    int y = PApplet.parseInt(default_radius * cos_theta);
    int z = -PApplet.parseInt(i);
    locations_by_degree[i] = new PVector(x, y, z);
  }

  frameRate(60);
}

public void draw() {
  clear();
  background(50);
  translate(width/2, height/2);
     
  for (int i = 0; i < 360; i += step_size) {
        
    PVector pv = locations_by_degree[i];
                    
    pushMatrix();
    translate(pv.x, pv.y);
    rotate(radians(pv.z + frameCount));
    fill(0);
    rect(0,0, default_square_size * sin(radians(pv.z + frameCount)), default_square_size * sin(radians(pv.z+frameCount)));
    popMatrix();
  }
  
  print(mouseX, mouseY, "\n");
}
  public void settings() {  size(2000, 2000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "circle_of_rotating_and_expanding_squares" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
