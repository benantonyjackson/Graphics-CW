class Widget
{ 
  void draw()
  {
    
  }

  //Checks if the mouse is within the clickable object
  boolean checkMouseIsIn()
  {
    if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) 
    {
      return true;  
    } 
    else 
    {
      return false;
    }
  }
  
  boolean active = true;
  
  boolean toggleable = true;
  
  boolean toggled = false;
  boolean untoggleAfterClick = true;
  
  boolean clickable = true;
  
  boolean mouseIsIn = false;
  //True if the user is currently clicking on the widget
  boolean clicked = false;
  void mousePressed() 
  {
    if (clickable)
    clicked = mouseIsIn;
  }
  
  void mouseReleased()
  {
    clicked = false;
    mouseIsIn=checkMouseIsIn();
    if (mouseIsIn)
    {
      //Click Event
      toggled = !toggled;
      if (active && clickable)
      WidgetClickEvent();
    }
    else if (untoggleAfterClick)
    {
      toggled = false;
    }
    
    
  }
  
  void mouseMoved()
  {
    if (clickable)
    mouseIsIn = checkMouseIsIn();
  }
  
  void mouseDragged()
  {
    if (!clicked)
    mouseIsIn = checkMouseIsIn();
  }
  
  //Called after a widget has been clicked 
  void WidgetClickEvent()
  {
    
  }
  
  void mouseClicked()
  {
  
  }
  
  int x;
  int y;
  int w;
  int h;
}
