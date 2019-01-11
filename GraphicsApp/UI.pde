//This tab contains for the ui

class MainUI extends UIManager
{
  
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
      
      if (widgetList.get(i).closed)
      {
        if (widgetList.get(i).name == "NewCanvasSetupWindow")
        {
          //Add code to setup canvas
        }
        
        widgetList.remove(i);
        i--;
      }
    }
    
    super.mouseReleased();
  }
}
