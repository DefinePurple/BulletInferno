class Gun extends GameObject {
  float shoot;
  int numBullets;
  float startingTheta, incTheta, offsetTheta, NEW_PI;
  int swap;

  Gun() {
    id = 4;
    readFile();
  }

  void render() {
  }

  void update() {
    shoot += timeDelta;
    if (shoot  >= 0.5) {
      for (int i = -numBullets/2; i <= numBullets/2; i++) {
        Bullet b = new Bullet(pos.x, pos.y, startingTheta + offsetTheta*i, 9, 8); 
        gameObjects.add(b);
      }
      startingTheta += incTheta;
      if ((startingTheta >= PI + PI/3 || startingTheta <= PI - PI/3) && swap != 1)
        incTheta *= -1;

      shoot = 0;
    }
  }

  void readFile() {
    swap = 1;
    if (swap == 1) {
      NEW_PI = PI + HALF_PI;
      this.startingTheta = 0;
      this.pos = new PVector(width/2, height * 0.45f);
    } else {
      NEW_PI = PI - (HALF_PI);
      this.startingTheta = PI;
      this.pos = new PVector(width/2, height * 0.1f);
    }
    this.numBullets = 50;
    
    this.incTheta = NEW_PI/numBullets*2;
    this.offsetTheta = NEW_PI/(numBullets+1);
  }
}