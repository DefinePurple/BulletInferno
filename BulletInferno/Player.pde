class Player extends GameObject {
  float radius;
  PVector groundPosition;
  PShape shape;
  char up, down, left, right, run;

  PVector force;
  float power;
  float jumpPower;

  Player(float x, float y, float size, char up, char down, char left, char right, char run, PVector groundPosition) {
    super();
    this.id = 1;
    this.pos = new PVector(x, y);
    this.velocity = new PVector(0, 0);
    this.force = new PVector(0, 0);
    this.size = size;
    this.radius = size / 2;

    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
    this.run = run;
    create();

    this.groundPosition = groundPosition;
    this.power = (width + height) * 0.3f;
    this.jumpPower = size * 20;
  }

  void create() {
    shape = createShape(RECT, -(size/2), -(size/2), size, size);
    shape.setFill(color(255,238,0));
    shape.setStroke(color(255,238,0));
  }

  void render() { // Overrides the method in the base class
    pushMatrix(); // Stores the current transform
    translate(pos.x, pos.y);
    shape(shape, 0, 0);
    popMatrix(); // Restore the transform
    //info();
  }

  void info() {
    textSize(12);
    textAlign(LEFT, BOTTOM);
    pushMatrix();
    translate(5, 40);
    text("X: " + pos.x + "     Y: " + pos.y, 0, 12);
    text("Vertical: " + velocity.y, 0, 32);
    text("Horizontl: " + velocity.x, 0, 52);

    if (checkKey(left))
      text("Left: true", 0, 72);
    else text("Left: false", 0, 72);

    if (checkKey(right))
      text("Right: true", 0, 92);
    else text("Right:  false", 0, 92);

    if (checkKey(up))
      text("Jump: true", 0, 112);
    else text("Jump:  false", 0, 112);

    text("Time delta: " + timeDelta, 0, 132);
    textSize(20);
    popMatrix();
  }

  void update() {
    velocity.x = 0;
    float runMultiplier = 1;
    
    if (checkKey(run))
      runMultiplier = 1.5f;

    if (checkKey(left))
      velocity.x = -power * runMultiplier;

    if (checkKey(right))
      velocity.x = power * runMultiplier;

    gravity();
    sideCollision();

    if (checkKey(up) && pos.y - height * 0.1f > 0)
      velocity.y = -jumpPower;

    pos.add(PVector.mult(velocity, timeDelta));

    if (centerCollision(pos, size, BULLET))
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
    if (pos.x - size/2 <= 0) {
      pos.x = size/2;
      if (checkKey(left))
        velocity.x = 0;
    }

    if (pos.x + size/2 >= width) {
      pos.x = width - size/2;
      if (checkKey(right))
        velocity.x = 0;
    }
    
    if(pos.y - size/2 <= 0)
      pos.y = size/2;
  }
}