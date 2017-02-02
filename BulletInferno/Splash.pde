class Splash {
  String startText, title;
  PVector posStartText, posTitle; 

  Splash() {
    this.startText = "Press any button to begin";
    this.title = "BULLET INFERNO";

    posStartText = new PVector(width * 0.5f, height * 0.7f);
    posTitle = new PVector(width * 0.5f, height * 0.2f);
  }

  Splash(String title) {
    this.startText =  "Press any button to restart";
    this.title = title;
    
    posStartText = new PVector(width * 0.5f, height * 0.7f);
    posTitle = new PVector(width * 0.5f, height * 0.2f);
  }

  void render() {
    textAlign(CENTER, CENTER);
    textSize((width + height) * 0.05f);

    pushMatrix();
    translate(posTitle.x, posTitle.y);
    text(title, 0, 0);
    
    textSize((width+height) * 0.025f);
    translate(0, posStartText.y - posTitle.y);
    text(startText, 0, 0);
    popMatrix();
  }
}