int default_radius = 400;
int current_iteration = 1;

void setup() {
  size(2000, 2000);
  background(255);
  //frameRate(3);
}

void draw() {
  //pushMatrix();
  //translate(width/2, height/2);
  //rect(-25, -25, 50, 50);
  //popMatrix();

  // set (0,0) to middle of canvas
  translate(width/2, height/2);
  
  int radius = default_radius;
  int current_square = 1;
  
  for (int i = 0; i < 180; i += 10) {
    //print(
    //  "i=" + i
    //  + ", " +
    //  "sin(i)=" + sin(i)
    //  + ", " +
    //  "cos(i)=" + cos(i)
    //  + "\n"
    //);
    
    //x = r × cos( θ )
    //y = r × sin( θ )
         
    int x = int(radius * cos(i + current_iteration));
    int y = int(radius * sin(i + current_iteration));
    pushMatrix();
    translate(x, y);
    //int square_size = int(random(80)) + 20;
    int square_size = int(i / 2);
    rect(x, y, square_size/2, square_size/2);
    fill(0);
    popMatrix();

    if (current_square % current_iteration == 0) {
      //String[] progression_info = new String[3];
      //progression_info[0] = "current_iteration="+str(current_iteration);
      //progression_info[1] = "current_square="+str(current_square);
      //progression_info[2] = "mod_result==0";
      //println(join(progression_info, ","));
      break;
    }

    current_square++;
    radius -= 24;
  }
       
  current_iteration++;
  
  if (current_iteration % 45 == 0) {
    clear();
    background(255);
    current_iteration = 1;
  }
}

//void draw() {
//  clear();
//  background(255);
    
  
//}
