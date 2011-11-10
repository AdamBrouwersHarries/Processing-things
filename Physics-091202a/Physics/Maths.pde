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
    if(((c._x>ab._x1-c._r && c._x<ab._x2+c._r)||(c._x<ab._x1+c._r && c._x>ab._x2-c._r)) && ((c._y>ab._y1-c._r && c._y<ab._y2+c._r)||(c._y<ab._y1+c._r && c._y>ab._y2-c._r)))
    {
      return true;
    }
    else{
      return false;
    }
  }
  boolean LooseLineCircleTest(Line l, Circle c)
  {
    AABB ab = new AABB();
    if(l.X1>l.X2)
    {
      ab._x1 = l.X1;
      ab._x2 = l.X2;
    }
    else{
      ab._x1 = l.X2;
      ab._x2 = l.X1;
    }
    if(l.Y1>l.Y2)
    {
      ab._y1 = l.Y1;
      ab._y2 = l.Y2;
    }
    else{
      ab._y1 = l.Y2;
      ab._y2 = l.Y1;
    }
    if(AABBCircle(ab,c)== true)
    {
      return true;
    }
    else{
      return false;
    }
  }
  int TightLineCircleTest(Line l, Circle ci)
  {
    float r = ci._r;
    float m = (l.Y1-l.Y2)/(l.X1-l.X2);
    float c = l.Y1-(m*l.X1);
    float a = ci._x;
    float b = ci._y;
    float ar = ((m*m)+1);
    float br = ((m*((2*c)-(2*b)))-(2*a));
    float cr = ((b*b)+(a*a)+(c*c)-(r*r)-(2*b*c));
    float dr = (br*br)-(4*ar*cr);
    if(dr>0)
    {      
        println("two hits");     
        return 1;
    }
    else{
      println("<2 hits");
      return 0;
    }
  }
  void ResolveCircleLineCollision(Line l,Circle ci, boolean PosDisc)
  {
    Vector cp1,cp2;
    float r = ci._r;
    float m = (l.Y1-l.Y2)/(l.X1-l.X2);
    float c = l.Y1-(m*l.X1);
    float a = ci._x;
    float b = ci._y;
    float ar = ((m*m)+1);
    float br = ((2*m*c)-(2*a)-(2*b*m));
    float cr = ((b*b)+(a*a)+(c*c)-(r*r)-(2*b*c));
    float x1 = (-br+sqrt((br*br)-(4*ar*cr)))/(2*ar);
    float x2 = (-br-sqrt((br*br)-(4*ar*cr)))/(2*ar);
    float y1 = (m*x1)+c;
    float y2 = (m*x2)+c;
    if(PosDisc == true)
    {
      stroke(0,100,0);
      line(x1+2,y1,x1-2,y1);
      line(x1,y1+2,x1,y1-2);
      line(x2+2,y2,x2-2,y2);
      line(x2,y2+2,x2,y2-2);
      float midx = (x1+x2)/2;
      float midy = (y1+y2)/2;
      line(midx+2,midy,midx-2,midy);
      line(midx,midy+2,midx,midy-2);
    }
    else{
      stroke(0,100,0);
       float realx, realy;
       if(((x1<=l.X1&&x1>=l.X2)||(x1>=l.X1&&x1<=l.X2))&&((y1<=l.Y1&&y1>=l.Y2)||(y1>=l.Y1&&y1<=l.Y2)))
       {
       realx = x1;
       realy = y1;
       }else{
       realx = x2;
       realy = y2;
    }
       line(realx+2,realy,realx-2,realy);
       line(realx,realy+2,realx,realy-2);
      print("");
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





