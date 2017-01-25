class Player extends GameObject {
  float radius;
  PVector groundPosition;
  PShape shape;
  char up, down, left, right;

  PVector force;
  float power;

  // Make different keys control the ship!
  Player(float x, float y, float size, char up, char down, char left, char right, PVector groundPosition) {
    this.id = 1;
    this.pos = new PVector(x, y);
    this.forward = new PVector(-1, 0);
    this.velocity = new PVector(0, 0);
    this.force = new PVector(0, 0);
    this.size = size;
    this.radius = size / 2;

    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
    create();

    this.groundPosition = groundPosition;
    this.power = 350;
  }

  void create() {
    shape = createShape(RECT, -(size/2), -(size/2), size, size);
  }

  void render() { // Overrides the method in the base class
    pushMatrix(); // Stores the current transform
    translate(pos.x, pos.y);
    shape(shape, 0, 0);
    stroke(0);
    ellipse(0, 0, size, size);
    popMatrix(); // Restore the transform
    info();
  }

  void info() {
    textSize(12);
    text("X: " + pos.x + "     Y: " + pos.y, 5, 12);
    text("Vertical: " + velocity.y, 5, 32);
    text("Horizontl: " + velocity.x, 5, 52);
    
    if (checkKey(left))
      text("Left: true", 5, 72);
    else text("Left: false", 5, 72);
    
    if (checkKey(right))
      text("Right: true", 5, 92);
    else text("Right:  false", 5, 92);

    if (checkKey(up))
      text("Jump: true", 5, 112);
    else text("Jump:  false", 5, 112);
    
    text("Time delta: " + timeDelta, 5, 132);
  }

  void update() {
    velocity.x = 0;

    if (checkKey(left))
      velocity.x = -power;

    if (checkKey(right))
      velocity.x = power;

    gravity();
    sideCollision();

    if (checkKey(up) && pos.y - 125 > 0)
      velocity.y = -power;

    pos.add(PVector.mult(velocity, timeDelta));

    if (centerCollision(pos, size, 3))
      this.dead = true;
  }

  void gravity() {
    if (!edgeCollision(pos, size)) {
      velocity.y += gravity;
    } else { 
      velocity.y = 0;
      pos.y = groundPosition.y - size/2;
    }
  }

  void sideCollision() {
    if (pos.x - size/2 < 0)
      pos.x = size/2;

    if (pos.x + size/2 > width)
      pos.x = width - size/2;
  }
}