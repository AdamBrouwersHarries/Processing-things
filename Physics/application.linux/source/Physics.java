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

public class Physics extends PApplet {

Maths m;
Circle c_a[];
int circlecount = 40;
public void setup()
{
  println("STARTED");
  cursor(CROSS);
  size(900,900);
  background(255);
  m = new Maths();
  c_a = new Circle[circlecount];
  for(int i=0;i<circlecount;i++)
  {
    c_a[i] = new Circle(0,25,40);
    c_a[i].VELOCITY = new Vector(0,0);
  }
  Shuffle();
}
public void draw()
{
  background(255);
  stroke(0);
  for(int i = 0;i<circlecount;i++)
  {
    for(int j = 0;j<circlecount;j++)
    {
      if(j!=i)
      {
        if(m.CircleCircleTest(c_a[i],c_a[j])==true)
        {
          m.BounceBalls(c_a[i],c_a[j]);
          
        }
      }
    }
    c_a[i].Update();
    c_a[i].Render();
  }
}
public void Shuffle()
{
  for(int i = 0;i<circlecount;i++)
  {
    c_a[i]._x = width/2;//random(width);
    c_a[i]._y = height/2;//random(height);
    c_a[i].VELOCITY = new Vector(random(2)-random(2),random(2)-random(2));
  }
  boolean noCol = false;
  while(noCol==false)
  {
    boolean tempcol = true;
    for(int i = 0;i<circlecount;i++)
    {
      for(int j = 0;j<circlecount;j++)
      {
        if(m.CircleCircleTest(c_a[i],c_a[j])== true)
        {
          tempcol = true;
          m.ResolveCircleCollision(c_a[i],c_a[j]);
        }
      }
    }
    if(tempcol == true)
    {
      noCol = true;
    }
  }
}
public void mousePressed()
{
Shuffle();  
}
public void mouseReleased()
{

}






class Circle
{
  float _x,_y,_r,_m;
  Vector VELOCITY;
  Circle()
  {
    _x = 0;
    _y = 0;
    _r = 1;
    _m = _r*0.1f;
    VELOCITY = new Vector(0,0);
  }
  Circle(float pX, float pY, float pR)
  {
    _x = pX;
    _y = pY;
    _r=pR;
    _m = _r*0.1f;
    VELOCITY = new Vector(0,0);
  }
  public void Update()
  {
    CheckBoundaryCollision(0,width,0,height);

    this._x+=VELOCITY._x;
    this._y+=VELOCITY._y;
  }
  public void Render()
  {
    float px, py,x,y;
    x = (float)_r * cos(359 * PI/180.0f)+_x;
    y = (float)_r * sin(359 * PI/180.0f)+_y;
    px = x;
    py = y;
    for(int j = 0; j < 360; j+=2)
    {
      x = (float)_r * cos(j * PI/180.0f)+_x;
      y = (float)_r * sin(j * PI/180.0f)+_y;
      line(px,py,x,y);
      px = x;
      py = y;
    }
    x = (float)_r * cos(359 * PI/180.0f)+_x;
    y = (float)_r * sin(359 * PI/180.0f)+_y;
    line(px,py,x,y);
  }
  public void CheckBoundaryCollision(float lx,float rx,float ty,float by)
  {
    if(_x<(lx+_r))
    {
      _x = lx+_r;
      VELOCITY._x*=-1;
    }
    if(_x>(rx-_r))
    {
      _x = rx-_r;
      VELOCITY._x*=-1;  
    }
    if(_y<(ty+_r))
    {
      _y = ty+_r;
      VELOCITY._y*=-1;
    }
    if(_y>(by-_r))
    {
      _y = by-_r;
      VELOCITY._y*=-1;
    }
  }
}


class Line
{
  public float X1,Y1,X2,Y2,m;
  Line(float x1,float y1, float x2, float y2)
  {
    X1 = x1;
    Y1 = y1;
    X2 = x2;
    Y2 = y2;
    m = (Y1-Y2)/(X1-X2);
  }
  public void Render()
  {
    line(X1,Y1,X2,Y2);
  }
}
class Maths
{
  Maths()
  {
  }
  public boolean LineLineTest(Line l1, Line l2)
  {
    float denom = ((l2.Y2-l2.Y1)*(l1.X2-l1.X1))-
      ((l2.X2-l2.X1)*(l1.Y2-l1.Y1));
    float num_a = ((l2.X2-l2.X1)*(l1.Y1-l2.Y1))-
      ((l2.Y2-l2.Y1)*(l1.X1-l2.X1));
    float num_b = ((l1.X2-l1.X1)*(l1.Y1-l2.Y1))-
      ((l1.Y2-l1.Y1)*(l1.X1-l2.X1));
    if(denom == 0.0f)
    {
      if(num_a == 0.0f&&num_b == 0.0f)
      {
        return true;
      }
      else{
        return false;
      }
    }
    float ua = num_a/denom;
    float ub = num_b/denom;
    if(ua >= 0.0f && ua <= 1.0f && ub >= 0.0f && ub <= 1.0f)
    {
      return true;
    }
    return false;
  }
  public Vector LineLineIntersection(Line l1, Line l2)
  {
    Vector crossPoint = new Vector(-1,-1);
    float denom = ((l2.Y2-l2.Y1)*(l1.X2-l1.X1))-
      ((l2.X2-l2.X1)*(l1.Y2-l1.Y1));
    float num_a = ((l2.X2-l2.X1)*(l1.Y1-l2.Y1))-
      ((l2.Y2-l2.Y1)*(l1.X1-l2.X1));
    float num_b = ((l1.X2-l1.X1)*(l1.Y1-l2.Y1))-
      ((l1.Y2-l1.Y1)*(l1.X1-l2.X1));
    float ua = num_a/denom;
    float ub = num_b/denom;
    if(ua >= 0.0f && ua <= 1.0f && ub >= 0.0f && ub <= 1.0f)
    {
      crossPoint._x = l1.X1+ua*(l1.X2-l1.X1);
      crossPoint._y = l1.Y1+ua*(l1.Y2-l1.Y1);
    }
    return crossPoint;
  }
  public boolean CircleCircleTest(Circle c1, Circle c2)
  {
    float distance = sqrt(((c2._x-c1._x)*(c2._x-c1._x))+((c2._y-c1._y)*(c2._y-c1._y)));
    float totalRadius = c1._r+c2._r;
    if(distance<totalRadius)
    {
      return true;
    }
    else{
      return false;
    }
  }
  public void ResolveCircleCollision(Circle c1, Circle c2)
  {
    Vector collisionPoint = new Vector((c1._x+c2._x)/2,(c1._y+c2._y)/2);
    float c1Atp, c2Atp;
    c1Atp = atan2(c1._x-collisionPoint._x,c1._y-collisionPoint._y);
    c2Atp = atan2(c2._x-collisionPoint._x,c2._y-collisionPoint._y);
    
    
    float c1dist, c2dist;
    c1dist = c1._r-sqrt(((c1._x-collisionPoint._x)*(c1._x-collisionPoint._x))+((c1._y-collisionPoint._y)*(c1._y-collisionPoint._y)));
    c2dist = c2._r- sqrt(((c2._x-collisionPoint._x)*(c2._x-collisionPoint._x))+((c2._y-collisionPoint._y)*(c2._y-collisionPoint._y)));
    Vector c1DTP, c2DTP;
    c1DTP = new Vector(sin(c1Atp)*c1dist,cos(c1Atp)*c1dist);
    c2DTP = new Vector(sin(c2Atp)*c2dist,cos(c2Atp)*c2dist);
    
    
    c1._x+=c1DTP._x;
    c1._y+=c1DTP._y;
    c2._x+=c2DTP._x;
    c2._y+=c2DTP._y;
    
    
  }
  public Vector VSub(Vector v1, Vector v2)
  {
    return new Vector(v1._x-v2._x,v1._y-v2._y);
  }
  public void BounceBalls(Circle c1,Circle c2)
  {
    //Circle 1 is the b[0] in the original algorythm
    //Circle 2 is the b[1] in the original algorythm
    //vector bettween two balls centres.
    ResolveCircleCollision(c1,c2);
    Vector bVect = new Vector(c2._x-c1._x,c2._y-c1._y);
    //actual distance bettween two centres (the hypotenuse or magnitude of vector)
    float bVectMag = sqrt((bVect._x*bVect._x)+(bVect._y*bVect._y));
    //angle of vector
    float theta = atan2(bVect._y,bVect._x);
    //the sine and cosine values of the angle:
    float sine = sin(theta);
    float cosine = cos(theta);
    //initialise temporary circles to act as holders
    Circle c1TEMP, c2TEMP;
    c1TEMP = new Circle();
    c2TEMP = new Circle();
    //Temp for the second ball
    //rotate the balls location
    c2TEMP._x = cosine*bVect._x+sine*bVect._y;
    c2TEMP._y = cosine*bVect._y-sine*bVect._x;

    //rotate temp velocitys
    c1TEMP.VELOCITY._x =cosine*c1.VELOCITY._x+sine*c1.VELOCITY._y;
    c1TEMP.VELOCITY._y =cosine*c1.VELOCITY._y-sine*c1.VELOCITY._x;
    c2TEMP.VELOCITY._x =cosine*c2.VELOCITY._x+sine*c2.VELOCITY._y;
    c2TEMP.VELOCITY._y =cosine*c2.VELOCITY._y-sine*c2.VELOCITY._x;

    Vector vf1, vf2;
    vf1 = new Vector(0,0);
    vf2 = new Vector(0,0);
    //use the conservation of momentum to work out the final velocity...
    // final rotated velocity for c1
    vf1._x = ((c1._m - c2._m) * c1TEMP.VELOCITY._x + 2 * c2._m *  c2TEMP.VELOCITY._x) / (c1._m + c2._m);
    vf1._y = c1TEMP.VELOCITY._y;
    // final rotated velocity for c1
    vf2._x = ((c2._m - c1._m) * c2TEMP.VELOCITY._x + 2 * c1._m *c1TEMP.VELOCITY._x) / (c1._m + c2._m);
    vf2._y = c2TEMP.VELOCITY._y;

    c1TEMP._x += vf1._x;
    c2TEMP._x += vf2._x;

    Vector bf1,bf2;
    bf1 = new Vector(0,0);
    bf2 = new Vector(0,0);

    bf1._x =cosine * c1TEMP._x - sine * c1TEMP._y;
    bf1._y =cosine * c1TEMP._y + sine * c1TEMP._x;

    bf2._x =cosine * c2TEMP._x - sine * c2TEMP._y;
    bf2._y =cosine * c2TEMP._y + sine * c2TEMP._x;

    //update the positions
    c2._x = c1._x+bf2._x;
    c2._y = c1._y+bf2._y;
    c1._x = c1._x+bf1._x;
    c1._y = c1._y+bf1._y; 

    //update velocities
    c1.VELOCITY._x = cosine * vf1._x - sine * vf1._y;
    c1.VELOCITY._y = cosine * vf1._y + sine * vf1._x;
    c2.VELOCITY._x = cosine * vf2._x - sine * vf2._y;
    c2.VELOCITY._y = cosine * vf2._y + sine * vf2._x;
  }
}



class Vector
{
  float _x,_y;
  Vector()
  {
  }
  Vector(float X,float Y)
  {
    _x = X;
    _y = Y;
  }
}
class World
{
  ArrayList Circle_array;
  ArrayList Line_array;
  World()
  {
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#f0f0f0", "Physics" });
  }
}
