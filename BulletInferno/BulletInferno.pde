void setup() {
  //fullscreen();
  size(600, 600);
  fill(255);
  stroke(255);

  Ground ground = new Ground(0, height * 0.95f, width, height * 0.05f);
  gameObjects.add(ground);
  init();//Initialise player object
  Gun gun = new Gun();
  gameObjects.add(gun);
}

void init() {
  boolean a = false;
  for (int i = gameObjects.size() -1; i >= 0; i --) {
    GameObject go = gameObjects.get(i); 
    if (go.id == 1)
      a = true;
  }
  if (!a) {
    Player player = new Player(width / 2, height * 0.7f, 20, 'w', 's', 'a', 'd');  
    gameObjects.add(player);
  }
}

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[1000];
float timeDelta = 1.0f / 60.0f;


void draw() {
  background(0); 

  for (int i = 0; i < gameObjects.size(); i++) {
    GameObject go = gameObjects.get(i); 
    go.update();
    go.render();
  }
  
  for (int i = 0; i < gameObjects.size(); i++) {
    GameObject go = gameObjects.get(i); 
    if(go.dead == true)
      gameObjects.remove(go);
  }
}

//looks for key presses
void keyPressed() { 
  keys[keyCode] = true;

  //Makes new character
  if (key == 'r' || key == 'R')
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

//Checks if the objects 'feet' are within the ground
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

//Checks distance from the center of each object
//If the current object being fetched is a bullet
//And it is within the radius of the object which called the function(player)
//remove the bullet game object and return true to the caller
boolean bulletCollision(PVector pos, float size) {
  for (int i = gameObjects.size() -1; i >= 0; i --) {
    GameObject go = gameObjects.get(i); 
    if (go.id == 3)
      if (dist(pos.x, pos.y, go.pos.x, go.pos.y) <= (size + go.size) * 0.5f) {
        gameObjects.remove(go);
        return true;
      }
  }
  return false;
}