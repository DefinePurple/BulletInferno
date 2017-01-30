class Multiplier extends GameObject {
  float alive;
  float timeToLive;
  PVector groundPosition;
  
  Multiplier(PVector groundPosition, PVector temp, int timeToLive) {
    super();
    this.id = 3;
    this.pos = temp;
    this.velocity = new PVector(0, 0);
    this.timeToLive = timeToLive;  
    
    this.groundPosition = groundPosition;
  }

  void render() {  
    text(score.multiplier + 1 + "x" ,pos.x, pos.y);
  }

  void update() {
    gravity();

    pos.add(PVector.mult(velocity, timeDelta));  

    alive += timeDelta;
    if (alive > timeToLive)
      this.dead = true;

    if (centerCollision(pos, size, PLAYER)) {
      score.increaseMultiplier();
      this.dead = true;
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
}