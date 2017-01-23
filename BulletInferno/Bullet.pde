class Bullet extends GameObject {
  float theta;
  float speed;
  float timeToLive;
  float alive;
  float bulletSize;
  PShape body;

  Bullet(float x, float y, float theta, float size, float timeToLive) {
    id = 3;
    pos = new PVector(x, y);
    forward = new PVector(0, 1);
    this.theta = theta;
    this.bulletSize = size;
    this.timeToLive = timeToLive;    
    this.alive = 0;
    this.size = bulletSize * 2;
    speed = 300;
    create();
  }

  void create() {
    body = createShape();
    body.beginShape();
    body.stroke(255, 255, 0);
    body.noFill();
    body.strokeWeight(2);
    body.vertex(0, -bulletSize);
    body.vertex(-bulletSize/2, bulletSize / 3);
    body.vertex(0, bulletSize);
    body.vertex(bulletSize/2, bulletSize/3);
    body.endShape(CLOSE);
  }


  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    ellipse(0,0, size, size);
    rotate(theta);
    shape(body);
    popMatrix();
  }

  void update() { // Overrides the method in the base class
    forward.x = sin(theta);
    forward.y = - cos(theta);

    pos.add(PVector.mult(PVector.mult(forward, speed), timeDelta));
    if ((pos.x > width) || (pos.x < 0) || (pos.y > height) || (pos.y < 0))
      gameObjects.remove(this);

    alive += timeDelta;
    if (alive > timeToLive || groundCollision(pos, size))
      gameObjects.remove(this);
  }
}