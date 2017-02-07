//Splash screen when the player dies

class DeathSplash extends Splash {
  String score, time;
  PVector posScore, posTime;

  DeathSplash(String score, String time) {
    this.text =  "Press Enter to Restart";
    this.title = "DEAD";
    this.score = score;
    this.time = time;

    posScore = new PVector(width/2, height * 0.4f);
    posTime = new PVector(width/2, height * 0.475f);
  }

  void render() {
    super.render();
    textSize((width + height) * 0.025f);//Determine text size
    text(score, posScore.x, posScore.y); //put score on screen
    text("Time survived: " + time, posTime.x, posTime.y); //put time survived on screen
  }
}