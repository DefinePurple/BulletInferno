class Score {
  int score, multiplier, place, mod;
  String text; 
  
  Score() {
    this.score = 0;
    this.multiplier = 1;
    this.place = 1;
    this.mod = 10;
  }

  void render() {
    fill(255);
    textAlign(LEFT, TOP);
    textSize(textSize);
    
    //Increases how many places before the decimal point
    if (score % mod == 0 && score != 0) {
      place ++;
      mod *= 10;
    }
    //Convert and format integer to string
    text = "score: " + nf(score, place, 0);
    String text2 = "multiplier x" + multiplier;
    
    //Place string on screen
    pushMatrix();
    translate(5, 5);
    text(text, 0, 0);  
    text(text2, 0, textSize + 10);
    popMatrix();
  }

  //Gets called everytime a coin is picked up.
  void addScore() {
    score += 10 * multiplier;
  }
  
  void increaseMultiplier(){
    multiplier++; 
  }
}