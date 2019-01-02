class UIManager extends Widget
{
  ArrayList<Widget> widgetList = new ArrayList<Widget>();
  
  int x,y,h,w;
  
  ArrayList<String> clickedList = new ArrayList<String>();
  
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
    clickedList = new ArrayList<String>();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseReleased();
      if (widgetList.get(i).wasClicked)
      {
        clickedList.add(widgetList.get(i).name);
        widgetList.get(i).wasClicked = false;
      }
    }
  }
  
  void mouseDragged()
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseDragged();
    }
  }
  
  void resize(int dtW, int dtH)
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).resize(dtW, dtH);
    }
  }
  
  void keyPressed()
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).keyPressed();
    }
  }
}
