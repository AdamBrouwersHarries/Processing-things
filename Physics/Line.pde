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
  void Render()
  {
    line(X1,Y1,X2,Y2);
  }
}
