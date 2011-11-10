float directionX = 1;
float directionY = 1;
float determiner;
int speed = 5;
float POINTX;
    float POINTY;
int direction = 1;
float pointX;
float pointY;
void setup(){
  frameRate(1200);
 //size(speed*100,speed*100);
 size(800,400);
  pointX = width/2;
 pointY = height/2;
background(0,0,0); 
stroke(143,123,213);
}
void draw(){
  switch(direction){
    case 1:
      determiner = round(random(1,2));
      if(determiner == 1){
        direction = 4;
      }else{
        direction = 2;
      }
    break;
    case 4:
      determiner = round(random(1,2));
      if(determiner == 1){
        direction = 1;
      }else{
        direction = 3;
      }
    break;
    case 2:
      determiner = round(random(1,2));
      if(determiner == 1){
        direction = 3;
      }else{
        direction =1;
      }
    break;
    case 3:
      determiner = round(random(1,2));
      if(determiner == 1){
        direction = 2;
      }else{
        direction = 4;
      }
    break;
  }
  switch(direction){
    case 1:
      directionX = 1;
      directionY = 1;
    break;
    case 4:
      directionX = -1;
      directionY = 1;
    break;
    case 2:
      directionX = 1;
      directionY = -1;
    break;
    case 3:
      directionX = -1;
      directionY = -1;
    break;
  }
  loadPixels();
  color S = get(int(POINTX+directionX),int(POINTY+directionY));
  if(S == color(0,0,0)){
   S= color(250,250,250); 
  }
  float RED = red(S)-50;
  float GREEN = green(S)-50;
  float BLUE = blue(S)-50;
  S = color(RED,GREEN,BLUE);
  //stroke(random(100,256));
  //stroke(noise(pointX,pointY)*256);
  stroke(pointX,pointY,256);
  for(int x = 0; x<speed-1; x++){
    POINTX = directionX*x + pointX;
    POINTY = directionY*x + pointY;
   point(POINTX,POINTY); 
  }
  pointX = pointX + directionX*speed;
  pointY = pointY + directionY*speed;
  if(pointX <= -speed-2){
    pointX = width;
  }
  if(pointX >= width+speed+2){
    pointX = 0;
  }
  if(pointY <= -speed-2){
    pointY = height;
  }
  if(pointY >= height+speed+2){
    pointY = 0;
  }
}
