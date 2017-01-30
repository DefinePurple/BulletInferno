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
    textAlign(RIGHT, TOP);
    
    //Increases how many places before the decimal point
    if (score % mod == 0 && score != 0) {
      place ++;
      mod *= 10;
    }
    //Convert and format integer to string
    text = "Score: " + nf(score, place, 0) + "    Multiplier x" + multiplier;
    
    //Place string on screen
    pushMatrix();
    translate(width - 10, 5);
    text(text, 0, 0);  
    popMatrix();
  }

  //Gets called everytime a coin is picked up.
  void addScore() {
    score += 1 * multiplier;
  }
  
  void increaseMultiplier(){
    multiplier++; 
  }
}