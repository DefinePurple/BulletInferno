class Multiplier extends GameObject implements Entity {
  float alive;

  Multiplier(PVector groundPosition, PVector temp, float size, int timeToLive) {
    super();
    this.id = 3;
    this.pos = temp;
    this.velocity = new PVector(0, 0);
    this.timeToLive = timeToLive;  
    this.size = size;

    this.groundPosition = groundPosition;
  }

  void render() {  
    textAlign(CENTER);
    textSize(textSize);
    fill(204, 155, 8);
    text(score.multiplier + 1 + "x", pos.x, pos.y);
  }

  void update() {
    gravity();

    //Adds the velocity to the position of the multiplier
    pos.add(PVector.mult(velocity, timeDelta));  

    //increases the alive counter by the timeDelta
    alive += timeDelta;
    if (alive > timeToLive)//If its time is up, kill it
      this.dead = true;

    //Checks if it collided with the player
    if (centerCollision(pos, size, PLAYER)) {
      score.increaseMultiplier();
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