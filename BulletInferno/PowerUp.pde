class PowerUp extends GameObject implements Entity {
  float alive;
  PShape shape;

  PowerUp(PVector groundPosition, PVector temp, float size, int timeToLive) {
    id = POWERUP;
    this.pos = temp;
    this.velocity = new PVector(0, 0);
    this.size = size;
    this.timeToLive = timeToLive;  

    this.groundPosition = groundPosition;
    create();
  }
  
  //Creates the body of the powerup
  void create() {
    shape = createShape(TRIANGLE, 0, -size/2, -size/2, size/2, size/2, size/2);
    shape.setFill(color(208,62,25));
  }
  
  void render() {
    pushMatrix(); // Stores the current transform
    translate(pos.x, pos.y);
    shape(shape, 0, 0);
    popMatrix(); // Restore the transform
  }


  void update() {
    gravity();

    pos.add(PVector.mult(velocity, timeDelta));  
    
    //Counter for when to die
    alive += timeDelta;
    if (alive > timeToLive)//if time is up, kill it
      this.dead = true;
    
    //if it collides with the player, kill it
    if (centerCollision(pos, size, PLAYER)) {
      this.dead = true;
    }
  }

  //Apply gravity to the player
  void gravity() {
    if (!edgeCollision(pos, size)) {
      velocity.y += gravity;
    } else { 
      velocity.y = 0;
      pos.y = groundPosition.y - size/2;
    }
  }
}