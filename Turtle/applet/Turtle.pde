import java.util.ArrayList;
PTurtle eric;
String koch_values;
float koch_length = 5;
int iterations = 3;
void setup()
{
  size(1200,600);
  background(0,0,0);
  stroke(255,255,255);
  eric = new PTurtle(width/2,height/2);
  koch_values = new String();
  koch_values="F";
  koch_curve(iterations);
  koch_length = (width-20)/(pow(3,iterations));
  //println(koch_values);
}
void draw()
{
  background(0,0,0);
  eric.x = 10;
  eric.y = height-10;
  eric.angle = PI/2;
  float t_angle = PI/2;
  for(int i = 0;i<koch_values.length();i++)
  {
    if(koch_values.charAt(i) == 'F')
    {
      eric.Forward(koch_length);
    }
    if(koch_values.charAt(i) == '+')
    {
      eric.tleft(t_angle);
    }
    if(koch_values.charAt(i) == 'o')
    {
      eric.tright(t_angle);
    }
  }
}
void koch_curve(int iterations)
{
  
  for(int i = 0;i<iterations;i++)
  {
    String new_koch = new String();
    for(int j = 0;j<koch_values.length();j++)
    {
      if(koch_values.charAt(j) == 'F')
      {
        new_koch+="F+FoFoF+F";
      }
      if(koch_values.charAt(j) == '+')
      {
        new_koch+='+';
      }
      if(koch_values.charAt(j) == 'o')
      {
        new_koch+='o';
      }
    }
    koch_values = new_koch;
      //println(new_koch);
  }

  
}
void copy_string(String from, String to)
{
  to = "";
  for(int i = 0;i<from.length();i++)
  {
    to+=from.charAt(i);
  }
}
int power(int base, int exponent)
{
  if(exponent==0)
  {
    return 1;
  }
  if(exponent == 1)
  {
    return base;
  }
  int r = base;
  for(int i = 2;i<=exponent;i++)
  {
    r = r*base;
  }
  return r;
}
void keyPressed() {
  if(key == '+')
  {
    if(iterations<6)
    {
      iterations++;
      println("+");
    }
  }
  if(key == '-')
  {
    if(iterations>0)
    {
      iterations--;
      println("-");
    }
  }
  koch_values = "F";
  koch_curve(iterations);
  koch_length = (width-20)/(pow(3,iterations));
  println(iterations);
}
