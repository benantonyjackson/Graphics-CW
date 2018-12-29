class RadioButtons extends UIManager
{
  //ArrayList<Button> buttonList = new ArrayList<Button>();
  
  int activeButton = -1;
  
  
  RadioButtons()
  {
    untoggleAfterClick = false;
    
  }
  
  void mouseReleased()
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseReleased();
      
      if (i != activeButton && widgetList.get(i).toggled)
      {
        if (activeButton != -1)
        widgetList.get(activeButton).toggled = false;
        
        activeButton = i;
      }
    }
  }
  
  void add(Button btn)
  {
    btn.toggleable = true; 
    btn.untoggleAfterClick = false;
    widgetList.add(btn);
  }
 
}
