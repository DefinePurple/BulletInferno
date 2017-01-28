class Bullet extends GameObject {
  float theta;
  float speed;
  float timeToLive;
  float alive;
  float bulletSize;
  PShape body;

  Bullet(float x, float y, float theta, float size, float timeToLive, float speed) {
    this.id = 2;
    this.pos = new PVector(x, y);
    this.forward = new PVector(0, 1);
    this.theta = theta;
    this.bulletSize = size;
    this.timeToLive = timeToLive;    
    this.alive = 0;
    this.size = bulletSize * 2;
    this.speed = speed;
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
    rotate(theta);
    shape(body);
    popMatrix();
  }

  void update() {
    forward.x = sin(theta);
    forward.y = - cos(theta);

    pos.add(PVector.mult(PVector.mult(forward, speed), timeDelta));
    if ((pos.x > width) || (pos.y > height) || (pos.y < 0) || pos.x < 0)
      this.dead = true;

    alive += timeDelta;
    if (alive > timeToLive || edgeCollision(pos, size))
      this.dead = true;
  }
}