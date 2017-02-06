class PowerUp extends GameObject implements Entity {
  
  PowerUp(PVector groundPosition, PVector temp, float size, int timeToLive) {
    id = POWERUP;
    this.pos = temp;
    this.velocity = new PVector(0, 0);
    this.size = size;
    this.timeToLive = timeToLive;  

    this.groundPosition = groundPosition;
  }

  void render() {
  }

  void update() {
    
    gravity();
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