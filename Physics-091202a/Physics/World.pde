class World
{
  ArrayList Squads;
  ArrayList CurrentSelection;
  ArrayList Lines;
  AABB selector;
  Maths m;
  Integer c_sq;
  Vector targets[];
  int targetc = 20;
  World()
  {
    c_sq = -1;
    m = new Maths();
    Squads = new ArrayList();
    //    for(int i = 0;i<7;i++)
    //    {
    //      Squad s = new Squad();
    //      Vector t = new Vector(random(width),random(height));
    //      s.Target = new Vector();
    //      s.Target = t;
    //      for(int j = 0;j<1;j++)
    //      {
    //        Unit u = new Unit(random(width),random(height), 5);
    //        u.BODY._x = t._x;
    //        u.BODY._y = t._y;
    //        s.Units.add(u);
    //      }
    //      Squads.add(s);
    //    }
    CurrentSelection = new ArrayList();
    selector = new AABB(-1,-1,-1,-1);
    //-----------------------------------------------------
    targets = new Vector[targetc];
    for(int i = 0;i<targetc;i++)
    {
      targets[i] = new Vector(random(width),random(height));
    }
    Lines = new ArrayList();
    for(int i = 0;i<2;i++)
    {
      Line nl = new Line(random(width),random(height),random(width),random(height));
      Lines.add(nl);
    }
    for(int i = 0;i<Lines.size();i++)
    {
      Line l1 = (Line)Lines.get(i);
      for(int j = i;j<Lines.size();j++)
      {
        if(j!=i)
        {
          Line l2 = (Line)Lines.get(j);
          if(m.LineLineTest(l1,l2))
          {
            Vector v = m.LineLineIntersection(l1,l2);
            Squad ns = new Squad();
            ns.Target = v;
            Unit nu = new Unit(v._x,v._y,5);
            ns.AddUnit(nu);
            Squads.add(ns);
          }
        }
      }
    }
  }
  void UPDATE()
  {
    UPDATESQUADS();
    UPDATEAABB();
    UPDATEMOUSE();
    for(int i = 0;i<Lines.size();i++)
    {
      Line rl = (Line)Lines.get(i);
      rl.Render();
    }
  }
  void UPDATESQUADS()
  {
    for(int i = Squads.size()-1;i>=0;i--)//loop through the squads...
    {
      Squad C_Squad = (Squad)Squads.get(i);//Get the current squad from the arraylist
      for(int j = 0;j<C_Squad.Units.size();j++)//loop through the units in the current squad
      {
        Unit C_Unit = (Unit)C_Squad.Units.get(j);//Get the current unit from the unit list in the current squad
        for(int k = C_Squad.Units.size()-1;k>=0;k--)//loop through the other units in the squad
        {
          if(k!=j)//if the units are not the same...
          {
            Unit k_u = (Unit)C_Squad.Units.get(k);//get the other unit
            if(m.CircleCircleTest(k_u.BODY,C_Unit.BODY) == true)
            {
              m.ResolveCircleCollision(k_u.BODY,C_Unit.BODY);//resolve any collisions
            }
          }
        }
        for(int k = Squads.size()-1;k>=0;k--)//loop through the other squads
        {
          if(k!=i)//if they are not the same
          {
            Squad k_s = (Squad)Squads.get(k);//get the squad
            for(int l = 0;l<k_s.Units.size();l++)//loop through its units
            {
              Unit l_u = (Unit)k_s.Units.get(l);//get the other unit
              if(m.CircleCircleTest(l_u.BODY,C_Unit.BODY))//test for collision
              {
                m.ResolveCircleCollision(l_u.BODY,C_Unit.BODY);//if true, resolve collision
              }
            }
          }
        }
        Vector diff = new Vector(C_Squad.Target._x-C_Unit.BODY._x,C_Squad.Target._y-C_Unit.BODY._y);//get move distance
        C_Unit.c_angle = atan2(diff._y, diff._x);//get and set the units move angle
        C_Unit.UPDATE();//update the unit        
        if(m.AABBCircle(selector,C_Unit.BODY) == true)
        {
          if(selector.i==true)
          {
            C_Unit.selected = true;
          }
        }
        else{
          if(selector.i == true)
          {
            C_Unit.selected = false;
          }
        }
        if(C_Unit.selected == true)
        {
          if(c_sq!=-1)
          {
            C_Unit.selected = false;
          }
          stroke(180);
        }
        else{
          stroke(0);
        }
        if(c_sq == i)
        {
          stroke(180);
        }
        for(int g = 0;g<Lines.size();g++)
        {
          Line testline = (Line)Lines.get(g);
          if(m.LooseLineCircleTest(testline,C_Unit.BODY))
          {
            int result = m.TightLineCircleTest(testline,C_Unit.BODY);
            if(result == 1)
            {
              m.ResolveCircleLineCollision(testline,C_Unit.BODY, false);
            }
            if(result == 2){
              m.ResolveCircleLineCollision(testline,C_Unit.BODY, true);
            }
          }
        }
        C_Unit.DRAW();//draw the unit
        //--------------------------------------------------------------------------------
        for(int tc = 0;tc<targetc;tc++)
        {
          float targetAngle = atan2(targets[tc]._y-C_Unit.BODY._y,targets[tc]._x-C_Unit.BODY._x);
          float distan = sqrt((targets[tc]._x-C_Unit.BODY._x)*(targets[tc]._x-C_Unit.BODY._x)+(targets[tc]._y-C_Unit.BODY._y)*(targets[tc]._y-C_Unit.BODY._y));
          if(distan<150&&targetAngle<(C_Unit.c_angle+(PI/3))&&targetAngle>(C_Unit.c_angle-(PI/3)))
          {
            //line(C_Unit.BODY._x,C_Unit.BODY._y,targets[tc]._x,targets[tc]._y);
          }
        }   
      }
      stroke(180);
      line(C_Squad.Target._x+1,C_Squad.Target._y,C_Squad.Target._x-1,C_Squad.Target._y);
      line(C_Squad.Target._x,C_Squad.Target._y+1,C_Squad.Target._x,C_Squad.Target._y-1);
      stroke(0);
      if(C_Squad.Units.size() == 0)
      {
        Squads.remove(i);
      }
    }    
  }
  void UPDATEAABB()
  {
    if(selector.i == true)
    {
      line(selector._x1,selector._y1,selector._x1,selector._y2);
      line(selector._x2,selector._y1,selector._x2,selector._y2);
      line(selector._x1,selector._y1,selector._x2,selector._y1);
      line(selector._x1,selector._y2,selector._x2,selector._y2);
    }
  }
  void UPDATEMOUSE()
  {
    if(c_sq>=Squads.size()||c_sq<-1)
    {
      c_sq = -1;
    }
    for(int i = 0;i<Squads.size();i++)//loop through the squads...
    {
      if(i == c_sq)
      {
        stroke(180);
      }
      else{
        stroke(230);
      }
      rect(mouseX+3+round(i/5)*5,mouseY+3+(i%5)*5,3,3);
      stroke(0);
    }
  }
  void mp()
  { 
    if(mouseButton == LEFT)
    {
      selector._x1 = mouseX;
      selector._y1 = mouseY;
      selector._x2 = mouseX;
      selector._y2 = mouseY;
      selector.i = true;
      c_sq = -1;
    }
    if(mouseButton == RIGHT)
    {
      if(c_sq != -1)
      {
        Squad cs = (Squad)Squads.get(c_sq);
        cs.Target._x = mouseX;
        cs.Target._y = mouseY;
      }
      Squad ns = new Squad();
      ns.Target = new Vector(mouseX,mouseY);
      if(Squads.size()>0)
      {
        println("");
        for(int i = Squads.size()-1;i>=0;i--)
        {         
          for(int j = ((Squad)Squads.get(i)).Units.size()-1;j>=0;j--)
          {
            if(((Unit)((Squad)Squads.get(i)).Units.get(j)).selected == true)
            {
              ns.Units.add(((Unit)((Squad)Squads.get(i)).Units.get(j)));
              ((Squad)Squads.get(i)).Units.remove(j);
            }
          }
          println("Squad number: "+i+" has "+((Squad)Squads.get(i)).Units.size()+" units.");
          if(((Squad)Squads.get(i)).Units.size()==0)
          {
            Squads.remove(i);
          }
        }
        if(ns.Units.size()>0)
        {
          Squads.add(ns);
        }
      }
    }
  }
  void md()
  {
    UPDATEMOUSE();
    CurrentSelection = new ArrayList();
    selector._x2 = mouseX;
    selector._y2 = mouseY;
  }
  void mr()
  {
    selector._x2 = mouseX;
    selector._y2 = mouseY;    
    selector.i = false;
  }
  void bp()
  {
    if(key == 'z' || key == 'Z')
    {
      c_sq ++;
      if(c_sq==Squads.size())
      {
        c_sq = 0;
      }
    }
    if(key == 'x'|| key == 'X')
    {
      c_sq--;
      if(c_sq<0)
      {
        c_sq = Squads.size()-1;
      }
    }
    if(key == 'a'|| key == 'A')
    {
      if(c_sq>=0 && c_sq <Squads.size())
      {
        Squad cs = new Squad();
        cs = (Squad)Squads.get(c_sq);
        for(int i = cs.Units.size()-1;i>=0;i--)
        {
          Squad ns = new Squad();
          Unit nu = new Unit();
          nu = (Unit)cs.Units.get(i);
          Vector distance = new Vector(nu.BODY._x-cs.Target._x,nu.BODY._y-cs.Target._y);
          cs.Units.remove(i);
          ns.Units.add(nu);
          ns.Target = new Vector(nu.BODY._x+(distance._x),nu.BODY._y+(distance._y));
          Squads.add(ns);
        }
        Squads.remove(c_sq);
      }
    }
  }
  void br()
  {
    if(key == 'S' || key == 's')
    {
      Squad ns = new Squad();
      ns.Target._x = mouseX;
      ns.Target._y = mouseY;
      for(int i = 0;i<7;i++)
      {
        Unit nu = new Unit(mouseX,mouseY,5);
        ns.Units.add(nu);
      }
      Squads.add(ns);
    }
    if(key == 'D' || key == 'd')
    {
      Squads.remove(c_sq);
    }
  }
}


















