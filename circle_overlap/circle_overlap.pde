ArrayList<Circle> circles = new ArrayList<Circle>();
int shapeToMove = 0;
int numIntersections = 0;

class Circle {
  protected int x, y;
  protected int radius;
  int num;
  color c = color(255, 255, 255, 35);
  color red = color(255, 0, 0);
  color black = color(0, 0, 0);
  PShape shape;

  Circle(int num, int x, int y, int radius) {
    this.num = num;
    this.radius = radius;
    setPosition(x, y);
    shape = createShape(ELLIPSE, 0, 0, radius*2, radius*2);
  }

  void setPosition(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void draw() {
    shape.setFill(c);
    shape(shape, x, y);
    fill(0, 0, 0);
    text(num, x-5, y+5);
  }

  void drawIntersection(Circle o) {
    float d = dist(x, y, o.x, o.y);
    fill(red);
    noStroke();
    float threshold = 0.5;

    if (d < threshold) {
      drawInfiniteOverlap(o);
      return;
    } else shape.setStroke(black);

    if (abs(d-radius-o.radius) < threshold) drawSinglePointOverlap(o);
    else if (d < (radius+o.radius-threshold)) drawTwoPointOverlap(d, o); 
  }

  void drawInfiniteOverlap(Circle o) {
    shape.setStroke(red);
    o.shape.setStroke(red);
    numIntersections-=7;
  }

  void drawSinglePointOverlap(Circle o) {
    // TODO support different size circles for midpoint
    int mpX = (x+o.x)/2;
    int mpY = (y+o.y)/2;
    ellipse(mpX, mpY, 6, 6);
    numIntersections++;
  }

  void drawTwoPointOverlap(float d, Circle o) {
    // see: http://www.ambrsoft.com/TrigoCalc/Circles2/circle2intersection/CircleCircleIntersection.htm
    float a1 = d + radius + o.radius;
    float a2 = d + radius - o.radius;
    float a3 = d - radius + o.radius;
    float a4 = -d + radius + o.radius;

    float area = sqrt(a1*a2*a3*a4)/4;

    float val1 = (x + o.x)/2 + (o.x - x) * (sq(radius)-sq(o.radius))/(2*d);
    float val2 = 2*(y-o.y)*area/sq(d);

    float x1 = val1 + val2;
    float x2 = val1 - val2;

    val1 = (y + o.y)/2 + (o.y - y) * (sq(radius)-sq(o.radius))/(2*d);
    val2 = 2*(x-o.x)*area/sq(d);

    float y1 = val1 - val2;
    float y2 = val1 + val2;

    ellipse(x1, y1, 6, 6);
    ellipse(x2, y2, 6, 6);
    numIntersections+=2;
  }

  boolean pointInside(int x1, int y1) {
    return dist(x, y, x1, y1)<radius;
  }
}

void setup() {
  size(800, 700);
  circles.add(new Circle(1, 150, 300, 100));
  circles.add(new Circle(2, 400, 300, 100));
  circles.add(new Circle(3, 650, 300, 100));
  textSize(20);
}

void draw() {
  clear();
  background(200);
  fill(0, 0, 0);
  stroke(0, 0, 0);

  for (int i = 0; i<circles.size(); i++) {
    Circle c = circles.get(i);
    c.draw();
    int intersectIndex = i < circles.size()-1 ? i+1 : 0;
    c.drawIntersection(circles.get(intersectIndex));
  }

  if (mousePressed) {
    if (shapeToMove != -1) {
      circles.get(shapeToMove).setPosition(mouseX, mouseY);
    }
  }

  fill(0, 0, 0);
  String intersections = "" + numIntersections;
  if (numIntersections < 0) intersections = "∞";
  text("number of intersections: " + intersections, 50, 650);
  numIntersections=0;
}

void mousePressed() {
  // still pressing same circle
  if (circles.get(shapeToMove).pointInside(mouseX, mouseY)) return;
  
  // check for other circles
  shapeToMove = -1;
  for (int i = 0; i<circles.size(); i++) {
    if (circles.get(i).pointInside(mouseX, mouseY)) {
      shapeToMove = i;
    }
  }
}
