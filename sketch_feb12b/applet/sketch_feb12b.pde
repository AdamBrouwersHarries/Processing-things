color colour = color(0,0,0);
int x = 0;
int MAGICNUMBER;
void setup(){
 size(256,256);
 background(256,256,256);
 MAGICNUMBER = 101;
loadPixels(); 
}
void draw(){
  if(checkPixels() == true){
    colour = color(random(256),random(256),random(256));
  }
  if(x<pixels.length){
  pixels[x] = colour;
  x+=MAGICNUMBER;
  updatePixels();
  }else{

   int y = MAGICNUMBER-(pixels.length-x);
   x = y;
  }
}
boolean checkPixels(){
      loadPixels();
      int z = 0;
      for(int x = 0; x<pixels.length;x++){
       if(pixels[x] == colour){
        z++;
       }
      }
      if(z == pixels.length){
          return true;
      }else{
       return false; 
      }
}

