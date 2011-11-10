World w;
void setup()
{
  println("STARTED");
  cursor(CROSS);
  size(900,600);
  background(255);
  w = new World();
}
void draw()
{
  background(255);
  w.UPDATE();
}
void mousePressed()
{
  w.mp();
}
void mouseReleased()
{
  w.mr();
}
void mouseDragged()
{
  w.md();
}
void keyPressed()
{
  w.bp();
}
void keyReleased()
{
  w.br();
}







