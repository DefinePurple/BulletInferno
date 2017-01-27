class Score {
  int score, multiplier, place, mod;
  String text;

  Score() {
    super();
    this.score = 0;
    this.multiplier = 1;
    this.place = 1;
    this.mod = 10;
  }

  void render() {
    fill(255);
    textAlign(RIGHT, TOP);
    if (score % mod == 0 && score != 0) {
      place ++;
      mod *= 10;
    }
    text = "Score: " + nf(score, place, 0);
    
    pushMatrix();
    translate(width - 10, 5);
    text(text, 0, 0);  
    popMatrix();
  }

  void addScore() {
    score += 1 * multiplier;
  }
}