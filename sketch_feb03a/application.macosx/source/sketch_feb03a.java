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

public class sketch_feb03a extends PApplet {

float[] xpoints;
float[] ypoints;
float[] pointColor;
float[] Xspeed;
float[] Yspeed;
public void setup(){
 size(1280,1024);
 background(0,0,0);
xpoints = new float[1000];
ypoints = new float[1000];
Xspeed = new float[1000];
Yspeed = new float[1000];
pointColor = new float[1000];
for(int x = 0;x<xpoints.length;x++){
 xpoints[x] = random(width);
 ypoints[x] = random(width);
 pointColor[x] = 256;
}
}
public void draw(){
 for(int x = 0; x<xpoints.length;x++){
  if(xpoints[x] >= width){
    xpoints[x] =1;
    if(pointColor[x]<=0){
   pointColor[x] = 256;
  }else{
   pointColor[x]--;  
  }
  }
  if(xpoints[x] <= 0){
    xpoints[x] =width-1;
    if(pointColor[x]<=0){
   pointColor[x] = 256;
  }else{
   pointColor[x]--;  
  }
  }
  if(ypoints[x] >= height){
    ypoints[x] = 1;
    if(pointColor[x]<=0){
   pointColor[x] = 256;
  }else{
   pointColor[x]--;  
  }
  }
  if(ypoints[x] <= 0){
    ypoints[x] =height-1;
    if(pointColor[x]<=0){
   pointColor[x] = 256;
  }else{
   pointColor[x]--;  
  }
  }
  stroke(pointColor[x],pointColor[x],pointColor[x]);
  point(xpoints[x],ypoints[x]);
  Xspeed[x] = random(-2,2);
  Yspeed[x] = random(-2,2);  
  xpoints[x]+= Xspeed[x];
  ypoints[x]+= Yspeed[x];
  stroke(0,0,0);
  point(xpoints[x],ypoints[x]);
 }  
}
public void mousePressed() {
  exit();
}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "sketch_feb03a" });
  }
}
