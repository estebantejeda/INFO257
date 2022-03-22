PImage surface;
Particle[] particles;
float globalBestX, globalBestY, globalBest;
int evals = 0, evals_to_best = 0;

Config config = new Config();

void setup(){  
  size(1024,512); //size(1440,720)
  surface = loadImage(config.IMG_PATH);
  smooth();
  
  particlesInitialization();
}

void particlesInitialization(){
  particles = new Particle[config.POINTS];
  for (int i = 0; i < config.POINTS; i++) particles[i] = new Particle();
}

void draw(){
  image(surface,0,0);

  drawParticles();

  showBestInSurface();

  updateParticles();
  
}

void drawParticles(){
  for (int i = 0; i < config.POINTS; i++) particles[i].draw();
}

void showBestInSurface(){
  fill(#0000ff);
  circle(globalBestX,globalBestY,config.DISPLAY_RADIUS);
  PFont font = createFont("Arial",16,true);
  textFont(font,15);
  fill(#00ff00);
  text("Best fitness: "+str(globalBest)+"\nEvals to best: "+str(evals_to_best)+"\nEvals: "+str(evals),10,20);
}

void updateParticles(){
  for (int i = 0; i < config.POINTS; i++){
    particles[i].move();
    particles[i].evaluate();
  }
}
