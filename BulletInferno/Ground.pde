//Ground is a unique object which the player stands on
class Ground extends GameObject {  
  Ground(float x, float y, float gWidth, float gHeight) {
    id = 0;

    x = x - gWidth * 0.5f;
    this.pos = new PVector(x, y);
    this.gWidth = gWidth;
    this.gHeight = gHeight;
  }

  void render() {
    fill(32, 38, 90);
    rect(pos.x, pos.y, gWidth, gHeight);
  }

  void update() {
  }
}