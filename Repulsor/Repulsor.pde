//Point POINT_Array[];
ArrayList points;
float radius = 3;
int counter = 0;
//int pointcount = 15;
void setup()
{

  size(300,300);
  background(200);
  /*POINT_Array = new Point[pointcount];
   for(int i = 0;i<pointcount;i++)
   {
   POINT_Array[i] = new Point(0+random(1)-random(1),0+random(1)-random(1),3);
   }*/
   points = new ArrayList();
  points.add(new Point(random(width),random(height),radius));
}
void draw()
{
  background(220);
  /*for(int i = 0;i<pointcount;i++)
   {
   float xDist;
   float yDist;
   for(int j=0;j<pointcount;j++)
   {
   if(i!=j)
   {
   xDist = POINT_Array[i].x-POINT_Array[j].x;
   yDist = POINT_Array[i].y-POINT_Array[j].y;
   POINT_Array[i].x += 1/(xDist/POINT_Array[j].e);
   POINT_Array[i].y += 1/(yDist/POINT_Array[j].e);
   if (mousePressed && (mouseButton == LEFT)) {
   stroke(150);
   line(POINT_Array[i].x,POINT_Array[i].y,POINT_Array[i].x + 15/(xDist/POINT_Array[j].e),POINT_Array[i].y+15/(yDist/POINT_Array[j].e));
   }
   }
   }
   if(int(random(5000))==1)
   {
   POINT_Array[i].x = random(width);
   POINT_Array[i].y = random(height);
   }
   POINT_Array[i]._draw();
   }*/
  for (int i = 0; i <points.size(); i++) { 
    float xDist;
    float yDist;
    Point p = (Point) points.get(i);
    for (int j = 0; j <points.size(); j++) { 
      Point q = (Point) points.get(i);
      if(i!=j)
      {
        xDist = p.x-q.x;
        yDist = p.y-q.y;
        p.x += 1/(xDist/q.e);
        p.y += 1/(yDist/q.e);
        if (mousePressed && (mouseButton == LEFT)) {
          stroke(150);
          line(p.x,p.y,p.x + 15/(xDist/q.e),p.y+15/(yDist/q.e));
        }
      }
    }
    p._draw();
  }
  counter++;
  if(counter%100 == 0)
  {
    points.add(new Point(random(width),random(height),radius));
  }
}
//THE POINT CLASS
class Point
{
  float x; 
  float y; 
  float r;
  float e;
  Point(float X, float Y,float R)
  {
    x = X;
    y = Y;
    r = R;
    e = (random(50));
  }
  void _draw()
  {
    stroke(100,100,100);
    point(x,y);
    line(x,y+r,x+r*0.7,y+r*0.7);
    line(x+r*0.7,y+r*0.7,x+r,y);
    line(x+r,y,x+r*0.7,y-r*0.7);
    line(x+r*0.7,y-r*0.7,x,y-r);
    line(x,y-r,x-r*0.7,y-r*0.7);
    line(x-r*0.7,y-r*0.7,x-r,y);
    line(x-r,y,x-r*0.7,y+r*0.7);
    line(x-r*0.7,y+r*0.7,x,y+r);
    this.check_loc();
  }
  void check_loc()
  {
    float xda,xdb,yda,ydb;
    xda = this.x;
    xdb = width-this.x;
    yda = this.y;
    ydb = height-this.y;
    this.x+=1/(xda/50);
    this.x-=1/(xdb/50);
    this.y+=1/(yda/50);
    this.y-=1/(ydb/50);
    if(this.x>width||this.x<0)
    {
      this.x = width/2;
    }
    if(this.y>height||this.y<0)
    {
      this.y = height/2;
    }
  }
}





