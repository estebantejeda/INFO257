// PSO de acuerdo a Talbi (p.247 ss)

PImage surf; // imagen que entrega el fitness

Config conf = new Config();

// ===============================================================
Particle[] fl; // arreglo de partículas
float gbestx, gbesty, gbest; // posición y fitness del mejor global
int evals = 0, evals_to_best = 0; //número de evaluaciones, sólo para despliegue
float maxv = 3; // max velocidad (modulo)

Config config = new Config();

// dibuja punto azul en la mejor posición y despliega números
void despliegaBest(){
  fill(#0000ff);
  ellipse(gbestx,gbesty,config.DISPLAY_RADIUS,config.DISPLAY_RADIUS);
  PFont f = createFont("Arial",16,true);
  textFont(f,15);
  fill(#00ff00);
  text("Best fitness: "+str(gbest)+"\nEvals to best: "+str(evals_to_best)+"\nEvals: "+str(evals),10,20);
}

// ===============================================================

void setup(){  

  size(1024,512); //size(1440,720)
  surf = loadImage(config.IMG_PATH);
  
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  smooth();
  // crea arreglo de objetos partículas
  fl = new Particle[config.POINTS];
  for(int i =0;i<config.POINTS;i++)
    fl[i] = new Particle();
}

void draw(){
  //background(200);
  //despliega mapa, posiciones  y otros
  image(surf,0,0);
  for(int i = 0;i<config.POINTS;i++){
    fl[i].display();
  }
  despliegaBest();
  //mueve puntos
  for(int i = 0;i<config.POINTS;i++){
    fl[i].move();
    fl[i].Eval(surf);
  }
  
}
