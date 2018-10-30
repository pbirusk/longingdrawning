
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
    fill(255,0,0);
    ellipse(mouseX,mouseY,20,20);
    noFill();
  //************ Partikelsystem
  p.update();
  p.render();

}

float transitionFun(float x, float blurRadius){
     return 1.0/(1+exp(x/blurRadius));
}

class Particle
{
  PVector position, velocity;
  float partSpeed;
  color c;
  float particleSize = 4;
  float particleOriginalSize = 4;
  float waveLength = 100;
  float waveFrequency = 10;

  Particle()
  {
    position = new PVector(random(width), random(height));

    velocity = new PVector();
    partSpeed = random(0.9, 1.1);

    c = color(0, random(126-50, 126+50), 255, 200);
  }

  void update()
  {
    float r = sqrt( pow(position.x-mouseX,2) + pow(position.y-mouseY,2));
    
    float time = millis()/1000.0;
    float waveFactor = sin(2*PI*r/waveLength - waveFrequency*time);
  
    particleSize = pow(2, waveFactor)*particleOriginalSize;
    
    float radiusTop = 0;
    float radiusBottom = 4;
    float waveRadius = radiusTop+(radiusBottom-radiusTop)*float(mouseY)/height;
        
    float blurRadius = 100;
    float waveAlpha = 255*transitionFun( r - waveRadius*waveLength, blurRadius);

    c = color(red(c),green(c),blue(c), waveAlpha);
        
    position.add(velocity);
    if (position.x<0)position.x+=width;
    if (position.x>width)position.x-=width;
  }
  
  void drawTriangle(float x, float y, float angle, float radius){
    
    pushMatrix();
    translate(x, y);
    rotate(angle);
    
    triangle(-radius, -radius, radius, -radius, 0, radius);  
    popMatrix();
  }

  void render()
  {
    fill(c);
    noStroke();
    
    float angle = atan2( position.y - mouseY, position.x - mouseX );
    drawTriangle( position.x, position.y, angle + PI/2, particleSize);
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
