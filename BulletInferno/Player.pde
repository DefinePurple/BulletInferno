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
    super();//Gets the parents constructors
    this.id = 1;
    this.pos = new PVector(x, y);
    this.velocity = new PVector(0, 0);
    this.force = new PVector(0, 0);

    //sizes for determining player size
    this.size = size;
    this.radius = size / 2;

    this.timeToLive = 7;//How long the shield will live

    //Controls
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
    if (shield) {
      fill(color(255, 238, 0), 100);
      ellipse(0, 0, size*2, size*2);
    }
    popMatrix(); // Restore the transform
  }

  void update() {
    velocity.x = 0;//set horizontal velocity to 0
    float runMultiplier = 1; //run multiplier is used to determine run speed

    if (checkKey(run))//if running, run
      runMultiplier = 1.5f;

    if (checkKey(left))//if moving left, set horizontal velocity to power and if you're running increase power
      velocity.x = -power * runMultiplier;

    if (checkKey(right))//if moving right, set horizontal velocity to power and if you're running increase power
      velocity.x = power * runMultiplier;

    gravity();
    sideCollision();

    //Checks if the player can jump. Jump cuts off at a certain height
    if (checkKey(up) && pos.y - height * 0.1f > 0)
      velocity.y = -jumpPower;

    pos.add(PVector.mult(velocity, timeDelta));

    //Checks if the player picked up a shield
    if (centerCollision(pos, size, POWERUP)) {
      shield = true;
      shieldTime = 0;
    }

    //If the player collides with a bullet he dies but not if he's shielded
    if (centerCollision(pos, size, BULLET) && !shield)
      this.dead = true;

    //Start timer for shield to determine when it dies
    if (shield)
      shieldTime += timeDelta;
    if (shieldTime > timeToLive) {
      shield = false;
      shieldTime = 0;
    }
  }

  //Applies gravity to the player
  void gravity() {
    if (!edgeCollision(pos, size)) {
      velocity.y += gravity;
    } else { 
      velocity.y = 0;
      pos.y = groundPosition.y - size/2;
    }
  }


  //Checks if the player is against a wall
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