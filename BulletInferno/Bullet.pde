class Bullet extends GameObject{
  float theta;
  float speed;
  float timeToLive;
  float alive;
  float bulletSize;
  PShape body;
  
  color colour;

  Bullet(float x, float y, float theta, float size, float timeToLive, float speed, color colour) {
    this.id = 2;
    this.pos = new PVector(x, y);
    this.forward = new PVector(0, 1);
    this.theta = theta;
    this.bulletSize = size;
    this.timeToLive = timeToLive;    
    this.alive = 0;
    this.size = bulletSize * 2;
    this.speed = speed;
    this.colour = colour;
    create();
  }
  
  //Create the shape of the bullet
  void create() {
    body = createShape();
    body.beginShape();
    body.stroke(colour);
    body.fill(colour);
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
    //Rotate the bullet to face in the right direction
    forward.x = sin(theta);
    forward.y = - cos(theta);
  
    //Moves the bullet by its speed and in the direction of forward
    pos.add(PVector.mult(PVector.mult(forward, speed), timeDelta));
    //If the bullet goes offscreen, Kill it.
    
    sideCollision();
    
    //If the bullet is alive for long enough or it hits ground, kill it
    alive += timeDelta;
    if (alive > timeToLive || edgeCollision(pos, size))
      this.dead = true;
  }
  
  void sideCollision(){
    if ((pos.x > width) || (pos.y > height) || (pos.y < 0) || pos.x < 0)
      this.dead = true;
  }
}