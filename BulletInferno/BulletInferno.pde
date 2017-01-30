int GROUND = 0;
int PLAYER = 1;
int BULLET = 2;
int COIN = 3;
int GUN = 4;


void setup() {
  //fullScreen();
  size(600, 600);
  fill(255);
  stroke(255);
  
  ground = new Ground(width * 0.5f, height * 0.95f, width * 1.2f, height * 0.05f);
  gameObjects.add(ground);
  init();//Initialise player object
  //Gun gun = new Gun();
  //gameObjects.add(gun);
}


//initialise the player object
//checks the list of objects if there is already a player
//if there is no other player, create a new one
void init() {
  boolean a = false;
  
  for (int i = gameObjects.size() -1; i >= 0; i --) {
    GameObject go = gameObjects.get(i); 
    if (go.id == PLAYER)
      a = true;
  }
  
  if (!a) {
    Player player = new Player(width / 2, height * 0.7f, 15, 'w', 's', 'a', 'd', ' ', ground.pos);  
    gameObjects.add(player);
  }
}



Timer timer = new Timer();
Score score = new Score();
Ground ground;

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[1000];
float timeDelta = 1.0f / 60.0f;



void draw() {
  background(0); 
  textSize(20);
  
  //iterate through the list of objects while updating and rendering each one
  for (int i = 0; i < gameObjects.size(); i++) {
    GameObject go = gameObjects.get(i); 
    go.update();
    go.render();
  }
  
  for (int i = 0; i < gameObjects.size(); i++){
    GameObject go = gameObjects.get(i);
    go.doDeath();
  }
  
  timer.render();
  timer.update();
  score.render();
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
boolean edgeCollision(PVector pos, float size) {
  for (int i = gameObjects.size() -1; i >= 0; i --) {
    GameObject go = gameObjects.get(i); 
    if (go.id == GROUND)
      if (pos.y + size/2 >= go.pos.y && pos.y + size/2 <= go.pos.y + go.gHeight && pos.x > go.pos.x && pos.x < go.pos.x + go.gWidth)
        return true;
  }
  return false;
}

//Checks distance from the center of each object
//If the current object being fetched is a bullet
//And it is within the radius of the object which called the function(player)
//remove the bullet game object and return true to the caller
boolean centerCollision(PVector pos, float size, int id) {
  for (int i = gameObjects.size() -1; i >= 0; i --) {
    GameObject go = gameObjects.get(i); 
    if (go.id == id)
      if (dist(pos.x, pos.y, go.pos.x, go.pos.y) <= size/2 + go.size/4) {
        if (id == BULLET)
          go.dead = true;
        return true;
      }
  }
  return false;
}