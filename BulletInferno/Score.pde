class Score {
  int score;
  int multiplier;

  Score() {
    score = 0;
    multiplier = 1;
  }
  
  void render(){
    fill(0);
    textAlign(LEFT, BOTTOM);
    text(score, 10, height - 10);  
    fill(255);
  }
  
  void addScore() {
    score += 1 * multiplier;
  }
}