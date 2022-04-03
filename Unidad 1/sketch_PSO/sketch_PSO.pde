PImage surface;
Particle[] particles; 
float globalBestX = 99999;
float globalBestY = 99999;
float globalBest = 99999; 
int evals = 0;
int evals_to_best = 0;
Environment environment = new Environment();

void setup(){  
  size(913,913);
  surface = loadImage(environment.IMG_PATH);
  smooth();

  particlesInitialization();
}

void particlesInitialization(){
  particles = new Particle[environment.NUMBER_OF_PARTICLES];
  for (int i = 0; i < environment.NUMBER_OF_PARTICLES; i++) particles[i] = new Particle();
}

void draw(){
  image(surface,0,0);  
  drawParticles();
  showBestInSurface();
  updateParticles();
}

void drawParticles(){
  for (int i = 0; i < environment.NUMBER_OF_PARTICLES; i++) particles[i].display();
}

void showBestInSurface(){
  fill(#0000ff);
  circle(globalBestX + environment.CENTER,globalBestY + environment.CENTER,environment.DISPLAY_RADIUS);
  PFont font = createFont("Arial",30,true);
  textFont(font,15);
  fill(#00ff00);
  text("Best fitness: "+str(globalBest)+"\nEvals to best: "+str(evals_to_best)+"\nEvals: "+str(evals),10,20);
}

void updateParticles(){
  for (int i = 0; i < environment.NUMBER_OF_PARTICLES; i++){
    particles[i].move();
    particles[i].evaluate();
  }
}
