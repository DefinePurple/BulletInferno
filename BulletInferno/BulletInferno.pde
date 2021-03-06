/*  Daniel Fitzpatrick  
 *   C15345046
 *   DT228 - 2 Group B
 *
 *   Controls:
 *    Left - A
 *    Right - D
 *    Jump/Fly - W
 *    Run - Spacebar
 */

//Used as a sort of enumerator or #define from C 
int GROUND = 0;
int PLAYER = 1;
int BULLET = 2;
int COIN = 3;
int GUN = 4;
int POWERUP = 5;

int SPLASH = 0;
int GAME = 1;

void setup() {
  noCursor();
  fullScreen();
  //size(600, 600);
  fill(255);
  noStroke();
  textSize = (width + height) * 0.01f;

  splash = new StartSplash();
  //Loads fonts for use
  splashFont = loadFont("Arcade-100.vlw");
  gameFont = loadFont("namco_regular-100.vlw");
}


//initialise the game objects
void init() {
  timer = new Timer();
  score = new Score();
  gameObjects = new ArrayList<GameObject>();

  ground = new Ground(width * 0.5f, height * 0.99f, width * 1.2f, height * 0.05f);
  gameObjects.add(ground);

  if (!checkPlayer()) {
    Player player = new Player(width / 2, height * 0.7f, (width + height) * 0.008f, 'w', 'a', 'd', ' ', ground.pos);  
    gameObjects.add(player);
  }

  Gun gun = new Gun();
  gameObjects.add(gun);
}

Timer timer;
Score score;
Ground ground;
Splash splash;

ArrayList<GameObject> gameObjects;
boolean[] keys = new boolean[1000];
boolean keyBool;
float timeDelta = 1.0f / 60.0f;
float textSize;
color colour;
int screen = SPLASH;
PFont splashFont, gameFont;

void draw() {
  background(0);
  //Checks which screen to go to
  if (screen == GAME && checkPlayer()) {
    textSize(textSize);
    textFont(gameFont);

    //iterate through the list of objects while updating and rendering each one
    for (int i = 0; i < gameObjects.size(); i++) {
      GameObject go = gameObjects.get(i); 
      go.update();
      go.render();
    }
    //Checks each game object to see if it is dead or not
    for (int i = 0; i < gameObjects.size(); i++) {
      GameObject go = gameObjects.get(i);
      go.doDeath();
    }

    //Non gameobject objects
    timer.render();
    timer.update();
    score.render();
    //Determines colour of bullets
    bulletColour();
  } else if (screen == SPLASH) {
    textFont(splashFont);
    splash.render();
    splash.update();
  } else {
    //This else will happen when the player dies

    //Removes all objects from the list
    for (int i = 0; i < gameObjects.size(); i++) {
      gameObjects.remove(i);
    }
    //Sets all keys to be false
    for (int i = 0; i < keys.length; i++) {
      keys[i] = false;
    }
    //Sets screen to the splash screen 
    screen = SPLASH;
    splash = new DeathSplash(score.text, timer.time);
  }
}

//Looks for key presses
void keyPressed() {
  if (screen == GAME) 
    keys[keyCode] = true;
  else if (screen == SPLASH && keyCode == ENTER)
    keyBool = true;
}

//Looks for key releases
void keyReleased() {
  if (screen == GAME)
    keys[keyCode] = false;
}

//Used to check if a key is being pressed
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

//Sets the colour of the bullets in accordance with time
void bulletColour() {
  float c = abs(sin(millis() / 5000.0f) * 255);
  float c2 = abs(cos(millis() / 5000.0f) * 255);
  colour = color(c2, c, 0);
}

//checks the list of objects if there is already a player
//if there is no other player, create a new one
boolean checkPlayer() {
  for (int i = gameObjects.size() -1; i >= 0; i --) {
    GameObject go = gameObjects.get(i); 
    if (go.id == PLAYER)
      return true;
  }
  return false;
}