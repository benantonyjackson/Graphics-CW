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
    x = 50;
    y = 50;
    
    w = width - 100;
    h = height - 100;
  }
  
  void draw()
  {
    fill(color(255,255,255));
    
    rect(x,y,w,h);
  }
  
  void resize(int dtW, int dtH)
  {
    autoSetSize();
  }
}
