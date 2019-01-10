class UIManager extends Widget
{
  ArrayList<Widget> widgetList = new ArrayList<Widget>();
  
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
    
    super.draw();
  }
  
  void mousePressed() {
    super.mousePressed();
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
    
    super.mouseClicked();
  }
  
  void mouseMoved()
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseMoved();
    }
    
    super.mouseMoved();
  }
  
  void mouseReleased()
  {
    //Updates the array of widgets that were clicked
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
    
    super.mouseReleased();
  }
  
  void mouseDragged()
  {  
    
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseDragged();
    }
    
    super.mouseDragged();
  }
  
  void resize(int dtW, int dtH)
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).resize(dtW, dtH);
    }
    
    super.resize(dtW, dtH);
  }
  
  void keyPressed()
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).keyPressed();
    }
    super.keyPressed();
  }
}
