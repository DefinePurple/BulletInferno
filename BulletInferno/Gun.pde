class Gun extends GameObject {
  float shootingInterval, shootingTime;
  float startingTheta, incTheta, offsetTheta, NEW_PI, speed;
  int gunType, numBullets;

  boolean shoot;
  File [] files;
  File file;
  Gun() {
    this.id = 4;
    this.shoot = true;
    File dir; 
    dir = new File(sketchPath("config"));
    files = dir.listFiles();
    readFile();
  }

  void render() {
    println(file);
  }

  void update() {
    shootingInterval += timeDelta;
    
    if (timer.seconds % 15 <= 3)
      shoot = false;
    else 
    shoot = true;
    
    if (shootingInterval  >= shootingTime && shoot == true) {
      for (int i = -numBullets/2; i <= numBullets/2; i++) {
        Bullet b = new Bullet(pos.x, pos.y, startingTheta + offsetTheta*i, 9, 8, speed, colour); 
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
  }


  void readFile() {
    println(files.length);
    File check = files[(int) random(0, files.length-1)];
    if (check != file)
      file = check;

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

    this.speed = int(line.get(0));
    this.gunType = int(line.get(1));
    this.numBullets = int(line.get(2));
    int increment = int(line.get(3));
    this.shootingTime = float(line.get(4));
    int direction = int(line.get(5));

    if (gunType == 1) {
      NEW_PI = PI + HALF_PI + QUARTER_PI/2;
      this.startingTheta = 0;
      this.pos = new PVector(width/2, height * 0.45f);
    } else {
      NEW_PI = PI - HALF_PI;
      this.startingTheta = PI;
      this.pos = new PVector(width/2, height * 0.1f);
    }

    this.incTheta = (NEW_PI/increment) * direction;
    this.offsetTheta = NEW_PI/(numBullets+1);
  }
}