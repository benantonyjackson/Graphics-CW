class UIManager extends Widget
{
  ArrayList<Widget> widgetList = new ArrayList<Widget>();
  
  int x,y,h,w;
  
  
  UIManager()
  {
    
  }
  
  void add(Widget widget)
  {  
    widgetList.add(widget);
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
