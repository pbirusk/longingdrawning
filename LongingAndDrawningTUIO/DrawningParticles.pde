class WaveParticles {
  color cW;
  void render() {
    for (int x = 0; x < width; x+=10) {
      for (int y = 0; y < height; y+=10) {
        strokeWeight(5);
        cW = color(255,50);
        stroke(cW);
        point(x,y);
      }
    }
  }
}
