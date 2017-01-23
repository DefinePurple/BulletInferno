class Gun extends GameObject {
  float shoot;
  int numBullets;
  float startingTheta, incTheta, offsetTheta, NEW_PI; 
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
        Bullet b = new Bullet(width/2, height * 0.1f, startingTheta + offsetTheta*i, 9, 8); 
        gameObjects.add(b);
      }
      startingTheta += incTheta;
      if (startingTheta >= PI + PI/3 || startingTheta <= PI - PI/3)
        incTheta *= -1;
        
      shoot = 0;
    }
  }

  void readFile() {
    NEW_PI = PI - (HALF_PI);
    this.pos = new PVector(width/2, height*0.1f);
    this.numBullets = 10;
    this.startingTheta = PI;
    this.incTheta = NEW_PI/(numBullets+1);
    this.offsetTheta = NEW_PI/numBullets;
  }
}