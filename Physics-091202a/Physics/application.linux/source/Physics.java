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

World w;
public void setup()
{
  println("STARTED");
  cursor(CROSS);
  size(900,600);
  background(255);
  w = new World();
}
public void draw()
{
  background(255);
  w.UPDATE();
}
public void mousePressed()
{
  w.mp();
}
public void mouseReleased()
{
  w.mr();
}
public void mouseDragged()
{
  w.md();
}
public void keyPressed()
{
  w.bp();
}
public void keyReleased()
{
  w.br();
}







class AABB
{
  float _x1, _x2, _y1, _y2;
  boolean i;
  AABB(float _x1,float _x2, float _y1, float _y2)
  {
    this._x1 = _x1;
    this._x2 = _x2;
    this._y1 = _y1;
    this._y2 = _y2;
    i = false;
  }
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
    beginShape();
    float px, py,x,y;
    x = (float)_r * cos(359 * PI/180.0f)+_x;
    y = (float)_r * sin(359 * PI/180.0f)+_y;
    for(int j = 0; j < 360; j+=2)
    {
      curveVertex(x,y);
      x = (float)_r * cos(j * PI/180.0f)+_x;
      y = (float)_r * sin(j * PI/180.0f)+_y;      
    }
    x = (float)_r * cos(359 * PI/180.0f)+_x;
    y = (float)_r * sin(359 * PI/180.0f)+_y;
    curveVertex(x,y);
    endShape(CLOSE);
  }
  public void CheckBoundaryCollision(float lx,float rx,float ty,float by)
  {
    if(_x<(lx+_r))
    {
      _x = lx+_r*1.02f;
      VELOCITY._x*=-1;
    }
    if(_x>(rx-_r))
    {
      _x = rx-_r*1.02f;
      VELOCITY._x*=-1;  
    }
    if(_y<(ty+_r))
    {
      _y = ty+_r*1.02f;
      VELOCITY._y*=-1;
    }
    if(_y>(by-_r))
    {
      _y = by-_r*1.02f;
      VELOCITY._y*=-1;
    }
  }
}


class IVector
{
  int _x,_y;
  IVector()
  {
  }
  IVector(int X,int Y)
  {
    _x = X;
    _y = Y;
  }
}
class LevelGeometry
{
  ArrayList Lines;
  LevelGeometry()
  {
    Lines = new ArrayList();
  }
}
class Line
{
  public float X1,Y1,X2,Y2,m;
  Line()
  {
  }
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
    float denom = ((l2.Y2-l2.Y1)*(l1.X2-l1.X1))-((l2.X2-l2.X1)*(l1.Y2-l1.Y1));
    float num_a = ((l2.X2-l2.X1)*(l1.Y1-l2.Y1))-((l2.Y2-l2.Y1)*(l1.X1-l2.X1));
    float num_b = ((l1.X2-l1.X1)*(l1.Y1-l2.Y1))-((l1.Y2-l1.Y1)*(l1.X1-l2.X1));
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
    float denom = ((l2.Y2-l2.Y1)*(l1.X2-l1.X1))-((l2.X2-l2.X1)*(l1.Y2-l1.Y1));
    float num_a = ((l2.X2-l2.X1)*(l1.Y1-l2.Y1))-((l2.Y2-l2.Y1)*(l1.X1-l2.X1));
    float num_b = ((l1.X2-l1.X1)*(l1.Y1-l2.Y1))-((l1.Y2-l1.Y1)*(l1.X1-l2.X1));
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
  public boolean AABBCircle(AABB ab,Circle c)
  {
    if(((c._x>ab._x1-c._r && c._x<ab._x2+c._r)||(c._x<ab._x1+c._r && c._x>ab._x2-c._r)) && ((c._y>ab._y1 && c._y<ab._y2)||(c._y<ab._y1 && c._y>ab._y2)))
    {
      return true;
    }
    else{
      return false;
    }
  }
  public boolean LineCircleTest(Line l, Circle c)
  {
    AABB ab = new AABB(l.X1,l.Y1,l.X2,l.Y2);
    if(AABBCircle(ab,c)== true)
    {
      float angle = atan2(l.Y1-l.Y2,l.X1-l.X2);
      Line tempLine = new Line();
      Circle tempCircle = new Circle();
      return true;
    }
    else{
      return false;
    }
  }
  public Vector RotatePoint(Vector v, float angle)
  {
    Vector rv = new Vector();
    rv._x = -sin(angle)*v._x+cos(angle)*v._y;
    rv._y = cos(angle)*v._x+sin(angle)*v._y;
    return rv;
  }
}

class Squad
{
  Vector Target;
  ArrayList Units;
  Squad()
  {
    Target = new Vector();
    Units = new ArrayList();
  }
  public int AddUnit(Unit u)
  {
    Units.add(u);
    return Units.size();
  }
}
class Unit
{
  Circle BODY;
  float c_angle;
  boolean selected;
  Unit()
  {
    BODY = new Circle();
    BODY.VELOCITY = new Vector();
  }
  Unit(float X, float Y, float R)
  {
    BODY = new Circle(X,Y,R);
    BODY.VELOCITY = new Vector();
  }
  public void UPDATE()
  {
    float xp = cos(c_angle);
    float yp = sin(c_angle);
    BODY.VELOCITY._x+=(xp-BODY.VELOCITY._x)/30;
    BODY.VELOCITY._y+=(yp-BODY.VELOCITY._y)/30;
    BODY.Update();
  }
  public void DRAW()
  {
    BODY.Render();
    stroke(0,0,0,50);
    fill(0,0,0,50);
    float xd,yd;
//    beginShape();
//    xd = cos(c_angle)*BODY._r;
//    yd = sin(c_angle)*BODY._r;
//    //line(BODY._x,BODY._y,BODY._x+xd,BODY._y+yd);
//    vertex(BODY._x,BODY._y);
//    xd = cos((c_angle+(PI/3)));
//    yd = sin((c_angle+(PI/3)));
//    //line(BODY._x,BODY._y,BODY._x+xd*30,BODY._y+yd*30);
//    vertex(BODY._x+xd*100,BODY._y+yd*100);
//    xd = cos((c_angle-(PI/3)));
//    yd = sin((c_angle-(PI/3)));
//    //line(BODY._x,BODY._y,BODY._x+xd*30,BODY._y+yd*30);
//    vertex(BODY._x+xd*100,BODY._y+yd*100);
//    endShape(CLOSE);

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
  ArrayList Squads;
  ArrayList CurrentSelection;
  AABB selector;
  Maths m;
  Integer c_sq;
  Vector targets[];
  int targetc = 20;
  World()
  {
    c_sq = -1;
    m = new Maths();
    Squads = new ArrayList();
    for(int i = 0;i<50;i++)
    {
      Squad s = new Squad();
      Vector t = new Vector(random(width),random(height));
      s.Target = new Vector();
      s.Target = t;
      for(int j = 0;j<1;j++)
      {
        Unit u = new Unit(random(width),random(height), 5);
        u.BODY._x = t._x;
        u.BODY._y = t._y;
        s.Units.add(u);
      }
      Squads.add(s);
    }
    CurrentSelection = new ArrayList();
    selector = new AABB(-1,-1,-1,-1);
    //-----------------------------------------------------
    targets = new Vector[targetc];
    for(int i = 0;i<targetc;i++)
    {
      targets[i] = new Vector(random(width),random(height));
    }
  }
  public void UPDATE()
  {
    UPDATESQUADS();
    UPDATEAABB();
    UPDATEMOUSE();
  }
  public void UPDATESQUADS()
  {
    for(int i = Squads.size()-1;i>=0;i--)//loop through the squads...
    {
      Squad C_Squad = (Squad)Squads.get(i);//Get the current squad from the arraylist
      for(int j = 0;j<C_Squad.Units.size();j++)//loop through the units in the current squad
      {
        Unit C_Unit = (Unit)C_Squad.Units.get(j);//Get the current unit from the unit list in the current squad
        for(int k = C_Squad.Units.size()-1;k>=0;k--)//loop through the other units in the squad
        {
          if(k!=j)//if the units are not the same...
          {
            Unit k_u = (Unit)C_Squad.Units.get(k);//get the other unit
            if(m.CircleCircleTest(k_u.BODY,C_Unit.BODY) == true)
            {
              m.ResolveCircleCollision(k_u.BODY,C_Unit.BODY);//resolve any collisions
            }
          }
        }
        for(int k = Squads.size()-1;k>=0;k--)//loop through the other squads
        {
          if(k!=i)//if they are not the same
          {
            Squad k_s = (Squad)Squads.get(k);//get the squad
            for(int l = 0;l<k_s.Units.size();l++)//loop through its units
            {
              Unit l_u = (Unit)k_s.Units.get(l);//get the other unit
              if(m.CircleCircleTest(l_u.BODY,C_Unit.BODY))//test for collision
              {
                m.ResolveCircleCollision(l_u.BODY,C_Unit.BODY);//if true, resolve collision
              }
            }
          }
        }
        Vector diff = new Vector(C_Squad.Target._x-C_Unit.BODY._x,C_Squad.Target._y-C_Unit.BODY._y);//get move distance
        C_Unit.c_angle = atan2(diff._y, diff._x);//get and set the units move angle
        C_Unit.UPDATE();//update the unit        
        if(m.AABBCircle(selector,C_Unit.BODY) == true)
        {
          if(selector.i==true)
          {
            C_Unit.selected = true;
          }
        }
        else{
          if(selector.i == true)
          {
            C_Unit.selected = false;
          }
        }
        if(C_Unit.selected == true)
        {
          if(c_sq!=-1)
          {
            C_Unit.selected = false;
          }
          stroke(180);
        }
        else{
          stroke(0);
        }
        if(c_sq == i)
        {
          stroke(180);
        }
        C_Unit.DRAW();//draw the unit
        //--------------------------------------------------------------------------------
        for(int tc = 0;tc<targetc;tc++)
        {
          float targetAngle = atan2(targets[tc]._y-C_Unit.BODY._y,targets[tc]._x-C_Unit.BODY._x);
          float distan = sqrt((targets[tc]._x-C_Unit.BODY._x)*(targets[tc]._x-C_Unit.BODY._x)+(targets[tc]._y-C_Unit.BODY._y)*(targets[tc]._y-C_Unit.BODY._y));
          if(distan<150&&targetAngle<(C_Unit.c_angle+(PI/3))&&targetAngle>(C_Unit.c_angle-(PI/3)))
          {
            line(C_Unit.BODY._x,C_Unit.BODY._y,targets[tc]._x,targets[tc]._y);
          }
        }   
      }
      stroke(180);
      line(C_Squad.Target._x+1,C_Squad.Target._y,C_Squad.Target._x-1,C_Squad.Target._y);
      line(C_Squad.Target._x,C_Squad.Target._y+1,C_Squad.Target._x,C_Squad.Target._y-1);
      stroke(0);
      if(C_Squad.Units.size() == 0)
      {
        Squads.remove(i);
      }
    }    
  }
  public void UPDATEAABB()
  {
    if(selector.i == true)
    {
      line(selector._x1,selector._y1,selector._x1,selector._y2);
      line(selector._x2,selector._y1,selector._x2,selector._y2);
      line(selector._x1,selector._y1,selector._x2,selector._y1);
      line(selector._x1,selector._y2,selector._x2,selector._y2);
    }
  }
  public void UPDATEMOUSE()
  {
    if(c_sq>=Squads.size()||c_sq<-1)
    {
      c_sq = -1;
    }
    for(int i = 0;i<Squads.size();i++)//loop through the squads...
    {
      if(i == c_sq)
      {
        stroke(180);
      }
      else{
        stroke(230);
      }
      rect(mouseX+3+round(i/5)*5,mouseY+3+(i%5)*5,3,3);
      stroke(0);
    }
  }
  public void mp()
  { 
    if(mouseButton == LEFT)
    {
      selector._x1 = mouseX;
      selector._y1 = mouseY;
      selector._x2 = mouseX;
      selector._y2 = mouseY;
      selector.i = true;
      c_sq = -1;
    }
    if(mouseButton == RIGHT)
    {
      if(c_sq != -1)
      {
        Squad cs = (Squad)Squads.get(c_sq);
        cs.Target._x = mouseX;
        cs.Target._y = mouseY;
      }
      Squad ns = new Squad();
      ns.Target = new Vector(mouseX,mouseY);
      if(Squads.size()>0)
      {
        println("");
        for(int i = Squads.size()-1;i>=0;i--)
        {         
          for(int j = ((Squad)Squads.get(i)).Units.size()-1;j>=0;j--)
          {
            if(((Unit)((Squad)Squads.get(i)).Units.get(j)).selected == true)
            {
              ns.Units.add(((Unit)((Squad)Squads.get(i)).Units.get(j)));
              ((Squad)Squads.get(i)).Units.remove(j);
            }
          }
          println("Squad number: "+i+" has "+((Squad)Squads.get(i)).Units.size()+" units.");
          if(((Squad)Squads.get(i)).Units.size()==0)
          {
            Squads.remove(i);
          }
        }
        if(ns.Units.size()>0)
        {
          Squads.add(ns);
        }
      }
    }
  }
  public void md()
  {
    UPDATEMOUSE();
    CurrentSelection = new ArrayList();
    selector._x2 = mouseX;
    selector._y2 = mouseY;
  }
  public void mr()
  {
    selector._x2 = mouseX;
    selector._y2 = mouseY;    
    selector.i = false;
  }
  public void bp()
  {
    if(key == 'z' || key == 'Z')
    {
      c_sq ++;
      if(c_sq==Squads.size())
      {
        c_sq = 0;
      }
    }
    if(key == 'x'|| key == 'X')
    {
      c_sq--;
      if(c_sq<0)
      {
        c_sq = Squads.size()-1;
      }
    }
    if(key == 'a'|| key == 'A')
    {
      if(c_sq>=0 && c_sq <Squads.size())
      {
        Squad cs = new Squad();
        cs = (Squad)Squads.get(c_sq);
        for(int i = cs.Units.size()-1;i>=0;i--)
        {
          Squad ns = new Squad();
          Unit nu = new Unit();
          nu = (Unit)cs.Units.get(i);
          Vector distance = new Vector(nu.BODY._x-cs.Target._x,nu.BODY._y-cs.Target._y);
          cs.Units.remove(i);
          ns.Units.add(nu);
          ns.Target = new Vector(nu.BODY._x+(distance._x),nu.BODY._y+(distance._y));
          Squads.add(ns);
        }
        Squads.remove(c_sq);
      }
    }
  }
  public void br()
  {
    /*if(key = 'S' ||
    Squad ns = new Squad();
    ns.Target._x = mouseX;
    ns.Target._y = mouseY;
    for(int i = 0;i<7;i++)
    {
      Unit nu = new Unit();
    }*/
  }
}















  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#f0f0f0", "Physics" });
  }
}
