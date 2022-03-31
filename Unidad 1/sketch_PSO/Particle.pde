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
    fitness = 0;
    performanceX = 0;
    performanceY = 0;
    performanceFitness = 0;
    velocityX = random(-1, 1);
    velocityY = random(-1, 1);
  }
  
  private float initializePosition(){
    return random(environment.DOMAIN_MIN,environment.DOMAIN_MAX);
  }
  
  void evaluate(){
    evals++;
    fitness = rastringinFunction(x, y);
    if(fitness < performanceFitness){
      performanceFitness = fitness;
      performanceX = x;
      performanceY = y;
    }
    if (fitness < globalBest){
      globalBest = fitness;
      globalBestX = x;
      globalBestY = y;
      evals_to_best = evals;
      println(str(globalBest));
    };
  }

  private float rastringinFunction(float x, float y){
    float componentX = delta(x);
    float componentY = delta(y);
    return 10*2 + componentX + componentY;
  }

  private float delta(float component){
    return pow(component, 2) - 10*cos(2*PI*component);
  }  
  
  void move(){
    selectVelocityType();
    float velocity = calculateModule();
    checkVelocityLimit(velocity);
    updatePosition();
  }

  private void selectVelocityType(){
    switch(environment.VELOCITY_TYPE){
      case 0:
        //actualiza velocidad (fórmula con factores de aprendizaje C1 y C2)
        velocityX = velocityX + random(0,1)*environment.C1*(performanceX - x) + random(0,1)*environment.C2*(globalBestX - x);
        velocityY = velocityY + random(0,1)*environment.C1*(performanceY - y) + random(0,1)*environment.C2*(globalBestY - y);
      case 1:
        //actualiza velocidad (fórmula con inercia, p.250)
        velocityX = environment.w * velocityX + random(0,1)*(performanceX - x) + random(0,1)*(globalBestX - x);
        velocityY = environment.w * velocityY + random(0,1)*(performanceY - y) + random(0,1)*(globalBestY - y);
      case 2:
        //actualiza velocidad (fórmula mezclada)
        velocityX = environment.w * velocityX + random(0,1)*environment.C1*(performanceX - x) + random(0,1)*environment.C2*(globalBestX - x);
        velocityY = environment.w * velocityY + random(0,1)*environment.C1*(performanceY - y) + random(0,1)*environment.C2*(globalBestY - y);
    }
  }

  private float calculateModule(){
    return sqrt(pow(velocityX,2) + pow(velocityY,2));
  }

  private void checkVelocityLimit(float velocity){
    if (velocity > environment.MAX_VELOCITY){
      velocityX = velocityX/velocity*environment.MAX_VELOCITY;
      velocityY = velocityY/velocity*environment.MAX_VELOCITY;
    }
  }

  private void updatePosition(){
    x = x + velocityX;
    y = y + velocityY;
  }
  
  void display(){
    color surfaceColor = getSurfaceColor();
    fill(surfaceColor);
    circle(x + environment.CENTER, y + environment.CENTER, environment.DISPLAY_RADIUS);
    stroke(#ff0000);
    line(x + environment.CENTER,y + environment.CENTER,(x + environment.CENTER) - 10*velocityX,(y + environment.CENTER) - 10*velocityY);
  }

  private color getSurfaceColor(){
    int intX = int(x);
    int intY = int(y);
    return surface.get(intX, intY);
  }

} 