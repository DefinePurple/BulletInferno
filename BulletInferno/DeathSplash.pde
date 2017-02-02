class DeathSplash extends Splash {
  String score, time;
  PVector posScore, posTime;
  
  DeathSplash(String score, String time){
    this.text =  "Press Enter to restart";
    this.title = "DEAD";
    this.score = score;
    this.time = time;
    
    posScore = new PVector(width/2, height * 0.4f);
    posTime = new PVector(width/2, height * 0.475f);
  }
  
  void render(){
    super.render();
    textSize((width + height) * 0.025f);
    text(score, posScore.x, posScore.y);
    text("Time survived: " + time, posTime.x, posTime.y);
  }
}