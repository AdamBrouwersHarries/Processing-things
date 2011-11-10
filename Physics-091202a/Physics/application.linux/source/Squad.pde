class Squad
{
  Vector Target;
  ArrayList Units;
  Squad()
  {
    Target = new Vector();
    Units = new ArrayList();
  }
  int AddUnit(Unit u)
  {
    Units.add(u);
    return Units.size();
  }
}
