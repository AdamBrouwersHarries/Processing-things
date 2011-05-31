Maths m;
Circle c1;
Circle c_a[];
Line l1;
Line l_a[];
int circlecount = 25;
int linecount = 10;
void setup()
{
  println("STARTED");
  cursor(CROSS);
  size(300,400);
  background(255);
  m = new Maths();
  c1 = new Circle(0,0,30);
  c_a = new Circle[circlecount];
  for(int i = 0;i<circlecount;i++)
  {
    println("Circle:"+i);
    c_a[i] = new Circle(random(width),random(height),random(10)+6);

    boolean FREE = false;
    if(i!=0)
    {
      while(FREE!=true)
      {
        boolean anyhit = false;
        for(int j = 0;j<i;j++)
        {
          println("Colliding:"+i+" with "+j);
          if(m.CircleCircleTest(c_a[i],c_a[j]) == true)
          {            
            println("HIT:");
            println("   i:"+c_a[i]._x+","+c_a[i]._y+"  j:"+c_a[j]._x+","+c_a[j]._y);
            anyhit = true;    
          }      
        }
        if(anyhit == false)
        {
          FREE = true;
        }else{
          c_a[i]._x = random(width);
          c_a[i]._y = random(height);
        }
      }
    }
    c_a[i].VELOCITY = new Vector(random(0.5),random(0.5));
  }
  l1 = new Line(0,0,width/2, height/2);
  l_a = new Line[linecount];
  for(int i = 0;i<linecount;i++)
  {
    l_a[i] = new Line(random(width),random(height),random(width),random(height)); 
  }
}
void draw()
{
  background(255);
  stroke(0);
  c1._x = mouseX;
  c1._y = mouseY;
  boolean ccollision = false;
  for(int i = 0;i<circlecount;i++)
  {
    for(int j = 0;j<circlecount;j++)
    {
      if(j!=i)
      {
        if(m.CircleCircleTest(c_a[i],c_a[j]) == true)
        {
          m.BounceBalls(c_a[i],c_a[j]);
        }
      }
    }
    c_a[i].Update();
    c_a[i].Render();
  }
  if(ccollision == true)
  {
    stroke(100);
    //c1.Render(); 
  }
  else{
    stroke(0);
    //c1.Render();
  }
  l1.X2 = mouseX;
  l1.Y2 = mouseY;
  boolean lcollision = false;
  for(int i = 0;i<linecount;i++)
  {
    if(m.LineLineTest(l1,l_a[i]) == true)
    {
      stroke(100);
      //l_a[i].Render();
      lcollision = true;
    }
    else{
      stroke(0);
      //l_a[i].Render();
    }
  }
  if(lcollision == true)
  {
    stroke(100);
    //l1.Render();
  }
  else{
    stroke(0);
    //l1.Render();
  }
}
void Shuffle()
{
  for(int i = 0;i<circlecount;i++)
  {
    c_a[i]._x = random(width);
          c_a[i]._y = random(height);
    println("Circle:"+i);
    boolean FREE = false;
    if(i!=0)
    {
      while(FREE!=true)
      {
        boolean anyhit = false;
        for(int j = 0;j<i;j++)
        {
          println("Colliding:"+i+" with "+j);
          if(m.CircleCircleTest(c_a[i],c_a[j]) == true)
          {            
            println("HIT:");
            println("   i:"+c_a[i]._x+","+c_a[i]._y+"  j:"+c_a[j]._x+","+c_a[j]._y);
            anyhit = true;    
          }      
        }
        if(anyhit == false)
        {
          FREE = true;
        }else{
          c_a[i]._x = random(width);
          c_a[i]._y = random(height);
        }
      }
    }
  }
}
void mousePressed()
{
  Shuffle();
}

