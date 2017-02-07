class GameObject {
  int id; //used to determine, for example, if a bullet is a bullet
  PVector pos; //position of the object
  PVector forward; //forward vector
  PVector velocity; //velocity of object

  float size;//size of the object
  float gravity;//gravity
  float timeToLive;//how long the object can live for

  boolean dead;

  //Ground attributes -- Some objects need to know where the ground is
  PVector groundPosition;
  float gWidth;
  float gHeight;

  GameObject() {
    gravity = 12.5;
  }

  void update() {
  }

  void render() {
  }

  //Called every time draw runs, if the object is set to dead, kill it.
  void doDeath() {
    if (dead == true)
      gameObjects.remove(this);
  }
}