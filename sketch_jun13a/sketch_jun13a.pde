boolean imap[][];
float num = random(10);
int x,y;
void setup()
{
  size(600,600);
  background(100,100,100);
  imap = new boolean[200][200];
  for(int i = 0;i<200;i++)
  {
    for(int j = 0;j<200;j++)
    {
      num = random(10);
      
      imap[i][j] = num>5;
    }
  }
  place_square();
}
void place_square()
{
  boolean done = false;
  while(done == false)
  {
    x = (int)random(200);
    y = (int)random(200);
    if(imap[x][y] != true)
    {
      done = true;
    }
  }
}
void draw()
{
  background(100,100,100);
 
  stroke(0,0,0);
  fill(0,0,0);
  for(int i =0;i<200;i++)
  {
    for(int j = 0;j<200;j++)
    {
      if(imap[i][j] == true)
      rect(i*3,j*3,3,3);
      //point(i,j);
      //num = random(10);
      //imap[i][j] = num>5;
    }
  }
   stroke(0,255,0);
   fill(0,255,0);
   rect(x*3,y*3,3,3);
  point(x,y);
}
void keyPressed() {
  switch(key)
  {
    case 's':
      if(imap[x][y+1] != true)
      {
        y++;
      }
    break;
    case 'w':
    if(imap[x][y-1] != true)
      {
        y--;
      }
    break;
    case 'd':
    if(imap[x+1][y] != true)
      {
        x++;
      }
    break;
    case 'a':
    if(imap[x-1][y] != true)
      {
        x--;
      }
    break;
    case 'x':
    place_square();
    break;
  }
}

