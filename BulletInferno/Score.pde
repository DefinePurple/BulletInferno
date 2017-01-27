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
  
  void render(){
    fill(0);
    textAlign(LEFT, BOTTOM);
    textSize(20);
    if(score % mod == 0 && score != 0){
      place ++;
      mod *= 10;
    }
    text = "Score: " + nf(score,place,0);
    text(text, 10, height - 5);  
    fill(255);
  }
  
  void addScore() {
    score += 1 * multiplier;
  }
}