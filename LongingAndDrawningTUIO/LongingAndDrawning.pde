/**********************************************
 Deep Space mit durchgehendem Screen
 Wand:3030x1914
 Boden: 3030x1798 
 Gesamt: 3030x3712
 beides mit 30 Hz angesteuert. Vertikal erweiterter Desktop, Wand oberhalb vom Boden.
 DeepSpace 14,9x8,39m -> 202px/m  20px/dm  1px = 0,5cm
 **********************************************/

//*********** Bibliotheken
import TUIO.*;
TuioProcessing tuioClient = new TuioProcessing(this);
ArrayList<TuioCursor> tuioCursorList = new ArrayList<TuioCursor>();

//*********** Auflösung des DeepSpace und Skalierungsfaktor
int dsWidth = 3030;
int dsHeightFloor = 1798;
int dsHeightWall = 1914;
int indent = (dsHeightWall - dsHeightFloor)/2;
float sf = 0.25; // Scalefactor



//********Application specific
int longingParticlesAmount = 5000;
int drawningParticlesAmount = 5000;
LongingParticleSystem l;
DrawningParticles w;
int numUser = 8;
int displayUser = 1;
void setup() {
  //*********** DeepSpace Auflösung mit Scalefaktor 
  //size(3030, 3712);  // sf = 1.0
  //size(1515, 1856);  // sf = 0.5
  size(757, 928);    // sf = 0.25
  //fullScreen(P2D, SPAN);  // für den Deep Space !!!!! eventuell nur fullScreen(SPAN);

  //***********
  background(0);

  //********Application specific
  w = new DrawningParticles();
  l = new LongingParticleSystem();
  
}

void draw() {
  background(0);
  //*********** Kreise um die Personen
  noFill();
  strokeWeight(2*sf);
  stroke(0);
  ArrayList<TuioCursor> tuioCursorList = tuioClient.getTuioCursorList();
  for (int i=0; i<tuioCursorList.size (); i++) {  
    TuioCursor tc = tuioCursorList.get(i);
    // am Boden
    ellipse(tc.getScreenX(width), (dsHeightWall+tc.getScreenY(dsHeightFloor))*sf, 80*sf, 80*sf);
  }
  //************ Trennline zwischen Boden und Wand
  stroke(0, 0, 255);
  line(0, dsHeightWall*sf, width, dsHeightWall*sf);

  //************ Einrückungslinien zur Einschränkung auf die Bodenfläche
  stroke(255, 0, 0);
  line(0, indent*sf, dsWidth*sf, indent*sf);
  line(0, (dsHeightWall-indent)*sf, dsWidth*sf, (dsHeightWall-indent)*sf);

  //********Application specific

  l.update();
  l.render();
}
