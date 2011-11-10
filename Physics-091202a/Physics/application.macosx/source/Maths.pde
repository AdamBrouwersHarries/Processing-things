class Maths
{
  Maths()
  {
  }
  boolean LineLineTest(Line l1, Line l2)
  {
    float denom = ((l2.Y2-l2.Y1)*(l1.X2-l1.X1))-((l2.X2-l2.X1)*(l1.Y2-l1.Y1));
    float num_a = ((l2.X2-l2.X1)*(l1.Y1-l2.Y1))-((l2.Y2-l2.Y1)*(l1.X1-l2.X1));
    float num_b = ((l1.X2-l1.X1)*(l1.Y1-l2.Y1))-((l1.Y2-l1.Y1)*(l1.X1-l2.X1));
    if(denom == 0.0)
    {
      if(num_a == 0.0&&num_b == 0.0)
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
  Vector LineLineIntersection(Line l1, Line l2)
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
  boolean CircleCircleTest(Circle c1, Circle c2)
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
  void ResolveCircleCollision(Circle c1, Circle c2)
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
  Vector VSub(Vector v1, Vector v2)
  {
    return new Vector(v1._x-v2._x,v1._y-v2._y);
  }
  boolean AABBCircle(AABB ab,Circle c)
  {
    if(((c._x>ab._x1-c._r && c._x<ab._x2+c._r)||(c._x<ab._x1+c._r && c._x>ab._x2-c._r)) && ((c._y>ab._y1 && c._y<ab._y2)||(c._y<ab._y1 && c._y>ab._y2)))
    {
      return true;
    }
    else{
      return false;
    }
  }
  boolean LineCircleTest(Line l, Circle c)
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
  Vector RotatePoint(Vector v, float angle)
  {
    Vector rv = new Vector();
    rv._x = -sin(angle)*v._x+cos(angle)*v._y;
    rv._y = cos(angle)*v._x+sin(angle)*v._y;
    return rv;
  }
}

