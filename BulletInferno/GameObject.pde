class GameObject {
  int id;
  PVector pos;
  PVector forward;
  PVector velocity;

  float size;
  float gravity;
  float timeToLive;
  
  boolean dead;
  
  //Ground attributes
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