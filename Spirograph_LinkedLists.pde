Circle parent;
Circle lastChild;

int steps = 20;

ArrayList<PVector> path;

void setup() {
  size(800, 800);
 // fullScreen();
  path = new ArrayList<>();

  parent = new Circle(0, 0, 400, 0, null);
  Circle current = parent;
  for (int i= 0; i<10; i++) {
    current = current.addChild();
  }
  lastChild = current;
}

void draw() {
  translate(width/2, height/2);
  background(0);
  stroke(255, 100);
  noFill();

  for (int i = 0; i<steps; i++) {
    Circle current = parent;
    while (current!=null) {
      current.display();
      current.update();
      current = current.child;
    }
    path.add(new PVector(lastChild.x, lastChild.y));
  }

  beginShape();
  stroke(255, 128, 128);
  strokeWeight(2);
  for (int i = 0; i<path.size(); i++) {
    vertex(path.get(i).x, path.get(i).y);
  }
  endShape();
}


class Circle {
  float x;
  float y;
  float size;
  Circle parent;
  Circle child;
  float angle;
  float speed;
  int lvl;

  Circle(float x1, float y1, float d, int l, Circle p) {
    x = x1;
    y = y1;
    size = d;
    parent = p;
    angle = -PI/2;
    child = null;
    lvl = l;
    speed = radians(pow(-4, lvl-1))/steps;//change this var to get different shapes
  }

  Circle addChild() {
    float newSize = size/3;
    float newX = x + size/2 +newSize/2;
    float newY = y ;

    child = new Circle(newX, newY, newSize, lvl+1, this);
    return child;
  }

  void update() {
    angle+= speed;
    if (parent!=null) {
      x = parent.x + (size/2 + parent.size/2)*cos(angle);
      y = parent.y + (size/2 + parent.size/2)*sin(angle);
    }
  }
  void display() {
    strokeWeight(1);
    stroke(255, 10);
    ellipse(x, y, size, size);
  }
}
