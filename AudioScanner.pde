// simple sketch that creates a sort of scanner

//These are unused but got to have if you want to see the 
//simple code where it comes from in the draw
//int x = 0;
int step = 100;
//int radius = 300;
//float off = .0;

//Create some new scanners
ScannPoint scanner;
ScannPoint another_scanner;

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100); // because HSB is cooler


  // ScannPoint(float _radius, color _c, float _w, float _amount, float _x)
  // radius is the radius of the orbit
  // color is the color of the ellipse
  // w is the width of the ellipse
  // amount is the amount the ellipse can differ from its orbit
  // x is the starting point of the ellipse
  scanner = new ScannPoint(300, color(162, 90, 90), 5, 100, 90);
  another_scanner = new ScannPoint(305, color(162, 90, 90), 5, 100, 90);
}
void draw() {

  bg_and_ranges(); // clear the bg and draw the circles

    scanner.run(); // run one scanner  
  another_scanner.run(); // run another

  // this is the origianl code where it came from
  //  off+=.01;
  //  x++;
  //  pushMatrix();
  //  translate(width/2, height/2);// bring zero point to the center 
  //  float n = noise(off) * 100;
  //  float px = sin(radians(x%360))*(radius + n); 
  //  float py = cos(radians(x%360))*(radius + n);
  //  fill(162, 90, 90);
  //  ellipse (px, py, 5, 5 );
  //  popMatrix();
}

void bg_and_ranges() {
  // delete the bg
  noStroke();
  fill(0, 10);
  rect(0, 0, width, height);
  // draw the circles in the bg
  stroke(128);
  noFill();
  for (int i = 1; i < 8; i++) {
    ellipse(width/2, height/2, (width - step* i), (width - step*i));
  }
}

// the scanner class
class ScannPoint {
  private float x = 0; // this is the point where we start on the circle
  private float off = 0.0;// this is for the noise the scann point takes
  private float n; // also for noise
  public float amount; // the amount it moves from its orbit
  public float radius; // the radius around the center
  public color c;// its color
  public float w; // its width

  // init 
  ScannPoint(float _radius, color _c, float _w, float _amount, float _x) {
    this.radius = _radius;
    this.c = _c;
    this.w = _w;
    this.amount = _amount;
    this.x = _x;
  }

  // update all its variables
  private void update () {
    this.x++;
    this.off+=.01;
    this.n = noise(this.off) * this.amount;
  }

  // display it
  private void display() {
    // push it to the center of the canvas
    pushMatrix();
    translate(width/2, height/2);// bring zero point to the center
   
   // calc the xy on the circle 
    float px = sin(radians(this.x%360))*(this.radius + this.n); 
    float py = cos(radians(this.x%360))*(this.radius + this.n);
    
    fill(this.c);// color
    ellipse (px, py, this.w, this.w );// draw it
    // pop matrix back
    popMatrix();
  }

  public void run() {
    update();
    display();
  }
}

