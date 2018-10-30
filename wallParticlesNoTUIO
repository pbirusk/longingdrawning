
int NUM_PARTICLES = 5000;
ParticleSystem p;

void setup() {

  size(900, 600, P2D);
  background(0);
  noCursor();


  p = new ParticleSystem();
}

void draw() {
  println(frameRate);
  background(0);
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, 20, 20);
  noFill();
  //************ Partikelsystem
  p.update();
  p.render();
}

float transitionFun(float x, float blurRadius) {
  return 1.0/(1+exp(x/blurRadius));
}

class Particle
{
  PVector position, refPosition, velocity;
  float partSpeed;
  color c;
  float particleSize = 2;
  float particleOriginalSize = 1;
  float waveLength = 300;
  float waveFrequency = 3;

  Particle()
  {
    refPosition = new PVector(random(width), random(height));
    position = new PVector(refPosition.x, refPosition.y);

    velocity = new PVector();
    partSpeed = random(0.9, 1.1);

    c = color(0, random(126-50, 126+50), 255, 200);
  }

  void update()
  {
    float waterHeight = mouseY;

    float a = refPosition.x;
    float b = -(refPosition.y-waterHeight);

    float waveNumber = 2*PI/waveLength;
    float waveSpeed = waveFrequency/waveNumber;

    float time = millis()/1000.0;

    float dX =   exp(waveNumber*b)/waveNumber * sin( waveNumber*(a + waveSpeed*time));
    float dY =   exp(waveNumber*b)/waveNumber * cos( waveNumber*(a + waveSpeed*time));

    //position.x = refPosition.x;// + dX;
    //position.y = refPosition.y;//+ dY;
    //float waveStrenght = constrain(((height - mouseY)/60), 4, 15);

    if (refPosition.y < waterHeight) {
      particleSize = 0;
    } else {
      float waveStrenght = constrain(((height - mouseY)/60), 1, 15);
      particleSize = 4 + 0.15*sqrt( dY*dY*waveStrenght);
      println(particleSize);
      
    }
  }

  void drawTriangle(float x, float y, float angle, float radius) {

    pushMatrix();
    translate(x, y);
    //scale(radius);
    rotate(angle);

    triangle(-radius, -radius, radius, -radius, 0, radius);  
    popMatrix();
  }

  void render()
  {
    fill(c);
    noStroke();

    // float angle = atan2( position.y - mouseY, position.x - mouseX );
    drawTriangle( position.x, position.y, 0, particleSize);
    //triangle(position.x, position.y, position.x-2*particleSize, position.y-particleSize, position.x-2*particleSize, position.y+particleSize);
  }
}

class ParticleSystem
{
  Particle[] particles;

  ParticleSystem()
  {
    particles = new Particle[NUM_PARTICLES];
    for (int i = 0; i < NUM_PARTICLES; i++)
    {
      particles[i]= new Particle();
    }
  }

  void update()
  {
    for (int i = 0; i < NUM_PARTICLES; i++)
    {
      particles[i].update();
    }
  }

  void render()
  {
    for (int i = 0; i < NUM_PARTICLES; i++)
    {
      particles[i].render();
    }
  }
}
