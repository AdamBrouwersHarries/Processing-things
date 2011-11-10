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
  void UPDATE()
  {
    float xp = cos(c_angle);
    float yp = sin(c_angle);
    BODY.VELOCITY._x+=(xp-BODY.VELOCITY._x)/30;
    BODY.VELOCITY._y+=(yp-BODY.VELOCITY._y)/30;
    BODY.Update();
  }
  void DRAW()
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

