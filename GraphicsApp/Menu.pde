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
    
    widgetList.add(widget);
  }
  
  
}
