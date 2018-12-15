class Menu extends UIManager
{
  
  Menu(int x, int y)
  {
    this.x=x;
    this.y=y;
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
    
    /*if(widgetList.size() != 0)
    {
      Widget endWidget = widgetList.get(widgetList.size() - 1);
    
      widget.x = endWidget.x;
    
      widget.y = endWidget.y + endWidget.h;
    }*/
    
    h += widget.h;
    
    widget.x = x;
    
    widget.y = (y + h) - widget.h;
    
    
    widgetList.add(widget);
  }
  
  
}
