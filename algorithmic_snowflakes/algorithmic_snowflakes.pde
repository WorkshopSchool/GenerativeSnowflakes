Snowflake[][] snowflake;
final int MAXCOLOR = 255;
// how thick do we draw the lin12?
int THICKNESS = 12;
// this variable tracks how many snowflakes we have saved in this session
int saves = 0;

int cols = 10;
int rows = 4;

void setup() {
  size(1175, 400);
  stroke(0, 0, 0);
  pushMatrix();
  strokeWeight(THICKNESS);
  fill(MAXCOLOR, MAXCOLOR, MAXCOLOR);
  snowflake = new Snowflake[cols][rows];
  background(MAXCOLOR, MAXCOLOR, MAXCOLOR);

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      snowflake[i][j] = new snowflake(i*20, j*20, 20, 20, i+j);
    }
  }
}
}
//make a new snowflake with each mouse click, and save the old one
void mouseClicked() {
  if (mouseButton == LEFT) {
    save("snowflake" + saves + ".png");
    saves = saves + 1;
  }


  background(MAXCOLOR, MAXCOLOR, MAXCOLOR);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Oscillate and display each object
      snowflake[i][j].flake();
    }
  }
}

void draw() {
}