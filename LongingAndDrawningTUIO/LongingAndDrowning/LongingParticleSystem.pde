class LongingParticleSystem
{
  LongingParticles[] particles;

  LongingParticleSystem()
  {
    particles = new LongingParticles[longingParticlesAmount];
    for (int i = 0; i < longingParticlesAmount; i++)
    {
      particles[i]= new LongingParticles();
    }
  }

  void update()
  {
    for (int i = 0; i < longingParticlesAmount; i++)
    {
      particles[i].update();
    }
  }

  void render()
  {
    for (int i = 0; i < longingParticlesAmount; i++)
    {
      particles[i].render();
    }
  }
}
