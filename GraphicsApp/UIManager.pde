class UIManager extends Widget
{
  ArrayList<Widget> widgetList = new ArrayList<Widget>();
  
  ArrayList<String> clickedList = new ArrayList<String>();
  
  MenuBar menuBar;
  
  UIManager()
  {}
  
  UIManager(MenuBar m)
  {
    setMenuBar(m);
  }
  
  void add(Widget widget)
  {  
    widgetList.add(widget);
  }
  
  void setMenuBar(MenuBar m)
  {
    menuBar = m;
  }
  
  void draw()
  {
    super.draw();
    if (menuBar != null)
    menuBar.draw();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).draw();
    }
  }
  
  void mousePressed() {
    super.mousePressed();
    if (menuBar != null)
    menuBar.mousePressed();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mousePressed();
    }
  }
  
  void mouseClicked ()
  {
    if (menuBar != null)
    menuBar.mouseClicked();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseClicked();
    }
    
    super.mouseClicked();
  }
  
  void mouseMoved()
  {
    super.mouseMoved();
    if (menuBar != null)
    if (menuBar != null)
    menuBar.mouseMoved();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseMoved();
    }
  }
  
  void mouseReleased()
  {
    if (menuBar != null)
    menuBar.mouseReleased();
    
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
      
      if (widgetList.get(i).closed)
      {
        widgetList.remove(i);
        i--;
      }
    }
    
    super.mouseReleased();
  }
  
  void mouseDragged()
  {  
    if (menuBar != null)
    menuBar.mouseDragged();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseDragged();
    }
    
    super.mouseDragged();
  }
  
  void resize(int dtW, int dtH)
  {
    if (menuBar != null)
    menuBar.resize(dtW, dtH);
    
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).resize(dtW, dtH);
    }
    
    super.resize(dtW, dtH);
  }
  
  void keyPressed()
  {
    if (menuBar != null)
    menuBar.keyPressed();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).keyPressed();
    }
    super.keyPressed();
  }
}
