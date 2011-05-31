Maths m;
Circle c_a[];
Vector target = new Vector(0,0);
int circlecount = 50;
void setup()
{
  println("STARTED");
  cursor(CROSS);
  size(900,900);
  background(255);
  m = new Maths();
  c_a = new Circle[circlecount];
  for(int i=0;i<circlecount;i++)
  {
    c_a[i] = new Circle(0,25,10);
    c_a[i].VELOCITY = new Vector(10,10);
  }
  Shuffle();
}
void draw()
{
  background(255);
  stroke(0);
  line(target._x+1,target._y,target._x-1,target._y);
  line(target._x,target._y+1,target._x,target._y-1);
  for(int i = 0;i<circlecount;i++)
  {
    float MaxV = 3;
    if((c_a[i]._x<target._x)&&(c_a[i].VELOCITY._x<MaxV))
    {
      c_a[i].VELOCITY._x+=0.2;
    }
    if((c_a[i]._x>target._x)&&(c_a[i].VELOCITY._x>-MaxV))
    {
      c_a[i].VELOCITY._x-=0.2;
    }if((c_a[i]._y<target._y)&&(c_a[i].VELOCITY._y<MaxV))
    {
      c_a[i].VELOCITY._y+=0.2;
    }
    if((c_a[i]._y>target._y)&&(c_a[i].VELOCITY._y>-MaxV))
    {
      c_a[i].VELOCITY._y-=0.2;
    }
    for(int j = 0;j<circlecount;j++)
    {
      if(j!=i)
      {
        if(m.CircleCircleTest(c_a[i],c_a[j])==true)
        {
          m.ResolveCircleCollision(c_a[i],c_a[j]);            
          //m.BounceBalls(c_a[i],c_a[j]);
        }
      }
    }
    c_a[i].Update();
    stroke(0);
    line(c_a[i]._x+c_a[i].VELOCITY._x,c_a[i]._y+c_a[i].VELOCITY._y,c_a[i]._x-c_a[i].VELOCITY._x,c_a[i]._y-c_a[i].VELOCITY._y);
    //c_a[i].Render();
  }
  target._x = mouseX;
  target._y = mouseY;
}
void Shuffle()
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
void mousePressed()
{
  //Shuffle();  
  target._x = mouseX;
  target._y = mouseY;
}
void mouseReleased()
{
target._x = mouseX;
  target._y = mouseY;
}







