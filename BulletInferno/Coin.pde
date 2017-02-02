class Coin extends GameObject implements Item {
  float alive;
  float timeToLive;
  PVector groundPosition;
  
  Coin(PVector groundPosition, PVector temp, float size, int timeToLive) {
    super();
    this.id = 3;
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

    if (centerCollision(pos, size, PLAYER)) {
      score.addScore();
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