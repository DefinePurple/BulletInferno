class Ground extends GameObject {  
  Ground(float x, float y, float gWidth, float gHeight) {
    id = 0;
    this.pos = new PVector(x, y);
    this.gWidth = gWidth;
    this.gHeight = gHeight;
  }

  void render() {
    rect(pos.x, pos.y, gWidth, gHeight);
  }

  void update() {
  }
}