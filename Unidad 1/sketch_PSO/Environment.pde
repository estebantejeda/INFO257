class Environment {
    int NUMBER_OF_PARTICLES;
    float DISPLAY_RADIUS;
    float w;
    float C1;
    float C2;
    float MAX_VELOCITY;
    String IMG_PATH;
    int VELOCITY_TYPE;
    float DOMAIN_MIN;
    float DOMAIN_MAX;
    float INITIAL_GLOBAL;
    int CENTER;

    Environment(){
        NUMBER_OF_PARTICLES = 100;
        DISPLAY_RADIUS = 15;
        w = 1000; // inercia: baja (~50): explotación, alta (~5000): exploración (2000 ok)
        C1 = 30; // learning factors (C1: own)
        C2 = 10; // learning factors (C2: social)
        MAX_VELOCITY = 3;
        IMG_PATH = "./img/Rastrigin_Surface.png";
        VELOCITY_TYPE = 0;
        DOMAIN_MIN = -5.12;
        DOMAIN_MAX = 5.12;
        INITIAL_GLOBAL = 99999;
        CENTER = 457; // constante que centra las partículas en la imagen
    }
}
