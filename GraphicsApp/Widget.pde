//Enums used to define a widgets behavior when the window is resized
public enum ALLIGNMENT
  {
    non, center, left, right, top, bottom, top_left, top_right, bottom_left, bottom_right, center_top, center_bottom, center_left, center_right
  }

//Ensures that a value is within givin minimum and maximum values
public float clamp(float val, float min, float max)
{
  if (val < min)
    return min;
  if (val > max)
    return max;
  return val;
}
//Ensures that a value is within givin minimum and maximum values
public int clamp(int val, int min, int max)
{
  if (val < min)
    return min;
  if (val > max)
    return max;
  return val;
}

class Widget implements Serializable
{ 
  //defines a widgets behavior when the window is resized
  ALLIGNMENT aligned = ALLIGNMENT.non;
  
  //Identifier used to address widgets when retrieved from a list
  String name;
  
  //Assigned by a UI manager when add function is used
  int id = -1;

  //When true the widget should be removed from the UI manager
  boolean closed = false;
  
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
  boolean toggleable = false;
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
    
    if (clicked)
    {
      mouseOffsetX = mouseX - x;
      mouseOffsetY = mouseY - y;
    }
    else
    {
      mouseOffsetX = 0;
      mouseOffsetY = 0;
    }
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
  
  boolean draggable = false;
  int mouseOffsetX = 0;
  int mouseOffsetY = 0;
  
  void mouseDragged()
  {
     
    if (!clicked)
    {
      mouseIsIn = checkMouseIsIn();
      
    }
    else
    {
      if (draggable)
      {
        x = mouseX - mouseOffsetX;
        y = mouseY - mouseOffsetY;
      }
    }
    
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
    //Moves widget when the window is resized depending on how they are aligned
    
    if (aligned == ALLIGNMENT.right || aligned == ALLIGNMENT.top_right)
    {
      x = width - allignX;
    }
    else if (aligned == ALLIGNMENT.center)
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
    else if (aligned == ALLIGNMENT.center_top)
    {
      x = (width / 2) - (w / 2);
    }
    
  }

  void setPosition(int x, int y)
  {
    this.x=x;
    this.y=y;
  }
  
  int x;
  int y;
  int w;
  int h;
}
