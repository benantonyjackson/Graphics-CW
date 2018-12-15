class Button extends Widget
{
  
  color clickedColor = color(105,105,105);
  color passiveColor = color(200,200,200);
  color activeColor = color(155,155,155);
  
  Button()
  {
   this.x = 0;
   this.y = 0;
   this.w = 100;
   this.h = 50;
  }
  
  Button(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void WidgetClickEvent()
  {
    print(clicked);
  }
  
  void draw()
  {
    if (active)
    {
    if (mouseIsIn)
    {
      if (clicked)
      {
        fill(clickedColor);
      }
      else
      {
        fill(activeColor);
      }
      
    }
    else 
    {
      if (toggleable && toggled)
      {
       fill(activeColor); 
      }
      else
      {
        fill(passiveColor);
      }
      
    }
    
    rect(x,y,w,h);

    }
    
    
    
  }
}
