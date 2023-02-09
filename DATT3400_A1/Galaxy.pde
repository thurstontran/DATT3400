int numStars = 1500;
int numAsteroids = 100;
int numStarships = 5;
int numPlanets = 8;
Asteroids[] asteroid = new Asteroids[numAsteroids];
Starships[] starship = new Starships[numStarships];
Stars[] stars = new Stars[numStars];
Planets[] planets = new Planets[numPlanets];

void setup() {
  size(1920, 1080);
  
  for (int i = 0; i < numAsteroids; i++) {
   asteroid[i] = new Asteroids(random(width), random(height), 10);
  }

  for(int i = 0; i < numStarships; i++) {
    starship[i] = new Starships();
  }
  for (int i = 0; i < numStars; i++) {
    stars[i] = new Stars();
  }

  for (int i = 0; i < planets.length; i++) {
    planets[i] = new Planets(64+i*32,30);
  }
}

void draw() {
  background(0);
  
  stroke(255, 165, 0);
  strokeWeight(8);
  fill(255, 200, 50);
  ellipse(width / 2, height / 2, 64, 64);

  //Loop through each of the planets and set its color and orbit
  for(int i = 0; i < numPlanets; i++) {
    planets[0].col = color(175, 146, 99);
    planets[0].orbit(130);
    planets[1].col = color(222, 106, 9);
    planets[1].orbit(195);
    planets[2].col = color(5, 111, 159);
    planets[2].orbit(250);
    planets[3].col = color(177, 47, 5);
    planets[2].orbit(315);
    planets[4].col = color(177, 125, 95);
    planets[4].orbit(385);
    planets[5].col = color(176, 155, 67);
    planets[5].orbit(455);
    planets[6].col = color(70, 191, 246);
    planets[6].orbit(515);
    planets[7].col = color(72, 130, 200);
    planets[7].orbit(575);
    
    planets[i].display();
  }
  //Loop through each asteroid to check for if it collides with the Sun and removes the sets the collided asteroid to null
  for (int i = 0; i < numAsteroids; i++) {
    if (asteroid[i] == null) {
      continue;
    }
    if (asteroid[i].planetCollisionTimeout > 0) {
      asteroid[i].planetCollisionTimeout--;
    }
    //Get the distance between the asteroid and the Sun
    if (PVector.dist(asteroid[i].getPosition(), new PVector(width/2, height/2)) <= 36) {
      asteroid[i] = null;
      continue;
    }
    //Checks if the asteroids bounce off the edges of the sketch, update and display the asteroids
    asteroid[i].checkBoundaries();
    asteroid[i].display(); 
  }
  //Loop through each and every asteroid, and if they collide with each other, will result in a bounce
  for (int i = 0; i < numAsteroids; i++) {
    if (asteroid[i] == null) {
      continue;
    }
    for (int j = 0; j < numAsteroids; j++) {
      if (asteroid[j] == null) {
        continue;
      }
      if (i != j) {
        asteroid[i].checkCollision(asteroid[j]);
      }
    }
  } 
  //Loop through the starships and check if it collides with the Sun, removing the starships
  for (int i = 0; i < numStarships; i++) {
    if (starship[i] == null) {
      continue;
    }
    if (starship[i].planetCollisionTimeout > 0) {
      starship[i].planetCollisionTimeout--;
    }
    if (PVector.dist(starship[i].getPosition(), new PVector(width/2, height/2)) <= 36) {
      starship[i] = null;
      continue;
    }
    starship[i].display();
    starship[i].checkBoundaries();
  }
  //Loop through the asterodis and planets and if they collide with each other, bounce the asteroids off the planets
  for (int i = 0; i < numAsteroids; i++) {
    if (asteroid[i] == null || asteroid[i].planetCollisionTimeout > 0) {
      continue;
    }
    for (int j = 0; j < numPlanets; j++) {
      if (PVector.dist(asteroid[i].getPosition(), new PVector(planets[j].getPosition().x + width / 2, planets[j].getPosition().y + height / 2)) <= planets[j].getDiameter() / 1.5) {
        asteroid[i].bounce();
        break;
      }
    }
  }
  //Loop through the asteroids and starships and if they collide with each other, remove the asteroids from the sketch
  for (int i = 0; i < numAsteroids; i++) {
    if (asteroid[i] == null) {
      continue;
    }
    for (int j = 0; j < numStarships; j++) {
      if (starship[j] == null) {
        continue;
      }
      if (PVector.dist(asteroid[i].getPosition(), starship[j].getPosition()) <= 20) {
        asteroid[i] = null;
        break;
      }
    }
  }
  //Loop through the starships and the planets, and if they collide with each other, bounce the starships off the planets
  for (int i = 0; i < numStarships; i++) {
    if (starship[i] == null) {
      continue;
    }
    for (int j = 0; j < numPlanets; j++) {
      if (PVector.dist(starship[i].getPosition(), new PVector(planets[j].getPosition().x + width / 2, planets[j].getPosition().y + height / 2)) <= 20) {
        starship[i].bounce();
        break;
      }
    }
  }
   
  //Creates a simple parallax effect to simulate stars
  translate(width / 2, height / 2);
  for (int i = 0; i < numStars; i++) {
    stars[i].update();
    stars[i].display();
  }
}
