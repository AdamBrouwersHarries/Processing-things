import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class randomLine3 extends PApplet {

float direction = 1;
PVector speed = new PVector(0,1);
float pointDist = 0.5f;
float pointX;
float pointY;
float change;
public void setup(){
  size(1280,1024);
   pointX = width/2;
   pointY = height/2;
  background(100);
  point(pointX,pointY);
  point(pointX+pointDist,pointY+pointDist);
  point(pointX-pointDist,pointY-pointDist);
  point(pointX-pointDist,pointY+pointDist);
  point(pointX+pointDist,pointY-pointDist);
  stroke(200,200,200);
  point(pointX+pointDist,pointY);
  point(pointX-pointDist,pointY);
  point(pointX,pointY+pointDist);
  point(pointX,pointY-pointDist);
  stroke(0,0,0);
}

public void draw(){
  stroke(0,0,0);
  change = round(random(1,10));
  if(change ==10){
  direction = round(random(0,17)); 
  /*if(direction!=17){
    direction++;
  }else{
   direction =1; 
  }*/
  point(pointX,pointY);
  point(pointX+pointDist,pointY+pointDist);
  point(pointX-pointDist,pointY-pointDist);
  point(pointX-pointDist,pointY+pointDist);
  point(pointX+pointDist,pointY-pointDist);
  stroke(200,200,200);
  point(pointX+pointDist,pointY);
  point(pointX-pointDist,pointY);
  point(pointX,pointY+pointDist);
  point(pointX,pointY-pointDist);
  stroke(0,0,0);
  }
  //LEFT OR RIGHT
  //LEFT
   if(direction == 1){
   speed.set(-pointDist*2,0,0);
   }
   //RIGHT
   if(direction == 2){
   speed.set(pointDist*2,0,0); 
   }
   //DIAG UP-RIGHT.LEFT DOWN-RIGHT.LEFT
   //DOWN RIGHT
   if(direction == 3){
  speed.set(pointDist*2,pointDist*2,0); 
   }
   //LEFT DOWN
   if(direction == 4){
  speed.set(-pointDist*2,pointDist*2,0); 
   }
   //LEFT UP
   if(direction == 5){
   speed.set(-pointDist*2,-pointDist*2,0);
   }
   //RIGHT UP
   if(direction == 6){
   speed.set(pointDist*2,-pointDist*2,0); 
   }
   //UP DOWN
   //UP
   if(direction == 7){
   speed.set(0,-pointDist*2,0);
   }
   if(direction == 8){
   speed.set(0,pointDist*2,0); 
   }
   //LLD, LLD, RRU, RRD
   //LLD
   if(direction == 9){
  speed.set(-pointDist*2,pointDist,0); 
   }
   //LLU
   if(direction == 10){
  speed.set(-pointDist*2,-pointDist,0); 
   }
   //RRD
   if(direction == 11){
   speed.set(pointDist*2,pointDist,0);
   }
   //RRU
   if(direction == 12){
   speed.set(pointDist*2,-pointDist,0); 
   }
   //LDD, LUU, RUU, RDD
   //LDD
   if(direction == 13){
   speed.set(-pointDist,pointDist*2,0);
   }
   //LUU
   if(direction == 14){
   speed.set(-pointDist,-pointDist*2,0); 
   }
   //RUU
   if(direction == 16){
  speed.set(pointDist,-pointDist*2,0); 
   }
   //RDD
   if(direction == 17){
  speed.set(pointDist,pointDist*2,0); 
   }
   //----------
   if(pointX >= width){
  pointX = 1; 
   }
   if(pointX <= 0){
  pointX = width-1; 
   }
   if(pointY >= height){
  pointY = 1; 
   }
   if(pointY <= 0){
  pointY = height-1;
   } 
   pointX = pointX+speed.x;
   pointY = pointY+speed.y;
   point(pointX, pointY);
}
public void mousePressed() {
  exit();
}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "randomLine3" });
  }
}
