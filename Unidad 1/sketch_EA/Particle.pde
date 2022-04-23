class Particle{
  float x;
  float y;
  float fitness;
  float performanceX;
  float performanceY;
  float performanceFitness;
  float velocityX;
  float velocityY;
  
  Particle(){
    x = initializePosition(); 
    y = initializePosition();
    fitness = -1;
    performanceX = -1;
    performanceY = -1;
    performanceFitness = -1;
    velocityX = random(-1, 1);
    velocityY = random(-1, 1);
  }

  private float initializePosition(){
    return random(config.DOMAIN_MIN, config.DOMAIN_MAX);
  }

  void evaluate(){
    evals++;
    fitness = rastringinFunction(x, y);
    if (isFitnessBetter(performanceFitness)) updatePerformance();
    if (isFitnessBetter(globalBest)) updateGlobalBest();
  }

  private float rastringinFunction(float x, float y){
    float componentX = delta(x);
    float componentY = delta(y);
    return 10*2 + componentX + componentY;
  }

  private float delta(float component){
    return pow(component, 2) - 10*cos(2*PI*component);
  }

  private color getSurfaceColor(){
    int intX = int(x);
    int intY = int(y);
    return surface.get(intX, intY);
  }

  private boolean isFitnessBetter(float compare){
    return fitness < compare;
  }

  private void updatePerformance(){
    performanceFitness = fitness;
    performanceX = x;
    performanceY = y;
  }

  private void updateGlobalBest(){
    globalBest = fitness;
    globalBestX = x;
    globalBestY = y;
    evals_to_best = evals;
    println(str(globalBest));
  }
  
  void move(){    
    selectVelocityType();

    float velocity = calculateModule();
    checkVelocityLimit(velocity);

    updatePosition();
    checkWalls();
  }

  private void selectVelocityType(){
    switch(config.VELOCITY_TYPE){
      case 0:
        //actualiza velocidad (fórmula con factores de aprendizaje C1 y C2)
        velocityX = velocityX + random(0,1)*config.C1*(performanceX - x) + random(0,1)*config.C2*(globalBestX - x);
        velocityY = velocityY + random(0,1)*config.C1*(performanceY - y) + random(0,1)*config.C2*(globalBestY - y);
      case 1:
        //actualiza velocidad (fórmula con inercia, p.250)
        velocityX = config.w * velocityX + random(0,1)*(performanceX - x) + random(0,1)*(globalBestX - x);
        velocityY = config.w * velocityY + random(0,1)*(performanceY - y) + random(0,1)*(globalBestY - y);
      case 2:
        //actualiza velocidad (fórmula mezclada)
        velocityX = config.w * velocityX + random(0,1)*config.C1*(performanceX - x) + random(0,1)*config.C2*(globalBestX - x);
        velocityY = config.w * velocityY + random(0,1)*config.C1*(performanceY - y) + random(0,1)*config.C2*(globalBestY - y);
    }
  }

  private float calculateModule(){
    return sqrt(velocityX*velocityX + velocityY*velocityY);
  }

  private void checkVelocityLimit(float velocity){
    if (velocity > config.MAX_VELOCITY){
      velocityX = velocityX/velocity*config.MAX_VELOCITY;
      velocityY = velocityY/velocity*config.MAX_VELOCITY;
    }
  }

  private void updatePosition(){
    x = x + velocityX;
    y = y + velocityY;
  }

  private void checkWalls(){
    checkWidthWall();
    checkHeightWall();
  }

  private void checkWidthWall(){
    if (x > width || x < 0) velocityX = -velocityX;
  }

  private void checkHeightWall(){
    if (y > height || y < 0) velocityY = -velocityY;
  }

  void draw(){
    color surfaceColor = getSurfaceColor();
    fill(surfaceColor);
    circle(x,y,config.DISPLAY_RADIUS);
    stroke(#ff0000);
    line(x,y,x-10*velocityX,y-10*velocityY);
  }

}
