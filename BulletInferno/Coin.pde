class Coin extends GameObject {
  float alive;
  float timeToLive;

  Coin() {
    id = 5;
    pos = new PVector(width/2, height * 0.3f);
    velocity = new PVector(0, 0);
    size = 20;
    timeToLive = 5;

    for (int i = gameObjects.size() -1; i >= 0; i --) {
      GameObject go = gameObjects.get(i); 
      if (go.id == 0) {
        this.gHeight = go.gHeight;
        this.gWidth = go.gWidth;
      }
    }
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
      gravity = 20.5f;
      velocity.y += gravity;
    } else { 
      velocity.y = 0;
      pos.y = height - gHeight - size/2;
    }
  }
}