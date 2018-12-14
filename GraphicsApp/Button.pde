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
    rect(x,y,w,h);
  }
}
