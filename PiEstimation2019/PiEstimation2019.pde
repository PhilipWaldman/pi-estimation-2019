// Buffon's needle problem

int lineDistance=50, stickLength = 50, tosses=0, crosses=0;
ArrayList<PVector> sticks = new ArrayList<PVector>();
ArrayList<PVector> positions = new ArrayList<PVector>();


void setup() {
  size(600, 600);
  background(0);
}

void draw() {
  toss();

  background(0);
  drawSticks();
  drawLines();
  drawStats();
}

void toss() {
  tosses++;
  PVector pos = new PVector(random(width), random(height));
  PVector stick = PVector.fromAngle(random(2*PI)).setMag(stickLength);
  positions.add(pos);
  sticks.add(stick);

  if (overlaps(pos, stick))
    crosses++;

  if (sticks.size() > 100) {
    sticks.remove(0);
    positions.remove(0);
  }
}

void drawStats() {
  textSize(12);
  stroke(255);
  fill(0);
  rect(width-150, 0, width, 100);
  fill(255);
  text("Real pi: "+PI, width-140, 15);
  float piEst = 2 * (float)tosses * stickLength / ((float)crosses * lineDistance);
  text("Pi est:   "+piEst, width-140, 30);
  float error = (piEst-PI)/PI * 100;
  text("% error: "+error+"%", width-140, 45);
  text("Tosses: "+tosses, width-140, 60);
  text("Crosses: "+crosses, width-140, 75);
}

void drawSticks() {
  strokeWeight(5);
  stroke(255, 127, 0);
  for (int i=0; i<sticks.size(); i++) {
    line(positions.get(i).x, positions.get(i).y, positions.get(i).x+sticks.get(i).x, positions.get(i).y+sticks.get(i).y);
  }
}

boolean overlaps(PVector pos, PVector stick) {
  int startSection = int(pos.y/lineDistance);
  int endSection = int((pos.y+stick.y)/lineDistance);
  if (startSection!=endSection)
    return true;
  return false;
}

void drawLines() {
  strokeWeight(1);
  stroke(255);
  for (int i =0; i<height; i+=lineDistance) {
    line(0, i, width, i);
  }
}

void keyPressed() {
  for (int i=0; i<10000; i++)
    toss();
  
  if(key == 's')
    saveFrame("pi-2019.png");
}
