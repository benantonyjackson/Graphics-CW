class Button extends Widget
{
  //Text which is displayed inside of the button
  String text = "";
  color textColor = color(0,0,0);
  int textSize = 11;
  
  //Color of the button when the user his clicking and holding on the button
  color clickedColor = color(105,105,105);
  //Color of the button when button is active and the user is not interacting with the button
  color passiveColor = color(200,200,200);
  //Color of the button when the mouse is hovering over the button
  //Also the color of the toggled button
  color activeColor = color(155,155,155);
  //Color of the button when the user is not currently able to click the button
  color notClickableColor = color(75,75,75);
  
  //Used to determin how rounded the corners of the button are
  int cornerRadius = 0;
  
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
  
  Button(String s, String n)
  {
    text = s;
    name = n;
    
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
    super.WidgetClickEvent();
    //print(text + "\n");
  }
  
  void draw()
  {
    //If the button is visible
    if (active)
    {
      //If the mouse is currently within the button
     if (mouseIsIn)
     {
       //If the user is currently clicking the button
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
      //If the user is not currently able to click the button
      if (!clickable)
      {
        fill(notClickableColor);
      }
      //If the button is currently toggled
      else if (toggleable && toggled)
      {
       fill(activeColor); 
      }
      //if the user is not currently interacting with the button
      else
      {
        fill(passiveColor);
      }
      
    }
    
    rect(x,y,w,h,cornerRadius);
    
    fill(textColor);
    
    textSize(textSize);
    
    textAlign(CENTER, CENTER);
    
    text(text,x,y,w,h);

    }
    
    
    
  }
}
