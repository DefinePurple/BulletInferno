class Timer extends GameObject {
  int previous;
  int seconds, minutes;

  Timer() {
    seconds = 0;
    previous = second();
    pos = new PVector(0, 0);
  }

  void render() {
    String string = nf(minutes % 60, 2, 0) + " : " + nf(seconds % 60, 2, 0);
    pushMatrix();
    translate(width/2, height/2);
    text(string, pos.x, pos.y);
    popMatrix();
  }

  void update() {
    if(previous != second()) {
      seconds++; 
    }
    
    if(seconds%60 == 0 && previous != second())
      minutes ++;
    previous = second();
  }
}