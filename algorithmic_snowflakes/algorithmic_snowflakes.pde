Snowflake[][] snowflake;
final int MAXCOLOR = 255;
// how thick do we draw the lin12?
int THICKNESS = 6;
// this variable tracks how many snowflakes we have saved in this session
int saves = 0;

int cols = 7;
int rows = 4;

void setup() {
  size(1890, 1200);
  frameRate(6);
  stroke(0, 0, 0);
  strokeWeight(THICKNESS);
  fill(MAXCOLOR, MAXCOLOR, MAXCOLOR);
  snowflake = new Snowflake[cols][rows];
  background(MAXCOLOR, MAXCOLOR, MAXCOLOR);

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      snowflake[i][j] = new Snowflake(i, j);
    }
  }
}

void draw() {
  translate(150, 150);
}

class Snowflake {

  float x, y;
  // degrees in a circle
  int CIRCLE = 360;
  // how many branches do the snowflakes have?
  int NBRANCHES = 6;
  // how big are the snowflakes, in pixels?
  int SIZE = 85;
  // how many levels of branches do our snowflakes have?
  int DEPTH = 3;
  // how thick do we draw the lin12?
  int THICKNESS = 6;
  // these arrays hold the randomized parameters for the snowflakes
  float[] fractions = new float[DEPTH];
  int[] angles = new int[DEPTH];

  Snowflake(float tempX, float tempY) {
    x= tempX;
    y= tempY;
  }


  void flake() {
    rotate(radians(-90));
    //generate three random branch positions and three random angles
    for (int i = 0; i<DEPTH; i++) {  
      // branch off at halfway, plus or minus a quarter of the way
      fractions[i] = 0.5 + 0.25*(random(1) - random(1));
      // branch off at 60 degrees, plus or minus 40 degrees
      angles[i] = int(60 + random(40) - random(40));
    }
    //six times, create a branch and then rotate the canvas 60 degrees
    for (int i = 0; i<NBRANCHES; i++) {
      branch(SIZE, 0);
      rotate(radians(CIRCLE/NBRANCHES));
    }
    //draw the eyelet at the top

    ellipse(0, 0, 0.25*SIZE, 0.25*SIZE);
    ellipse(x+SIZE, 0, 0.25*SIZE, 0.25*SIZE);
  }
  //this function creates one of the six branches
  void branch(int size, int depth) {
    if (depth<DEPTH) {
      line(0, 0, size, 0);
      //each recursive branch calls "branch" four times until DEPTH is reached
      branch(int(fractions[depth]*size), depth+1);
      //the matrix stack is an important concept in Processing
      //pushMatrix is like bookmarking the canvas, and popMatrix rolls it back
      pushMatrix();
      translate(fractions[depth]*size, 0);
      branch(int(fractions[depth]*size), depth+1);
      pushMatrix();
      rotate(radians(-angles[depth]));
      branch(int(fractions[depth]*size), depth+1);
      popMatrix();
      pushMatrix();
      rotate(radians(angles[depth]));
      branch(int(fractions[depth]*size), depth+1);
      popMatrix();
      popMatrix();
    }
  }
}

//make a new snowflake with each mouse click, and save the old one
void mouseClicked() {
  background(MAXCOLOR, MAXCOLOR, MAXCOLOR);
  if (mouseButton == LEFT) {
    for (int i = 0; i < cols; i++) {    
      for (int j = 0; j < rows; j++) {
        //display each object
        pushMatrix();
        translate(i*250, j*250);

        snowflake[i][j].flake();
        popMatrix();
      }
    }
    save("snowflake" + saves + ".png");
    saves = saves + 1;
  }
}