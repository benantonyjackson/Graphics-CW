class UIManager extends Widget
{
  ArrayList<Widget> widgetList = new ArrayList<Widget>();
  
  ArrayList<String> clickedList = new ArrayList<String>();
  
  MenuBar menuBar;

  int CurrnetID = 0;
  
  UIManager()
  {}
  
  UIManager(MenuBar m)
  {
    setMenuBar(m);
  }
  
  void add(Widget widget)
  {  
    widget.id = CurrnetID++;

    widgetList.add(widget);
  }
  
  void setMenuBar(MenuBar m)
  {
    menuBar = m;
  }
  
  void draw()
  {
    super.draw();
    
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).draw();
    }
    
    if (menuBar != null)
    menuBar.draw();
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
    {
      menuBar.mouseClicked();
    }
    
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
    {
      menuBar.mouseReleased();
    
      if (menuBar.wasClicked)
      {
        return;
      }
    }
    

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
  
  
  //Removes all widgets that have been marked as closed
  void clean()
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      if (widgetList.get(i).closed)
      {
        widgetList.remove(i);
        i--;
      }
    }
  }

  void remove(int i)
  {
    if (i < (widgetList.size() - 1) && i >= 0)
    widgetList.remove(i);
  }

  int getIndexFromID(int WidgetID)
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      if (widgetList.get(i).id == WidgetID)
      {
        return i;
      }
    }
    return -1;

  }

  void remove(Widget widget)
  {
    int i = -1;
    if (widget != null)
    {
      i = getIndexFromID(widget.id);
    }
    

    if (i > -1)
    {
      remove(i);
    } 
  }
}
