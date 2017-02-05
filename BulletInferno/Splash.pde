class Splash {
  String text, title;
  PVector postext = new PVector(width * 0.5f, height * 0.7f);
  PVector posTitle = new PVector(width * 0.5f, height * 0.2f); 

  Splash() {
    this.text = "Press Enter to begin";
    this.title = "BULLET INFERNO";
  
    postext = new PVector(width * 0.5f, height * 0.7f);
    posTitle = new PVector(width * 0.5f, height * 0.2f);
  }



  void render() {
    textAlign(CENTER, CENTER);
    textSize((width + height) * 0.05f);

    pushMatrix();
    translate(posTitle.x, posTitle.y);
    text(title, 0, 0);
    
    textSize((width+height) * 0.025f);
    translate(0, postext.y - posTitle.y);
    text(text, 0, 0);
    popMatrix();
  }
  
  void update(){
    if(keyBool == true){
          screen = GAME;
          init();
          keyBool = false;
    }
  }
}