class Player extends GameObject {
  float radius;
  
  PShape shape;
  char up, down, left, right;

  PVector force;
  float power;

  // Make different keys control the ship!
  Player(float x, float y, float size, char up, char down, char left, char right) {
    id = 1;
    pos = new PVector(x, y);
    forward = new PVector(-1, 0);
    accel = new PVector(0, 0);
    velocity = new PVector(0, 0);
    force = new PVector(0, 0);
    this.size = size;
    radius = size / 2;

    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
    create();

    power = 350;
    for (int i = gameObjects.size() -1; i >= 0; i --) {
      GameObject go = gameObjects.get(i); 
      if (go.id == 0) {
        this.gHeight = go.gHeight;
        this.gWidth = go.gWidth;
      }
    }
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
    int counter = 0;
    
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

    if (bulletCollision(pos, size))
      this.dead = true;
  }

  void gravity() {
    if (!groundCollision(pos, size)) {
      gravity = 20.5f;
      velocity.y += gravity;
    } else { 
      velocity.y = 0;
      pos.y = height - gHeight - size/2;
    }
  }

  void sideCollision() {
    if (pos.x - size/2 < 0)
      pos.x = size/2;

    if (pos.x + size/2 > width)
      pos.x = width - size/2;
  }
}