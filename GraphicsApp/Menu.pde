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
    //If the current widgets width is greater than the current width of the menu 
    if (widget.w > w)
    {
      //Increase the width of the menu 
      w = widget.w;
      
      //Increase the width of the menu items
      for (int i = 0; i < widgetList.size(); i++)
      {
        widgetList.get(i).w = w;
      }
    }
   
    //Increases the height of the menu
    h += widget.h;
    
    //Sets the position of the widget to be inline with the rest of the menu
    widget.x = x;
    widget.y = (y + h) - widget.h;
    
    //Adds widget to the widget list.
    widgetList.add(widget);
  }
  
  
  void setActive(boolean act)
  {
    //Sets the menu visibilty 
    active = act;
    for (Widget widget: widgetList)
    {
      widget.active = act;
    }
  }
  
  void setPosition(int x, int y)
  {
    //Moves the menu and its widgets to the new x and y position 
    int tempY = y;
    
    for (Widget widget: widgetList)
    {
      widget.x = x;
      
      widget.y = tempY;
      
      tempY += widget.h;
    }
  }
}
