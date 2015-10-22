int low = 200;
int high = 800;
int delta = -1;
color c1 = color(255, 0, 0);
color c2 = color(0, 255, 0);
color c3 = color(0, 0, 255);
color c4 = color(255, 165, 0);

void setup() {
  size(1000, 1000);
  noFill();
}

void draw() {
  if (low >= 800 || high >= 800) delta *= -1;

  background(200);
  circles(low+=delta,  500,         300, c1);
  circles(high-=delta, 500,         300, c2);
  circles(500,         low+=delta,  300, c3);
  circles(500,         high-=delta, 300, c4);
}

void circles(int x, int y, int outsideDiameter) {
  circles(x,y,outsideDiameter,color(0));
}

void circles(int x, int y, int outsideDiameter, color c) {
  stroke(c);
  for(int i = 0; i<outsideDiameter; i+=7) {
    ellipse(x, y, outsideDiameter - i, outsideDiameter - i);
  }
}