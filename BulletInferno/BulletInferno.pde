void setup(){
  //fullscreen();
  size(600,600);
  fill(255);
  stroke(255);
  
  Ground ground = new Ground(0, height * 0.95f, width, height * 0.05f);
  gameObjects.add(ground);
  init();//Initialise player object
}

void init() {
  boolean a = false;
  for (int i = gameObjects.size() -1; i >= 0; i --) {
    GameObject go = gameObjects.get(i); 
    if (go.id == 1)
      a = true;
  }
  if (!a) {
    Player player = new Player(width / 2, height / 2, 20, 'w', 's', 'a', 'd');  
    gameObjects.add(player);
  }
}

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[1000];
float timeDelta = 1.0f / 60.0f;

void draw(){
  background(0);  
  
  for (int i = 0; i < gameObjects.size(); i++) {
    GameObject go = gameObjects.get(i); 
    go.update();
    go.render();
  }
}

//looks for key presses
void keyPressed() { 
  keys[keyCode] = true;

  if (key == 'r')
    init();
}

//Looks for key releases
void keyReleased() {
  keys[keyCode] = false;
}

//used to check if a key is being pressed
boolean checkKey(int k) {
  if (keys.length >= k) 
    return keys[k] || keys[Character.toUpperCase(k)];  
  return false;
}

//Checks if the object is within the ground
//If they are, return true
boolean groundCollision(PVector pos, float size) {
  for (int i = gameObjects.size() -1; i >= 0; i --) {
    GameObject go = gameObjects.get(i); 
    if (go.id == 0)
      if (pos.y + size/2 >= go.pos.y && pos.y + size/2 <= go.pos.y + go.gHeight && pos.x > go.pos.x && pos.x < go.pos.x + go.gWidth)
        return true;
  }
  return false;
}