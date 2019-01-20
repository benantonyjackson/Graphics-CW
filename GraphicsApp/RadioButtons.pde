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
      
      //If the current button is toggled and the current button is not the currently selected button
      if (i != activeButton && widgetList.get(i).toggled)
      {
        //Checks that a button was previously selected
        if (activeButton != -1)
        //deselects the currently active button
        widgetList.get(activeButton).toggled = false;
        //Sets the current button as the active button
        activeButton = i;
      }
    }
    
    /*ArrayList<Widget> temp = widgetList;
    
    widgetList = new ArrayList<Widget>();
    
    super.mouseReleased();
    
    widgetList = temp;*/
  }
  
  void add(Button btn)
  {
    btn.toggleable = true; 
    btn.untoggleAfterClick = untoggleAfterClick;
    widgetList.add(btn);
  }
 
}
