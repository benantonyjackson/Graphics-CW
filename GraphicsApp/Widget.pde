
public enum ALLIGNMENT
  {
    non, center, left, right, top, bottom, top_left, top_right, bottom_left, bottom_right, center_top, center_bottom, center_left, center_right
  }
  
public float clamp(float val, float min, float max)
{
  if (val < min)
    return min;
  if (val > max)
    return max;
  return val;
}

public int clamp(int val, int min, int max)
{
  if (val < min)
    return min;
  if (val > max)
    return max;
  return val;
}

class Widget
{ 
  
  ALLIGNMENT aligned = ALLIGNMENT.non;
  
  String name;
  
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
  
  //True if the user is able to see and interact with the widget
  boolean active = true;
  
  //True if the user is able to toggle to control with a mouse click
  boolean toggleable = true;
  //True if the widget is currently toggled on
  boolean toggled = false;
  boolean untoggleAfterClick = true;
  
  //True if the user is able to click on the widget
  boolean clickable = true;
  //True if the mouse is currently hovering the widget
  boolean mouseIsIn = false;
  //True if the user is currently clicking on the widget
  boolean clicked = false;
  //True if the user clicked on the widget
  boolean wasClicked = false;
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
    wasClicked = true;
  }
  
  void mouseClicked()
  {
  
  }
  
  void keyPressed()
  {
    
  }
  
  int allignX;
  int allignY;
  
  void resize(int dtW, int dtH)
  {
    //center_right
    if (aligned == ALLIGNMENT.right || aligned == ALLIGNMENT.top_right)
    {
      x = width - allignX;
    }
    else if (aligned == ALLIGNMENT.center || aligned == ALLIGNMENT.center_top)
    {
      x = (width / 2) - (w / 2);
      y = (height / 2) - (h / 2);
    }
    else if (aligned == ALLIGNMENT.bottom || aligned == ALLIGNMENT.bottom_left)
    {
      y = height - allignY;
    }
    else if (aligned == ALLIGNMENT.bottom_right)
    {
      x = width - allignX;
      y = height - allignY;
    }
    else if (aligned == ALLIGNMENT.center_bottom)
    {
      x = (width / 2) - (w / 2);
      y = height - allignY;
    }
    else if (aligned == ALLIGNMENT.center_left)
    {
      y = (height / 2) - (h / 2);
    }
    else if (aligned == ALLIGNMENT.center_right)
    {
      x = width - allignX;
      y = (height / 2) - (h / 2);
    }
    
    //println("dtx: " + dtW + " dtY: " + dtH);
  }
  
  int x;
  int y;
  int w;
  int h;
}
