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
  textSize = (width + height) * 0.0125f;

  init();//Initialise player object
}


//initialise the player object
//checks the list of objects if there is already a player
//if there is no other player, create a new one
void init() {
  boolean a = false;
  timer = new Timer();
  score = new Score();
  gameObjects = new ArrayList<GameObject>();
  
  
  ground = new Ground(width * 0.5f, height * 0.95f, width * 1.2f, height * 0.05f);
  gameObjects.add(ground);
  
  for (int i = gameObjects.size() -1; i >= 0; i --) {
    GameObject go = gameObjects.get(i); 
    if (go.id == PLAYER)
      a = true;
  }
  
  if (!a) {
    Player player = new Player(width / 2, height * 0.7f, (width + height) * 0.008f, 'w', 's', 'a', 'd', ' ', ground.pos);  
    gameObjects.add(player);
  }
  
  Gun gun = new Gun();
  gameObjects.add(gun);
  
}



Timer timer;
Score score;
Ground ground;

ArrayList<GameObject> gameObjects;
boolean[] keys = new boolean[1000];
float timeDelta = 1.0f / 60.0f;
float textSize;
color colour;
color bgColour;


void draw() {
  bgColour = color(30,30,30);
  background(bgColour); 
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
  bulletColour();
  //delay(100);
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

void bulletColour(){
  float c = abs(sin(millis() / 5000.0f) * 255);
  float c2 = abs(cos(millis() / 5000.0f) * 255);
  colour = color(c2, c, 0); 
}