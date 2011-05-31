//LANGTONS ANT PROGRAM
//program to simulate langtons ant
//colors for black and white for the ant
color black = color(0);
color white = color(128);
int antCount = 50;
ant[] Ants = new ant[antCount];
//setup function
void setup()
{
  
  size(640,480);
  background(128);
  for(int i = 0;i<antCount;i++)
  {
    Ants[i] = new ant(int(random(screen.width)),int(random(screen.height)),int(random(3)));
  }
  boolean bblack = false;
  for(int i = 0;i<screen.width;i++)
  {
    for(int j = 0;j<screen.width;j++)
    {
      if(bblack == true)
      {
        bblack = false;
        set(i,j,black);
      }else{
       
       bblack = true; 
      }
    }
    if(bblack == true)
      {
        bblack = false;
      }else{
       bblack = true; 
      }
  }
  //frameRate(1);
}
//drawing function
void draw()
{
  for(int i = 0;i<antCount;i++)
  {
    Ants[i].Update(black,white);
  }
}
//ant class
class ant
{
  //directions:
  //0 = up;
  //1 = right;
  //2 = down;
  //3 = left
  int x, y, direction;
  ant(int tx, int ty, int tdirection)
  {
    x = tx;
    y = ty;
    direction = tdirection;
  }
  void Update(color black, color white)
  {
    color c = get(x,y);
    if(c == black)
    {
      set(x,y, white);
      direction--;
      if(direction<0)
      {
        direction = 3;
      }
    }
    if(c == white)
    {
      set(x,y, black);
      direction++;
      if(direction>3)
      {
        direction = 0;
      }
    }
    switch(direction)
    {
    case 0:
      y++;
      break;
    case 1:
      x++;
      break;
    case 2:
      y--;
      break;
    case 3:
      x--;
      break;
    }
    if(x>width)
    {
      x = 0;
    }
    if(x<0)
    {
      x = width;
    }
    if(y>height)
    {
      y = 0;
    }
    if(y<0)
    {
      y = height;
    }
  }
}

