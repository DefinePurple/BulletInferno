class Coin extends GameObject implements Entity {
  float alive;
  PShape shape;

  Coin(PVector groundPosition, PVector temp, float size, int timeToLive) {
    super();
    this.id = 3;
    this.pos = temp;
    this.velocity = new PVector(0, 0);
    this.size = size;
    this.timeToLive = timeToLive;  

    this.groundPosition = groundPosition;
    create();
  }

  //Creates the body of the bullet
  void create() {
    shape = createShape(GROUP);
    PShape body = createShape(ELLIPSE, 0, 0, size, size);
    body.setFill(color(222, 104, 93));
    body.setStroke(color(222, 104, 93));

    PShape inner = createShape(ARC, 0, 0, size * 0.5f, size * 0.5f, PI - HALF_PI - QUARTER_PI - QUARTER_PI/3, TWO_PI - QUARTER_PI + QUARTER_PI/3);
    inner.setFill(false);
    inner.setStroke(true);
    inner.setStroke(color(120, 51, 40));

    //Adds shapes to the 'shape' shape
    shape.addChild(body);
    shape.addChild(inner);
  }

  void render() {
    pushMatrix(); // Stores the current transform
    translate(pos.x, pos.y);
    shape(shape, 0, 0);
    popMatrix(); // Restore the transform
  }

  void update() {
    gravity();

    //Adds the velocity to the position of the coin
    pos.add(PVector.mult(velocity, timeDelta));  

    //increases the alive counter by the timeDelta
    alive += timeDelta;
    if (alive > timeToLive) //If its time is up, kill it
      this.dead = true;

    //Checks if it collided with the player
    if (centerCollision(pos, size, PLAYER)) {
      score.addScore(); //Adds to the score
      this.dead = true;
    }
  }

  //If the player isn't touching the ground, apply gravity
  void gravity() {
    if (!edgeCollision(pos, size)) {
      velocity.y += gravity;
    } else { 
      velocity.y = 0;
      pos.y = groundPosition.y - size/2;
    }
  }
}