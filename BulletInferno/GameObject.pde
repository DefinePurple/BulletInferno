class GameObject {
  int id;
  PVector pos;
  PVector forward;
  float size;
  boolean dead;
  float gravity;
  PVector velocity;
  
  //Ground attributes
  float gWidth;
  float gHeight;
  
  GameObject(){
    gravity = 12.5; 
  }
  
  void update() {
  }

  void render() {
  }
}