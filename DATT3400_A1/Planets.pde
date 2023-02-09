class Planets {
  float theta; //angle of rotation around the Sun
  float diameter; //size of given planet
  float distance; //distance away from the Sun
  float speed; //Orbital speed
  color col; //color of each individual planet
  float planetSize; 
  PVector position;
  
  Planets(float distance, float diameter) {
    this.position = new PVector(distance, 0);
    this.distance = distance;
    this.diameter = diameter;

    speed = random(0.01, 0.03);
  }
  //Custom method to get the position of the planets
  PVector getPosition() {
    return this.position;
  }
  //Custom method to get the diameter of the planets
  float getDiameter() {
    return this.diameter;
  }

  void display() {
    this.position.rotate(speed);
    noStroke();
    fill(col);
    ellipse(width / 2 + position.x, height / 2 + position.y, diameter, diameter);
  }
  
 void orbit(float orbitSize) {
    noFill();
    strokeWeight(1);
    stroke(255);
    ellipse(width / 2, height / 2, orbitSize, orbitSize);
    }
}
