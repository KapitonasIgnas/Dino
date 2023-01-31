int screenX = 900;
int screenY = 600;
int dinoSize = 65;
int defaultDinoY;
int dinoX = 50;
int dinoY;
boolean dinoIsUp;
int dinoSpeed = 5;
int defaultCactusX = screenX - 100;
int cactusSize = 95;
int backgroundLineY = screenY - 250;
int cactusX = defaultCactusX;
int cactusY = backgroundLineY - cactusSize;
int cactusSpeed = 5;
int score = 0;
boolean gameOver;
PImage dino;
PImage cactus;
PImage gameover;

void setup(){
  background(255);
  size(900,600);
  defaultDinoY = backgroundLineY - dinoSize;
  dino = loadImage("dino.png");
  cactus = loadImage("cactus.png");
  gameover = loadImage("gameover.jpg");
}

void draw(){
  staticBackground();
  
  if (gameOver) {
    image(gameover,170,50);
  }
  else {
    dinoMovement();
    cactusMovement();
  }
} //<>//

void staticBackground() {
  background(255);
  rect(0, backgroundLineY, screenX, 1);
  
  var s = "Score " + str(score);
  fill(0);
  text(s, 850, 10, 100, 20); 
}

void dinoMovement() {
  
  if (keyPressed) {
    if (key == 'w' && dinoY == defaultDinoY) { // kai paspaudziam w klavisa ir dino yra ant linijos
       dinoIsUp = true; // pazymim, kad dino kils i virsu
    }
    if (key == 'd') {
       dinoX += dinoSpeed;
    }   
    if (key == 'a') {
       dinoX -= dinoSpeed;
    }
  }
  
  if (dinoIsUp && dinoY >= cactusSize + 20) { // jei dino kyla i virsu ir Y didesnis uz kaktuso dydi ir dar 20 pixeliu       
     dinoY -= dinoSpeed; // mazinam Y kaktuso greiciu (pixeliais)
     if (dinoY > defaultDinoY) {
       dinoY = defaultDinoY;
     }
  }
  
  if (!dinoIsUp && dinoY < defaultDinoY) { // jei dino leiziasi ir dar nepasieke linijos       
    dinoY += dinoSpeed; // didinam Y
  }
        
  if (dinoY < defaultDinoY - cactusSize - 20) { // jei dino pasieke kaktuso auksti + 20 pixeliu - turim leistis zemyn
      dinoIsUp = false;
  }
  
   if (dinoY > backgroundLineY - cactusSize && dinoX <= cactusX + 20 && dinoX >= cactusX - 20){ // jei persikerta dino su kaktusu 
      gameOver = true;
   }
 
  image(dino, dinoX, dinoY);
}

void cactusMovement(){
  if (cactusX > -100) // jei kaktusas dar neisejes is ekrano
   cactusX = cactusX - cactusSpeed;
  else { // jei isejes is ekrano
   score += 1;
   cactusX = defaultCactusX;
   cactusSpeed = (int)random(10) + 1; 
 }
 
 image(cactus,cactusX,cactusY);
}

void mouseClicked() { 
   if (gameOver)
   {
      // nuresetinam
      gameOver = false;
      cactusX = defaultCactusX;
      dinoX = 50;
      score = 0;
      cactusSpeed = 5;
   }
}
