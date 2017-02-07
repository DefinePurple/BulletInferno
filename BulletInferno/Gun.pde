class Gun extends GameObject {
  float shootingInterval, shootingTime;
  float startingTheta, incTheta, offsetTheta, NEW_PI, speed;
  int gunType, numBullets;

  boolean shoot, chosen;//bools to determine if the gun can shoot and if it can change type

  //Variables for files
  File [] files;
  File file;

  Gun() {
    this.id = 4;
    this.shoot = true;
    File dir = new File(sketchPath("config")); //gets the path of the folder config
    files = dir.listFiles(); //lists ALL the files within the config folder
    file = files[0];//sets file to be the first file
    readFile();//reads from the files
  }

  void render() {
  }

  void update() {
    //Counter for when to shoot
    shootingInterval += timeDelta;

    //Sets the gun to be able to shoot ever 15 seconds after a 3 second wait
    if (timer.seconds % 15 <= 3)
      shoot = false;
    else 
    shoot = true;


    if (shootingInterval  >= shootingTime && shoot == true) {
      //Creates a number of bullets roughly equal to numBullets and have them rotated by a certain amount with each new bullet created
      for (int i = -numBullets/2; i <= numBullets/2; i++) {
        Bullet b = new Bullet(pos.x, pos.y, startingTheta + offsetTheta*i, (width + height) * 0.005f, 8, speed, colour); 
        gameObjects.add(b);
      }
      //increase the starting angle by an increment
      startingTheta += incTheta;

      //Change directions once the gun hits a certain point
      if ((startingTheta >= PI + PI/4 || startingTheta <= PI - PI/4) && gunType != 1)
        incTheta *= -1;

      //reset shooting interval
      shootingInterval = 0;
      chosen = false;//set the gun to be able to choose a new type
    }

    //if the gun isnt shooting, 15 seconds has passed and the gun type has not been chosen -> choose a new gun type
    if (shoot == false && timer.seconds % 15 == 0 && chosen != true) {
      readFile();
      chosen = true;
    }
  }

  void readFile() {
    File previousFile = file;
    //Decides a new gun type that is not the same as the previous gun type
    while (previousFile == file) {
      file = files[(int) random(0, files.length-1)];
    }


    String lines[] = loadStrings(file);//loads all the lines from a file 
    ArrayList<String> line = new ArrayList<String>();//Used for storing strings later on
    String string = ""; //initialise a temp string
    char ch;//temp char

    for (int i = 0; i < lines.length; i++) {
      int j = 1;
      //This will count from the end of the string backwards until it hits a space
      //While doing so, it will increase the counter 'j' which will be used to
      //find how far back from the end of the string to go
      //EG: "I am a test string"
      //using this example, the count will be 1 + sizeOf(string) ie: 7
      while (lines[i].charAt( lines[i].length()-j) != ' ') {
        ch = lines[i].charAt( lines[i].length()-j);
        j++;
      }

      //This code adds each character from the end of the string to 'string'
      //EG: Using the previous example, it will first add 's' to string, then 't' and so on until it hits the end of the string
      while (j != 0) {
        ch = lines[i].charAt( lines[i].length()-j);
        if (ch != ' ') {
          string += ch;
        }
        j--;
      }
      line.add(string);//add string to the list of strings
      string = "";
    }

    //Following code reads from the array list and gets the values needed
    this.speed = int(line.get(0));
    this.gunType = int(line.get(1));
    this.numBullets = int(line.get(2));
    int increment = int(line.get(3));
    this.shootingTime = float(line.get(4));
    int direction = int(line.get(5));

    //These are the variables which decide if a gun is circular or not
    if (gunType == 1) {
      NEW_PI = PI + HALF_PI + QUARTER_PI/2;
      this.startingTheta = 0;
      this.pos = new PVector(width/2, height * 0.5f);
    } else {
      NEW_PI = PI - HALF_PI;
      this.startingTheta = PI;
      this.pos = new PVector(width/2, height * 0.1f);
    }

    this.incTheta = (NEW_PI/increment) * direction;
    this.offsetTheta = NEW_PI/(numBullets+1);
  }
}