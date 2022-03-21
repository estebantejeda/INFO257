class Particle{
  float x, y, fit; // current position(x-vector)  and fitness (x-fitness)
  float px, py, pfit; // position (p-vector) and fitness (p-fitness) of best solution found by particle so far
  float vx, vy; //vector de avance (v-vector)
  Config config = new Config();
  
  // ---------------------------- Constructor
  Particle(){
    x = random (width); y = random(height);
    vx = random(-1,1) ; vy = random(-1,1);
    pfit = -1; fit = -1; //asumiendo que no hay valores menores a -1 en la función de evaluación
  }
  
  // ---------------------------- Evalúa partícula
  float Eval(PImage surf){ //recibe imagen que define función de fitness
    evals++;
    color c=surf.get(int(x),int(y)); // obtiene color de la imagen en posición (x,y)
    fit = red(c); //evalúa por el valor de la componente roja de la imagen
    if(fit > pfit){ // actualiza local best si es mejor
      pfit = fit;
      px = x;
      py = y;
    }
    if (fit > gbest){ // actualiza global best
      gbest = fit;
      gbestx = x;
      gbesty = y;
      evals_to_best = evals;
      println(str(gbest));
    };
    return fit; //retorna la componente roja
  }
  
  // ------------------------------ mueve la partícula
  void move(){
    //actualiza velocidad (fórmula con factores de aprendizaje C1 y C2)
    //vx = vx + random(0,1)*config.C1*(px - x) + random(0,1)*config.C2*(gbestx - x);
    //vy = vy + random(0,1)*config.C1*(py - y) + random(0,1)*config.C2*(gbesty - y);
    //actualiza velocidad (fórmula con inercia, p.250)
    vx = config.w * vx + random(0,1)*(px - x) + random(0,1)*(gbestx - x);
    vy = config.w * vy + random(0,1)*(py - y) + random(0,1)*(gbesty - y);
    //actualiza velocidad (fórmula mezclada)
    //vx = config.w * vx + random(0,1)*config.C1*(px - x) + random(0,1)*config.C2*(gbestx - x);
    //vy = config.w * vy + random(0,1)*config.C1*(py - y) + random(0,1)*config.C2*(gbesty - y);
    // trunca velocidad a maxv
    float modu = sqrt(vx*vx + vy*vy);
    if (modu > config.MAX_VELOCITY){
      vx = vx/modu*config.MAX_VELOCITY;
      vy = vy/modu*config.MAX_VELOCITY;
    }
    // update position
    x = x + vx;
    y = y + vy;
    // rebota en murallas
    if (x > width || x < 0) vx = - vx;
    if (y > height || y < 0) vy = - vy;
  }
  
  // ------------------------------ despliega partícula
  void display(){
    color c=surf.get(int(x),int(y)); 
    fill(c);
    ellipse (x,y,config.DISPLAY_RADIUS,config.DISPLAY_RADIUS);
    // dibuja vector
    stroke(#ff0000);
    line(x,y,x-10*vx,y-10*vy);
  }
}
