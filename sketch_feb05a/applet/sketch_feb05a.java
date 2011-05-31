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

public class sketch_feb05a extends PApplet {

float[] Xpos;
float[] Ypos;
float[] Xspeed;
float[] Yspeed;
float[] RED;
float[] GREEN;
float[] BLUE;
int MagicNumber = 8;
int OtherMagicNumber = 1;
public void setup(){
  size(1280,1024);
  background(10,10,10);
  Xpos = new float[width/MagicNumber];
  Ypos = new float[width/MagicNumber];
  Xspeed = new float[width/MagicNumber];
  Yspeed = new float[width/MagicNumber];
  RED = new float[width/MagicNumber];
  GREEN = new float[width/MagicNumber];
  BLUE= new float[width/MagicNumber];
  for(int x = 0;x<Xpos.length;x++){
    Xpos[x] = random(width);
    Ypos[x] = random(width);
    
    Xspeed[x] = random(-1,1);
    Yspeed[x] = random(-1,1);
    
    
    
    RED[x] = random(200);
    GREEN[x] = random(200);
    BLUE[x] = random(200);
    stroke(RED[x],GREEN[x],BLUE[x]);
    
    point(Xpos[x]-OtherMagicNumber,Ypos[x]);
    point(Xpos[x]+OtherMagicNumber,Ypos[x]);
    point(Xpos[x],Ypos[x]-OtherMagicNumber);
    point(Xpos[x],Ypos[x]+OtherMagicNumber);
    point(Xpos[x]-OtherMagicNumber,Ypos[x]-OtherMagicNumber);
    point(Xpos[x]-OtherMagicNumber,Ypos[x]+OtherMagicNumber);
    point(Xpos[x]+OtherMagicNumber,Ypos[x]-OtherMagicNumber);
    point(Xpos[x]+OtherMagicNumber,Ypos[x]+OtherMagicNumber);
    point(Xpos[x],Ypos[x]);
  }
}
public void draw(){
    //background(10,10,10);
 for(int x = 0;x<Xpos.length;x++){
      if(Xpos[x] >= width){
       Xpos[x] = width-2;
       Xspeed[x] =  Xspeed[x]/-1;
      }
      if(Xpos[x] <= 0){
       Xpos[x] = 2;
       Xspeed[x] =  Xspeed[x]/-1;
      }
      if(Ypos[x] >= height){
       Ypos[x] = height-2;
       Yspeed[x] =  Yspeed[x]/-1;
      }
      if(Ypos[x] <= 0){
       Ypos[x] = 2;
       Yspeed[x] =  Yspeed[x]/-1;
      }
      Xpos[x] += Xspeed[x];
        Ypos[x] += Yspeed[x];
        stroke(RED[x],GREEN[x],BLUE[x]);
        //line(Xpos[x],Ypos[x],Xpos[x]-Xspeed[x]/**30*/,Ypos[x]-Yspeed[x]/**30*/);
        if(mousePressed == false){
          point(Xpos[x],Ypos[x]);   
       }     
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "sketch_feb05a" });
  }
}
