class Timer {
  int previous;
  int seconds, minutes;

  Timer() {
    seconds = 0;
    previous = second();
  }

  void render() {
    textSize(20);
    textAlign(LEFT, TOP);

    //converts and formats the integers into a string
    String string = nf(minutes % 60, 2, 0) + " : " + nf(seconds % 60, 2, 0);

    //place the string on the screen
    pushMatrix();
    translate(5, 5);
    text(string, 0, 0);
    popMatrix();
  }

  void update() {
    //If the current second is different to what it was last time, create a coin aswell as implement second
    if (previous != second()) {

      PVector temp = new PVector(random(10, width-10), -20);
      
      if ((int)random(0, 100) % 5 == 0) {
        Multiplier multi = new Multiplier(ground.pos, temp, 7);
        gameObjects.add(multi);
      } else {

        Coin coin = new Coin(ground.pos, temp, 10, 7);
        gameObjects.add(coin);
      }
      seconds++;
    }

    //every 60 seconds increment minute
    if (seconds%60 == 0 && previous != second())
      minutes ++;

    //set previous to be the current second
    previous = second();
  }
}