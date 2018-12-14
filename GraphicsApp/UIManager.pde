class UIManager
{
  ArrayList<Widget> widgetList = new ArrayList<Widget>();
  
  UIManager()
  {
    widgetList.add(new Button(200, 100, 100, 50));
  }
  
  void draw()
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).draw();
    }
  }
  
  void mousePressed() {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mousePressed();
    }
  }
  
  void mouseClicked ()
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseClicked();
    }
  }
  
  void mouseMoved()
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseMoved();
    }
  }
  
  void mouseReleased()
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseReleased();
    }
  }
  
  void mouseDragged()
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseDragged();
    }
  }
}
