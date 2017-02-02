class Timer {
  int previous;
  int seconds, minutes;

  Timer() {
    seconds = 0;
    previous = second();
  }

  void render() {
    textSize(textSize);
    textAlign(RIGHT, TOP);

    //converts and formats the integers into a string
    String string = nf(minutes % 60, 2, 0) + " : " + nf(seconds % 60, 2, 0);

    //place the string on the screen
    pushMatrix();
    translate(width - 10, 5);
    
    text(string + "  " + seconds, 0, 0);
    popMatrix();
  }

  void update() {
    //If the current second is different to what it was last time, create a coin aswell as implement second
    if (previous != second()) {

      PVector temp = new PVector(random(10, width-10), -20);
            
      if ((int)random(0, 500) % 5 == 0) {
        Multiplier multi = new Multiplier(ground.pos, temp, textSize, 7);
        gameObjects.add(multi);
      } else {

        Coin coin = new Coin(ground.pos, temp, (width+height) * 0.01f, 7);
        gameObjects.add(coin);
      }
      seconds++;
    }

    //every 60 seconds increment minute
    if (seconds % 60 == 0 && previous != second())
      minutes ++;

    //set previous to be the current second
    previous = second();
  }
}