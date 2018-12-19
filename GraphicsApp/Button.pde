class Button extends Widget
{
  
  color textColor = color(0,0,0);
  String text = "";
  int textSize = 11;
  
  color clickedColor = color(105,105,105);
  color passiveColor = color(200,200,200);
  color activeColor = color(155,155,155);
  color notClickableColor = color(75,75,75);
  
  
  
  Button()
  {
   this.x = 0;
   this.y = 0;
   this.w = 75;
   this.h = 32;
  }
  
  Button(String s)
  {
    text = s;
    
    this.x = 0;
    this.y = 0;
    this.w = 75;
    this.h = 32;
  }
  
  
  Button(String s, int x, int y, int w, int h)
  {
    text = s;
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
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
    print(text + "\n");
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
      if (!clickable)
      {
        fill(notClickableColor);
      }
      else if (toggleable && toggled)
      {
       fill(activeColor); 
      }
      else
      {
        fill(passiveColor);
      }
      
    }
    
    rect(x,y,w,h);
    
    fill(textColor);
    
    textSize(textSize);
    
    textAlign(CENTER, CENTER);
    
    text(text,x,y,w,h);

    }
    
    
    
  }
}
