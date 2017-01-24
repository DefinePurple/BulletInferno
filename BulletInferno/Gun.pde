class Gun extends GameObject {
  float shootingInterval, shootingTime;
  float startingTheta, incTheta, offsetTheta, NEW_PI, speed;
  int gunType, numBullets, second;
  float timer;

  boolean shoot;
  File [] files;
  Gun() {
    id = 4;
    shoot = true;
    second = 1;
    File dir; 
    dir = new File(dataPath(""));
    files = dir.listFiles();
    println(files);
    readFile();
  }

  void render() {
    text(second, width/2, height/2);
  }

  void update() {
    shootingInterval += timeDelta;
    timer();
    if (shootingInterval  >= shootingTime && shoot == true) {
      for (int i = -numBullets/2; i <= numBullets/2; i++) {
        Bullet b = new Bullet(pos.x, pos.y, startingTheta + offsetTheta*i, 9, 8, speed); 
        gameObjects.add(b);
      }
      startingTheta += incTheta;
      if ((startingTheta >= PI + PI/4 || startingTheta <= PI - PI/4) && gunType != 1)
        incTheta *= -1;

      shootingInterval = 0;
    }

    if (shoot == false)
      readFile();
  }

  void timer() {
    timer++;
    if (timer % 60 == 0)
      second ++;

    if (second % 20 <= 5)
      shoot = false;
    else 
    shoot = true;
  }


  void readFile() {
    //File file = files[(int) random(0, files.length)];
    File file = files[1];
    String lines[] = loadStrings(file);
    ArrayList<String> line = new ArrayList<String>();
    String string = "";
    char ch;

    for (int i = 0; i < lines.length; i++) {
      int j = 1;
      while (lines[i].charAt( lines[i].length()-j) != ' ') {
        ch = lines[i].charAt( lines[i].length()-j);
        j++;
      }

      while (j != 0) {
        ch = lines[i].charAt( lines[i].length()-j);
        if (ch != ' ') {
          string += ch;
        }
        j--;
      }
      line.add(string);
      string = "";
    }

    gunType = int(line.get(1));
    if (gunType == 1) {
      NEW_PI = PI + HALF_PI;
      this.startingTheta = 0;
      this.pos = new PVector(width/2, height * 0.45f);
    } else {
      NEW_PI = PI - HALF_PI;
      this.startingTheta = PI;
      this.pos = new PVector(width/2, height * 0.1f);
    }
    int increment = int(line.get(3));
    this.shootingTime = float(line.get(4));
    this.speed = int(line.get(0));
    this.numBullets = int(line.get(2));
    this.incTheta = NEW_PI/increment;
    this.offsetTheta = NEW_PI/(numBullets+1);
  }
}