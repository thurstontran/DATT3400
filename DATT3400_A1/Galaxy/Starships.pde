class Starships {
  PVector position;
  PVector velocity;
  float angle = 0;
  int length = 20;
  int planetCollisionTimeout = 0;

  Starships() {
    position = new PVector(random(width), random(height));
    velocity = PVector.random2D();
    velocity.mult(random(1, 2));
  }
  
  //Custom method to get the position of the starships
  PVector getPosition() {
    return position;
  }
  
  void bounce() {
    //Swap the velocities of the starships when colliding with the planets
    velocity.x *= -1;
    velocity.y *= -1;
    planetCollisionTimeout = 100;
  }

  void checkBoundaries() {
    position.add(velocity);
    //Check to see if starships reach the borders and swap its velocities
    if (position.x < 0 || position.x > width) {
      velocity.x = -velocity.x;
    }
    if (position.y < 0 || position.y > height) {
      velocity.y = -velocity.y;
    }
  }

  void display() {
    fill(0, 255, 0); 
    translate(position.x, position.y);
    position.x += cos(radians(angle)) / 2; 
    position.y -= sin(radians(angle)) / 2;  
    triangle(0, 10, 0, -10, length, 0);
    translate(-position.x, -position.y);
  }
}
