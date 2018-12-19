class Canvas extends Widget
{
  //The dimentions of the resultant PImage
  int canvasWidth;
  int canvasHeight;
  
  
  Canvas()
  {
    autoSetSize();
  }
  
  void autoSetSize()
  {
    
  }
  
  void draw()
  {
    fill(color(255,255,255));
    
    rect(x,y,w,h);
  }
}
