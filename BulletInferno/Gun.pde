class Gun extends GameObject {
  float shoot;
  int numBullets = 100;
  float startingTheta = PI; 

  Gun() {
    id = 4;
  }

  void render() {
  }

  void update() {
    shoot += timeDelta;
    if (shoot  >= 0.5) {
      Bullet b = new Bullet(width/2, height * 0.1f, startingTheta, 9, 8); 
      gameObjects.add(b);
      shoot = 0;
    }
  }
}