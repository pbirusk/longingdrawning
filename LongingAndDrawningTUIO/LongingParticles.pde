class LongingParticles
{
  float transitionFun(float x, float blurRadius) {
    return 1.0/(1+exp(x/blurRadius));
  }


  PVector position, velocity;
  float partSpeed;
  color c;
  float particleSize = 5;
  float particleOriginalSize = 4*sf;
  float waveLength = 30;
  float waveFrequency = 10;
  ArrayList<TuioCursor> activeTuioCursorList;

  LongingParticles()
  {
    position = new PVector(random(width), (dsHeightWall+random(dsHeightFloor))*sf);
    activeTuioCursorList = new ArrayList<TuioCursor>();
    velocity = new PVector();
    partSpeed = random(0.9, 1.1);

    c = color(0, random(126-50, 126+50), 255, 200);
  }

  void update()
  {
    for (int i=tuioCursorList.size()-1; i>=max(0, tuioCursorList.size()-numUser); i--) {   //<>//
      TuioCursor tc = tuioCursorList.get(i);
      float r = sqrt( pow(position.x-tc.getScreenX(width), 2) + pow(position.y-mouseY, 2));



      float time = millis()/2000.0;
      float waveFactor = sin(2*PI*r/waveLength - waveFrequency*time);

      particleSize = pow(2, waveFactor)*particleOriginalSize;

      float radiusTop = 1*sf;
      float radiusBottom = 10*sf;
      float waveRadius = radiusTop+(radiusBottom-radiusTop)*float(mouseY)/height;

      float blurRadius = 5;
      float waveAlpha = 255*transitionFun( r - waveRadius*waveLength, blurRadius);

      c = color(red(c), green(c), blue(c), waveAlpha);
    }
    position.add(velocity);
    if (position.x<0)position.x+=width;
    if (position.x>width)position.x-=width;
  }
  void drawTriangle(float x, float y, float angle, float radius) {

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
    //
    if (displayUser == 1) {
      for (int i=tuioCursorList.size()-1; i>=max(0, tuioCursorList.size()-numUser); i--) {  
        TuioCursor tc = tuioCursorList.get(i);
        float angle = atan2( position.y - mouseY, position.x - mouseX );
        // am Boden
        //ellipse(tc.getScreenX(width), (dsHeightWall+tc.getScreenY(dsHeightFloor))*sf, particleSize, particleSize);
        drawTriangle( tc.getScreenX(width), tc.getScreenY(dsHeightFloor), angle + PI/2, particleSize);
      }
    }
    //drawTriangle( position.x, position.y, angle + PI/2, particleSize);
    //triangle(position.x, position.y, position.x-2*particleSize, position.y-particleSize, position.x-2*particleSize, position.y+particleSize);
  }
}
