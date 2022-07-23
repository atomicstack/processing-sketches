public void settings() {
    size(640, 640, P3D);
}

int HUE_MAX = 240;
int MID_Y;
int MID_X;
int DIVISOR = 20;
int NUM_ECHOES = 360 / DIVISOR;

void setup() {
    colorMode(HSB, HUE_MAX, 1, 1, NUM_ECHOES);
    MID_Y = height/2;
    MID_X  = width/2;
    frameRate(60);
}


void draw() {
    clear();

    pushMatrix();
    translate(MID_X, MID_Y);
    fill(0, 0, 0, 0);

    // int rotation_degrees = mouseX % 360;
    float rotation_degrees = radians(frameCount * 30.0);

    for (int i = 0; i < NUM_ECHOES; i++) {
        pushMatrix();
        // int rotation_degrees = i * DIVISOR;
        rotateY(radians(rotation_degrees - ( i * 10 ) ));
        float this_alpha = map(sin(i), -1, 1, 2, NUM_ECHOES);
        stroke(frameCount % HUE_MAX, 1, 1, this_alpha);
        strokeWeight(5);
        circle(0,0, height/2);
        popMatrix();
    }

    popMatrix();
}
