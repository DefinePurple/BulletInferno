class Coin extends GameObject {
  float alive;
  float timeToLive;
  PVector groundPosition;
  
  Coin(PVector groundPosition, PVector temp, int size, int timeToLive) {
    super();
    this.id = 5;
    this.pos = temp;
    this.velocity = new PVector(0, 0);
    this.size = size;
    this.timeToLive = timeToLive;  
    
    this.groundPosition = groundPosition;
  }

  void render() {  
    ellipse(pos.x, pos.y, size, size);
  }

  void update() {
    gravity();

    pos.add(PVector.mult(velocity, timeDelta));  

    alive += timeDelta;
    if (alive > timeToLive)
      this.dead = true;

    if (centerCollision(pos, size, 1)) {
      this.dead = true;
      score.addScore();
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