float sangle = 0;
void setup()
{
  size(1366,768);
  //size(1280,1024);
  background(0);
  
  
}
void draw()
{
  //save("C:\\users\\systemadmin\\desktop\\spiral.png");
  sangle+=0.01;
  stroke(5);
  draw_spiral(width/2,height/2,sangle,1,0.007,0.001);
  stroke(10);
  draw_spiral(width/2,height/2, sangle,1,0.005,0.001);
  stroke(15);
  draw_spiral(width/2,height/2, sangle,1,0.003,0.001);
  stroke(20);
  draw_spiral(width/2,height/2, sangle,1,0.001,0.001);
  stroke(25);
  draw_spiral(width/2,height/2, sangle,1,0.0009,0.001);
  stroke(30);
  draw_spiral(width/2,height/2, sangle,1,0.0007,0.001);
}
void draw_spiral(float x, float y,float ai, float li, float am, float lm)
{
  strokeWeight(li);
  for(int a = 0;a<9000;a++)
  {
    float px = x;
    float py = y;
    x = px+(li*sin(ai));
    y = py+(li*cos(ai));
    line(x,y,px,py);
    strokeWeight(li);
    ai+=am;
    li+=lm;
  }
}

