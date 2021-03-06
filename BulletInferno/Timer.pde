class Timer {
  int previous;
  int seconds, minutes;

  String time;

  Timer() {
    seconds = 0;
    previous = second();
  }

  void render() {
    textSize(textSize);
    textAlign(RIGHT, TOP);
    fill(255);
    //converts and formats the integers into a string
    time = nf(minutes % 60, 2, 0) + ":" + nf(seconds % 60, 2, 0);

    //place the string on the screen
    pushMatrix();
    translate(width - 10, 5);
    text(time + "  ", 0, 0);
    popMatrix();
  }

  void update() {
    //If the current second is different to what it was last time, create a coin aswell as implement second
    if (previous != second()) {
      PVector temp;

      int rand = (int) random(0, 500);
      if ((rand >= 0) && (rand < 10)) {
        temp = new PVector(random(10, width-10), -20);
        Multiplier multi = new Multiplier(ground.pos, temp, textSize, 7);
        gameObjects.add(multi);
      }

      if ((rand >= 10) && (rand < 20)) {
        temp = new PVector(random(10, width-10), -20);
        PowerUp powerUp = new PowerUp(ground.pos, temp, (width + height) * 0.01f, 7);
        gameObjects.add(powerUp);
      }

      temp = new PVector(random(10, width-10), -20);
      Coin coin = new Coin(ground.pos, temp, (width+height) * 0.01f, 7);
      gameObjects.add(coin);
      seconds++;
    }

    //every 60 seconds increment minute
    if (seconds % 60 == 0 && previous != second())
      minutes ++;

    //set previous to be the current second
    previous = second();
  }
}