class Stars {
  PVector position;
  float speed;
  float size;

  Stars() {
    position = new PVector(random(-width / 2, width / 2), random(-height / 2, height / 2));
    speed = random(0.5, 2);
    size = random(1, 3);
  }

  void update() {
    //Increment the x position of the stars
    position.x += speed;
    if (position.x > width / 2) {
      position.x = -width / 2;
    }
  }

  void display() {
    stroke(255, 255, 255);
    strokeWeight(size);
    point(position.x, position.y);
  }
}
