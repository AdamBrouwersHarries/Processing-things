//LANGTONS ANT PROGRAM
//program to simulate langtons ant
//directions:
//0 = up;
//1 = right;
//2 = down;
//3 = left
int direction;
// the ants x and y;
int x;
int y;
//colors for black and white for the ant
color black = color(0);
color white = color(256);
//setup function
void setup()
{
  size(200,200);
  x = 100;
  y = 100;
  direction = 0;
  background(256,256,256);
  //frameRate(1);
}
//drawing function
void draw()
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
}

