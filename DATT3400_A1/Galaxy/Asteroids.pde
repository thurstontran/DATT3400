class Asteroids {
  PVector position;
  PVector velocity;
  float diameter;
  float m;
  int planetCollisionTimeout;

  Asteroids(float x, float y, float diam) {
    position = new PVector(x, y);
    velocity = PVector.random2D();
    velocity.mult(random(2, 5));
    diameter = diam;
    m = diameter * 0.1;
    planetCollisionTimeout = 0;
  }

//Custom method to get the position of the asteroids
  PVector getPosition() {
    return position;
  }

  //Swap the velocities of the asteroids when colliding with the planets
  void bounce() {
    velocity.x *= -1;
    velocity.y *= -1;
    planetCollisionTimeout = 100;
  }

  void checkBoundaries() {
    position.add(velocity);
    //Check to see if position of asteroids reach the borders and swap its velocities
    if (position.x < 0 || position.x > width) {
      velocity.x = -velocity.x;
    }
    if (position.y < 0 || position.y > height) {
      velocity.y = -velocity.y;
    }
  }

  //Inspired from Ira Greenberg's Circle Collision with Swapping Veloctities. 
  void checkCollision(Asteroids other) {

    // Get distances between the asteroids and its components
    PVector distanceVect = PVector.sub(other.position, position);

    // Calculate magnitude of the vector separating the asteroids
    float distanceVectMag = distanceVect.mag();

    // Minimum distance before they are touching
    float minDistance = diameter + other.diameter;

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      other.position.add(correctionVector);
      position.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      // bTemp will hold rotated positions of the asteroids. 
      PVector[] bTemp = {
        new PVector(), new PVector()
      };
      /* this asteroid's position is relative to the other
       bTemp[0].position.x and bTemp[0].position.y will initialize
       automatically to 0.0, resulting in b[1] to rotate around b[0] */
      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      // rotate the temporary velocities
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = cosine * other.velocity.x + sine * other.velocity.y;
      vTemp[1].y  = cosine * other.velocity.y - sine * other.velocity.x;

      PVector[] vFinal = {
        new PVector(), new PVector()
      };

      // final rotated velocity for b[0]
      vFinal[0].x = ((m - other.m) * vTemp[0].x + 2 * other.m * vTemp[1].x) / (m + other.m);
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for b[1]
      vFinal[1].x = ((other.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + other.m);
      vFinal[1].y = vTemp[1].y;

      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;


      //Rotate the current velocities
      PVector[] bFinal = {
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      other.position.x = position.x + bFinal[1].x;
      other.position.y = position.y + bFinal[1].y;

      position.add(bFinal[0]);

      // update velocities of the asteroids
      velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      other.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
    }
  }

  void display() {
    fill(255, 255, 255);
    ellipse(position.x, position.y, diameter, diameter);
  }
}
