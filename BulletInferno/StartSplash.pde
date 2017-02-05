class StartSplash extends Splash {
  String instructions;
  PVector posInstructions;

  StartSplash() {
    this.text = "Press Enter to begin";
    this.title = "BULLET INFERNO";
    posInstructions = new PVector(width * 0.5f, height * 0.5f);
    instructions =    "Left: A\n";
    instructions +=   "Right: D\n";
    instructions +=   "Jump: W\n";
    instructions +=   "Run:    Spacebar\n";
  }

  void render() {
    super.render();
    textSize((width + height) * 0.025f);
    text("Instructions \n" + instructions, posInstructions.x, posInstructions.y);
  }
}