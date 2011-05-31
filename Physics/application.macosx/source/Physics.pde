Maths m;
Circle c_a[];
int circlecount = 40;
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
    c_a[i] = new Circle(0,25,40);
    c_a[i].VELOCITY = new Vector(0,0);
  }
  Shuffle();
}
void draw()
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
Shuffle();  
}
void mouseReleased()
{

}






