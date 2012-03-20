class PTurtle
{
  boolean penDown;
  float angle;//angle measured clockwise from 12:00, in radians
  float x, y;
  PTurtle()
  {
    penDown = true;
    angle = x = y = 0.0;
  }
  PTurtle(float i, float j)
  {
    penDown = true;
    angle = 0.0;
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
