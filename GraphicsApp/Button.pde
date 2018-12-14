class Button extends Clickable
{
  
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
  
  void draw()
  {
    if (mouseIsIn())
    {
      fill(color(155,155,155));
    }
    else 
    {
      fill(color(200,200,200));
    }
    
    rect(x,y,w,h);
  }
}
