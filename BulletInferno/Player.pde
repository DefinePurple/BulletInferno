class Player extends GameObject {
  float radius;
  PShape shape;
  char up, left, right, run;
  PVector force;
  float power;
  float jumpPower;
  boolean shield;
  float shieldTime;

  Player(float x, float y, float size, char up, char left, char right, char run, PVector groundPosition) {
    super();
    this.id = 1;
    this.pos = new PVector(x, y);
    this.velocity = new PVector(0, 0);
    this.force = new PVector(0, 0);
    this.size = size;
    this.radius = size / 2;
    this.timeToLive = 7;
    this.left = left;
    this.right = right;
    this.up = up;
    this.run = run;
    create();

    this.groundPosition = groundPosition;
    this.power = (width + height) * 0.3f;
    this.jumpPower = size * 25;
  }

  void create() {
    shape = createShape(RECT, -(size/2), -(size/2), size, size);
    shape.setFill(color(255, 238, 0));
    shape.setStroke(color(255, 238, 0));
  }

  void render() { // Overrides the method in the base class
    pushMatrix(); // Stores the current transform
    translate(pos.x, pos.y);
    shape(shape, 0, 0);
    if(shield){
      fill(color(255, 238, 0), 100);
      ellipse(0,0, size*2,size*2);
    }
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

    if (centerCollision(pos, size, POWERUP))
      shield = true;

    if (centerCollision(pos, size, BULLET) && !shield)
      this.dead = true;

    if (shield)
      shieldTime += timeDelta;
      if (shieldTime > timeToLive){
        shield = false;
        shieldTime = 0; 
      }
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

    if (pos.y - size/2 <= 0)
      pos.y = size/2;
  }
}