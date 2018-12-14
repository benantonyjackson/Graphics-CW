//Base class for clickable objects
class Clickable extends Widget
{
  
  
  boolean mouseIsIn()
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
