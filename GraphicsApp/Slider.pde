class Slider extends Widget
{
  int rectX;
  int min, max;
  Slider(int x, int y, int w, int min, int max)
  {
    this.x = x;
    this.y = y;
    this.w=w;
    this.min = min;
    this.max=max;
    
    rectX = 200;
  }
  
  
  void mouseDragged()
  {
    rectX = mouseX;
    
    
  }
  
  void mouseReleased()
  {
    float val = ((float)mouseX - (float)x) / ((float)x+(float)w);
    
    val = ((float)(max - min) * val) + min;
    
    
    println(val);
  }
  
  void draw()
  {
    fill(0,0,0);
    rect(x,y,w,0);
    
    rect(rectX, y - 5, 7, 10);
    
  }
}
