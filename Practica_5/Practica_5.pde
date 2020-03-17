import peasy.*;

String wallPath = "Wall/Models and Textures/wall.obj";
String plantPath = "eb_house_plant_01/eb_house_plant_01.obj";
String floorPath = "Cobblestones2/Files/CobbleStones2.obj";
PShape wall, plant, floor;
PeasyCam cam;

enum LigthTypes{
  greenLed,
  front,
  basic,
  point,
  spot;
}

LigthTypes[] ligthTypes = {LigthTypes.greenLed, LigthTypes.front, LigthTypes.basic, LigthTypes.point, LigthTypes.spot};
int typeIndex = 0;
int x, y;

void setup(){
  size(800, 800, P3D);
  setupWall();
  setupPlant();
  floor = loadShape(floorPath);
  floor.scale(30);
  x = int(0.75 * width);
  y = int(0.55 * height);
  cam = new PeasyCam(this, x- width / 6, y, 350, 300);
}

void setupWall(){
  wall = loadShape(wallPath);
  wall.scale(15);
  wall.rotateX(radians(180));
}

void setupPlant(){
  plant = loadShape(plantPath);
  plant.rotateX(radians(180));
}

void draw(){
  background(200);
  info();  
  getLigth();
  
  pushMatrix();
  rotateY(radians(-45));
  rotateX(radians(-15));
  translate(x, y);
  pushMatrix();
  translate(0, -8, 0);
  shape(floor);
  popMatrix();
  shape(wall); 
  translate(0, 0, 40);
  shape(plant);
  popMatrix();
}

void info(){
  fill(0);
  cam.beginHUD();
  text("\"Right and Left click\" to change ligth effect", 20, 20);
  text("\"Left click and drag\" to rotate", 20, 35);
  text("\"Mouse wheel\" to zoom", 20, 50);
  cam.endHUD();
}

void getLigth(){
  if (ligthTypes[typeIndex] == LigthTypes.greenLed){
    greenLedLigth();
  }else if (ligthTypes[typeIndex] == LigthTypes.front){
    frontLigth();
  }else if(ligthTypes[typeIndex] == LigthTypes.basic){
    basicLigth();
  }else if(ligthTypes[typeIndex] == LigthTypes.point){
    pointLigth();
  }else if(ligthTypes[typeIndex] == LigthTypes.spot){
    spotLigth();
  }
}

void greenLedLigth(){
  lights();
  directionalLight(50,200,50,-1,0,0);
}

void frontLigth(){
  lights();
  directionalLight(255, 255, 255, 0, 0, -1);
}

void basicLigth(){
  ambientLight(200, 200, 200);
}

void pointLigth(){
  pointLight(204,153,0,x,y,400);
  lightSpecular(100, 100, 00);
  directionalLight(0.8,0.8,0.8,-1,0,0);
}


void spotLigth(){
  spotLight(204,153,0,x - 100,y - 20,500,0,0,-1,PI/2,10);
  lightSpecular(100, 100, 00);
  directionalLight(0.8,0.8,0.8,-1,0,0);
}


void mousePressed(){
  if (mouseButton == LEFT){
    typeIndex = (typeIndex + 1) % ligthTypes.length;
  }else if (mouseButton == RIGHT){
    typeIndex = (typeIndex == 0) ? ligthTypes.length - 1 : typeIndex - 1;
  }
}
