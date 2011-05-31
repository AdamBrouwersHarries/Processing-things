class Maths
{
  Maths()
  {
  }
  boolean LineLineTest(Line l1, Line l2)
  {
    float denom = ((l2.Y2-l2.Y1)*(l1.X2-l1.X1))-
      ((l2.X2-l2.X1)*(l1.Y2-l1.Y1));
    float num_a = ((l2.X2-l2.X1)*(l1.Y1-l2.Y1))-
      ((l2.Y2-l2.Y1)*(l1.X1-l2.X1));
    float num_b = ((l1.X2-l1.X1)*(l1.Y1-l2.Y1))-
      ((l1.Y2-l1.Y1)*(l1.X1-l2.X1));
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
    float denom = ((l2.Y2-l2.Y1)*(l1.X2-l1.X1))-
      ((l2.X2-l2.X1)*(l1.Y2-l1.Y1));
    float num_a = ((l2.X2-l2.X1)*(l1.Y1-l2.Y1))-
      ((l2.Y2-l2.Y1)*(l1.X1-l2.X1));
    float num_b = ((l1.X2-l1.X1)*(l1.Y1-l2.Y1))-
      ((l1.Y2-l1.Y1)*(l1.X1-l2.X1));
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
  void BounceBalls(Circle c1,Circle c2)
  {
    //Circle 1 is the b[0] in the original algorythm
    //Circle 2 is the b[1] in the original algorythm
    //vector bettween two balls centres.
    
    Vector bVect = new Vector(c2._x-c1._x,c2._y-c1._y);
    //actual distance bettween two centres (the hypotenuse or magnitude of vector)
    float bVectMag = sqrt((bVect._x*bVect._x)+(bVect._y*bVect._y));
    //angle of vector
    float theta = atan2(bVect._y,bVect._x);
    //the sine and cosine values of the angle:
    float sine = sin(theta);
    float cosine = cos(theta);
    //initialise temporary circles to act as holders
    Circle c1TEMP, c2TEMP;
    c1TEMP = new Circle();
    c2TEMP = new Circle();
    //Temp for the second ball
    //rotate the balls location
    c2TEMP._x = cosine*bVect._x+sine*bVect._y;
    c2TEMP._y = cosine*bVect._y-sine*bVect._x;

    //rotate temp velocitys
    c1TEMP.VELOCITY._x =cosine*c1.VELOCITY._x+sine*c1.VELOCITY._y;
    c1TEMP.VELOCITY._y =cosine*c1.VELOCITY._y-sine*c1.VELOCITY._x;
    c2TEMP.VELOCITY._x =cosine*c2.VELOCITY._x+sine*c2.VELOCITY._y;
    c2TEMP.VELOCITY._y =cosine*c2.VELOCITY._y-sine*c2.VELOCITY._x;

    Vector vf1, vf2;
    vf1 = new Vector(0,0);
    vf2 = new Vector(0,0);
    //use the conservation of momentum to work out the final velocity...
    // final rotated velocity for c1
    vf1._x = ((c1._m - c2._m) * c1TEMP.VELOCITY._x + 2 * c2._m *  c2TEMP.VELOCITY._x) / (c1._m + c2._m)*c1._rest;
    vf1._y = c1TEMP.VELOCITY._y*c1._rest;
    // final rotated velocity for c1
    vf2._x = ((c2._m - c1._m) * c2TEMP.VELOCITY._x + 2 * c1._m *c1TEMP.VELOCITY._x) / (c1._m + c2._m)*c2._rest;
    vf2._y = c2TEMP.VELOCITY._y*c2._rest;

    c1TEMP._x += vf1._x;
    c2TEMP._x += vf2._x;

    Vector bf1,bf2;
    bf1 = new Vector(0,0);
    bf2 = new Vector(0,0);

    bf1._x =cosine * c1TEMP._x - sine * c1TEMP._y;
    bf1._y =cosine * c1TEMP._y + sine * c1TEMP._x;

    bf2._x =cosine * c2TEMP._x - sine * c2TEMP._y;
    bf2._y =cosine * c2TEMP._y + sine * c2TEMP._x;

    //update the positions
    c2._x = c1._x+bf2._x;
    c2._y = c1._y+bf2._y;
    c1._x = c1._x+bf1._x;
    c1._y = c1._y+bf1._y; 

    //update velocities
    c1.VELOCITY._x = cosine * vf1._x - sine * vf1._y;
    c1.VELOCITY._y = cosine * vf1._y + sine * vf1._x;
    c2.VELOCITY._x = cosine * vf2._x - sine * vf2._y;
    c2.VELOCITY._y = cosine * vf2._y + sine * vf2._x;
  }
}



