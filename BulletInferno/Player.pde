class Player extends GameObject {
  PVector velocity;
  PVector accel;

  float radius;
  float mass;
  float gravity;
  PShape shape;
  char up, down, left, right;

  PVector force;
  float power;

  // Make different keys control the ship!
  Player(float x, float y, float size, char up, char down, char left, char right) {
    id = 1;
    pos = new PVector(x, y);
    forward = new PVector(-1, 0);
    accel = new PVector(0, 0);
    velocity = new PVector(0, 0);
    force = new PVector(0, 0);
    this.size = size;
    radius = size / 2;

    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
    create();

    power = 400;
    mass = 1;
  }

  void create() {
    shape = createShape(RECT, -(size/2), -(size/2), size, size);
  }

  void render() { // Overrides the method in the base class
    pushMatrix(); // Stores the current transform
    translate(pos.x, pos.y);
    shape(shape, 0, 0);
    stroke(0);
    ellipse(0, 0, size, size);
    popMatrix(); // Restore the transform
  }

  void update() {
    velocity.x = 0;

    if (checkKey(left))
      velocity.x = -power;

    if (checkKey(right))
      velocity.x = power;
    
    //gravity();
    sideCollision();
    
    if (checkKey(up) && pos.y - 150 > 0)
      velocity.y = -power;

    pos.add(PVector.mult(velocity, timeDelta));
  }
  
  void gravity() {
      gravity = 20.5f;
      velocity.y += gravity;
  }
  
  void sideCollision(){
    if(pos.x - size/2 < 0)
      pos.x = size/2;

    if(pos.x + size/2 > width)
      pos.x = width - size/2;
  }
}