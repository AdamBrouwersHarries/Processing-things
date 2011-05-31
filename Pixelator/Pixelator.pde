  PImage im;
  PImage[][] subs;
void setup()
{
  size(400,400);
  background(127,127,127);
  im = loadImage("C:\\Users\\SystemAdmin\\Desktop\\Picture0316 - Copy.jpg");
  subs = new PImage[72][72];
  int segw = 5;
  for(int i = 0;i<72;i++)
  {
    for(int j = 0;j<72;j++)
    {
      subs[i][j] = im.get(i*segw,j*segw,segw,segw);
    }
  }
}
void draw()
{
  ellipseMode(CENTER);
  for(int i = 0;i<72;i++)
  {
    for(int j = 0;j<72;j++)
    {
      //image(subs[i][j],i*5,j*5);
      color mean = MeanImage(subs[i][j]);
      stroke(mean);
      fill(mean);
      //point(i,j);
      //rect(i*5,j*5,5,5);
      ellipse(i*5,j*5,5,5);
    }
  }
  noLoop();
  saveFrame("C:\\users\\systemadmin\\desktop\\out.jpg");
}
color MeanImage(PImage ni)
{
  color return_color = color(0,0,0);
  color holder_color = color(0,0,0);
  float holder_red,holder_green,holder_blue;
  holder_red = 0;
  holder_green = 0;
  holder_blue = 0;
  int divisor = ni.width*ni.height;
  for(int i = 0;i<ni.width;i++)
  {
    for(int j =0;j<ni.height;j++)
    {
      if(i == 0 && j == 0)
      {
        holder_color = ni.get(i,j);
        holder_red = red(holder_color);
        holder_green = green(holder_color);
        holder_blue = blue(holder_color);
      }else{
        holder_color = ni.get(i,j);
        holder_red += red(holder_color);
        holder_green += green(holder_color);
        holder_blue += blue(holder_color);
      }   
    }
  }
  return_color = color(holder_red/25,holder_green/25,holder_blue/25);
  return return_color;
}

