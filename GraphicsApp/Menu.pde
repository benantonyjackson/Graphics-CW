class Menu extends UIManager
{
  
  Menu()
  {
    
  }
  
  Menu(int x, int y)
  {
    this.x=x;
    this.y=y;
  }
  
  void mouseReleased()
  {
    super.mouseReleased();
    setActive(mouseIsIn && active);
  }
  
  void add(Widget widget)
  {
    if (widget.w > w)
    {
      w = widget.w;
      
      for (int i = 0; i < widgetList.size(); i++)
      {
        widgetList.get(i).w = w;
      }
    }
   
    
    h += widget.h;
    
    widget.x = x;
    
    widget.y = (y + h) - widget.h;
    
    
    widgetList.add(widget);
  }
  
  
  void setActive(boolean act)
  {
    active = act;
    
    for (Widget widget: widgetList)
    {
      widget.active = act;
    }
  }
  
  void setPosition(int x, int y)
  {
    int tempY = y;
    
    for (Widget widget: widgetList)
    {
      widget.x = x;
      
      widget.y = tempY;
      
      tempY += widget.h;
    }
  }
}
