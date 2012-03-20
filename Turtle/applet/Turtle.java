import processing.core.*; 
import processing.xml.*; 

import java.util.ArrayList; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Turtle extends PApplet {


PTurtle eric;
String koch_values;
float koch_length = 5;
int iterations = 3;
public void setup()
{
  size(1200,600);
  background(0,0,0);
  stroke(255,255,255);
  eric = new PTurtle(width/2,height/2);
  koch_values = new String();
  koch_values="F";
  koch_curve(iterations);
  koch_length = (width-20)/(pow(3,iterations));
  //println(koch_values);
}
public void draw()
{
  background(0,0,0);
  eric.x = 10;
  eric.y = height-10;
  eric.angle = PI/2;
  float t_angle = PI/2;
  for(int i = 0;i<koch_values.length();i++)
  {
    if(koch_values.charAt(i) == 'F')
    {
      eric.Forward(koch_length);
    }
    if(koch_values.charAt(i) == '+')
    {
      eric.tleft(t_angle);
    }
    if(koch_values.charAt(i) == 'o')
    {
      eric.tright(t_angle);
    }
  }
}
public void koch_curve(int iterations)
{
  
  for(int i = 0;i<iterations;i++)
  {
    String new_koch = new String();
    for(int j = 0;j<koch_values.length();j++)
    {
      if(koch_values.charAt(j) == 'F')
      {
        new_koch+="F+FoFoF+F";
      }
      if(koch_values.charAt(j) == '+')
      {
        new_koch+='+';
      }
      if(koch_values.charAt(j) == 'o')
      {
        new_koch+='o';
      }
    }
    koch_values = new_koch;
      //println(new_koch);
  }

  
}
public void copy_string(String from, String to)
{
  to = "";
  for(int i = 0;i<from.length();i++)
  {
    to+=from.charAt(i);
  }
}
public int power(int base, int exponent)
{
  if(exponent==0)
  {
    return 1;
  }
  if(exponent == 1)
  {
    return base;
  }
  int r = base;
  for(int i = 2;i<=exponent;i++)
  {
    r = r*base;
  }
  return r;
}
public void keyPressed() {
  if(key == '+')
  {
    if(iterations<6)
    {
      iterations++;
      println("+");
    }
  }
  if(key == '-')
  {
    if(iterations>0)
    {
      iterations--;
      println("-");
    }
  }
  koch_values = "F";
  koch_curve(iterations);
  koch_length = (width-20)/(pow(3,iterations));
  println(iterations);
}
class PTurtle
{
  boolean penDown;
  float angle;//angle measured clockwise from 12:00, in radians
  float x, y;
  PTurtle()
  {
    penDown = true;
    angle = x = y = 0.0f;
  }
  PTurtle(float i, float j)
  {
    penDown = true;
    angle = 0.0f;
    x = i;
    y = j;
  }
  public void Forward(float distance)
  {
    float xdist = sin(angle)*distance;
    float ydist = cos(angle)*distance;
    float xnew = x+xdist;
    float ynew = y-ydist;
    if(penDown == true)
    {
      line(xnew,ynew,x,y);
    }
    x = xnew;
    y = ynew;
  }
  public void Back(int distance)
  {
    Forward(-distance);
  }
  public void trotate(float a)
  {
    angle=angle+a;
  }
  public void tright(float a)
  {
    trotate(a);
  }
  public void tleft(float a)
  {
    trotate(-a);
  }
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#F0F0F0", "Turtle" });
  }
}
