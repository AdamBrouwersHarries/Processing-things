line_d line_list[];
float lengtg_l = 13;
float width_l = 40;
int line_c = 10;
int counter = 0;
int colour = 0;
void setup()
{
  //size(screen.width,screen.height);
  size(200,200);
  background(255,255,255);
  line_list = new line_d[line_c];
  float x = width/2;//random(width);
  float y = height/2;//random(height);
  for(int i = 0;i<line_c;i++)
  {
    line_list[i] = new line_d(x,y);
  }
}
void draw()
{
  stroke(colour);
  strokeWeight(width_l);
  width_l = width_l/1.2;
  lengtg_l = lengtg_l/1.2;
  if(width_l>0.01)
  {
    for(int i = 0;i<line_c;i++)
    {
      //stroke(sin(abs(line_list[i]._a))*255);
      line(line_list[i]._xn,line_list[i]._yn,line_list[i]._xc,line_list[i]._yc);
      line_list[i]._a+=random(HALF_PI/1.2)-random(HALF_PI/1.2);
      line_list[i].recalc();
    }
  }else{
    //counter++;
    //if(counter>40)
    //{
      reset();
    //}
  }
}
void reset()
{
  float x = width/2;//random(width);
  float y = height/2;//random(height);
  for(int i = 0;i<line_c;i++)
  {
    line_list[i] = new line_d(x, y);
  }
  lengtg_l = 13;
  width_l = 40;
  counter = 0;
  //background(255,255,255);
  
  counter = 0;
  colour+=15;
  if(colour>225)
  {
    colour = 0;
  }
}

class line_d
{
  float _a, _xc, _yc, _xn, _yn;
  line_d(float x, float y)
  {
    _a = random(100);
    _xc = x;
    _yc = y;
    _xn = _xc+(lengtg_l*sin(_a));
    _yn = _yc+(lengtg_l*cos(_a));
  }
  void recalc()
  {
    _xc = _xn;
    _yc = _yn;
    _xn = _xc+(lengtg_l*sin(_a));
    _yn = _yc+(lengtg_l*cos(_a));
  }
}

