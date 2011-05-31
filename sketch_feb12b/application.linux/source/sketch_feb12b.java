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

public class sketch_feb12b extends PApplet {

int colour = color(0,0,0);
int x = 0;
int MAGICNUMBER;
public void setup(){
 size(256,256);
 background(256,256,256);
 MAGICNUMBER = 101;
loadPixels(); 
}
public void draw(){
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
public boolean checkPixels(){
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


  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "sketch_feb12b" });
  }
}
