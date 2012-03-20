void setup()
{
  size(500,300);
  background(00,80,80);
}
void loop()
{
}
class stabber
{
  float angles[];
  float arm_length[];
  void stabber(int attr_x, int attr_y, int start_x, int start_y)
  {
    angles = new float[8];
    arm_length = new float[8];
    float mod = random(300)/300*PI;
    for(int i = 0;i<8;i++)
    {
      angles[i] = (i*(PI/8))+mod;
      arm_length = 12;
    }
  }
  void show()
  {
    
    strokeCap(ROUND);
    for(int i = 0;i<8;i++)
    {
      strokeWeight(arm_length[i]/2);
    }
    
  }
}
