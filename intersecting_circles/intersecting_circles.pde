int width = 1440;
int height = 1440;
int diameter = height/2;
int low = diameter/2;
int high = width-low+1;
int delta = 1;

color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);
color orange = color(255, 165, 0);

void setup() {
  size(1440, 1440);
  noFill();
}

void draw() {
  int max = width - height/8;
  if (low >= max || high >= max) delta *= -1;

  background(200);
  circles(low+=delta,  height/2,    diameter, red);
  circles(high-=delta, height/2,    diameter, green);
  circles(height/2,    low+=delta,  diameter, blue);
  circles(height/2,    high-=delta, diameter, orange);
}

void circles(int x, int y, int outsideDiameter) {
  circles(x, y, outsideDiameter, color(0));
}

void circles(int x, int y, int outsideDiameter, color c) {
  stroke(c);
  for (int i = 0; i<outsideDiameter; i+=10) {
    ellipse(x, y, outsideDiameter - i, outsideDiameter - i);
  }
}
