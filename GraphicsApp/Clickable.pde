//Base class for clickable objects
class Clickable extends Widget
{
  boolean toggleable = true;
  
  boolean toggled = false;
  
  boolean mouseIsIn = false;
  boolean clicked = false;
  void mousePressed() 
  {
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
      print("Clicked!\n\n\n");
    }
  }
  
  void mouseMoved()
  {
    mouseIsIn = checkMouseIsIn();
  }
  
  void mouseDragged()
  {
    if (!clicked)
    mouseIsIn = checkMouseIsIn();
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
}
