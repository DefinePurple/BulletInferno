void setup(){
  //fullscreen();
  size(600,600);
  fill(255);
  stroke(255);
  
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

void draw(){
  background(0);  
  
  for (int i = 0; i < gameObjects.size(); i++) {
    GameObject go = gameObjects.get(i); 
    go.update();
    go.render();
  }
}