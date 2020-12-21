// Buffon's needle problem

int lineDistance=50;  // The distance between the lines.
int stickLength = 50;  // The length of the sticks.
int tosses=0;  // A counter of the number of tosses.
int crosses=0;  // A counter of the number of tosses that crossed a line.
ArrayList<PVector> sticks = new ArrayList<PVector>();  // The sticks (angle and length).
ArrayList<PVector> positions = new ArrayList<PVector>();  // The positions of the sticks.


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
  PVector pos = new PVector(random(width), random(height));  // Calculate random position.
  PVector stick = PVector.fromAngle(random(2 * PI)).setMag(stickLength);  // Calculate random angle.
  positions.add(pos);
  sticks.add(stick);

  if (overlaps(pos, stick)) {
    crosses++;
  }

  // Only store the last 100 sticks to remove clutter.
  if (sticks.size() > 100) {
    sticks.remove(0);
    positions.remove(0);
  }
}

void drawStats() {
  textSize(12);
  stroke(255);
  fill(0);
  rect(width - 150, 0, width, 100);
  fill(255);
  text("Real pi: " + PI, width - 140, 15);
  float piEst = 2 * (float) tosses * stickLength / ((float) crosses * lineDistance);
  text("Pi est:   " + piEst, width - 140, 30);
  float error = (piEst - PI) / PI * 100;
  text("% error: " + error + "%", width - 140, 45);
  text("Tosses: " + tosses, width - 140, 60);
  text("Crosses: " + crosses, width - 140, 75);
}

void drawSticks() {
  strokeWeight(5);
  stroke(255, 127, 0);
  for (int i = 0; i < sticks.size(); i++) {
    line(positions.get(i).x, positions.get(i).y,
      positions.get(i).x + sticks.get(i).x, positions.get(i).y + sticks.get(i).y);
  }
}

// Checks whether the stick crosses a line by checking if its head and tail are in different sections.
boolean overlaps(PVector pos, PVector stick) {
  int startSection = int(pos.y / lineDistance);
  int endSection = int((pos.y + stick.y) / lineDistance);
  return startSection != endSection;
}

void drawLines() {
  strokeWeight(1);
  stroke(255);
  for (int i = 0; i < height; i += lineDistance) {
    line(0, i, width, i);
  }
}

void keyPressed() {
  // If any key is pressed, toss 10000 sticks.
  for (int i = 0; i < 10000; i++) {
    toss();
  }

  // If "s" is pressed, save the frame.
  if (key == 's') {
    saveFrame("pi-2019.png");
  }
}
