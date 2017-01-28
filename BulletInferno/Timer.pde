class Timer{
  int previous;
  int seconds, minutes;

  Timer() {
    seconds = 0;
    previous = second();
  }

  void render() {
    textSize(20);
    textAlign(LEFT, TOP);
    
    String string = nf(minutes % 60, 2, 0) + " : " + nf(seconds % 60, 2, 0);
    pushMatrix();
    translate(5, 5);
    text(string, 0,0);
    popMatrix();
  }

  void update() {
    if (previous != second()) {
      PVector temp = new PVector(random(10, width-10), -20);
      Coin coin = new Coin(ground.pos, temp, 10, 7);
      gameObjects.add(coin);
      seconds++;
    }

    if (seconds%60 == 0 && previous != second())
      minutes ++;
    previous = second();
  }
}