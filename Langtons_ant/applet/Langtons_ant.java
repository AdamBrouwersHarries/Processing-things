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

public class Langtons_ant extends PApplet {

//LANGTONS ANT PROGRAM
//program to simulate langtons ant
//directions:
//0 = up;
//1 = right;
//2 = down;
//3 = left
int direction;
// the ants x and y;
int x;
int y;
//colors for black and white for the ant
int black = color(0);
int white = color(256);
//setup function
public void setup()
{
  size(200,200);
  x = 100;
  y = 100;
  direction = 0;
  background(256,256,256);
  //frameRate(1);
}
//drawing function
public void draw()
{
  int c = get(x,y);
  if(c == black)
  {
    set(x,y, white);
    direction--;
    if(direction<0)
    {
      direction = 3;
    }
  }
  if(c == white)
  {
    set(x,y, black);
    direction++;
    if(direction>3)
    {
      direction = 0;
    }
  }
  switch(direction)
  {
  case 0:
    y++;
    break;
  case 1:
    x++;
    break;
  case 2:
    y--;
    break;
  case 3:
    x--;
    break;
  }
}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "Langtons_ant" });
  }
}
