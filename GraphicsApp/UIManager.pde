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
}
