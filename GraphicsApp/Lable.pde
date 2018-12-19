class Lable extends Widget
{
  String s;
  int size = 12;
  
  color textColor = color(255,255,255);
  
  
  Lable(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  Lable(int x, int y, int size)
  {
    this.x = x;
    this.y = y;
    setFontSize(size);
  }
  
  Lable (int x, int y, String s)
  {
    this.x = x;
    this.y = y;
    setString(s);
  }
  
  Lable (int x, int y, String s, int size)
  {
    this.x = x;
    this.y = y;
    setString(s);
    setFontSize(size);
  }
  
  void setFontSize(int size)
  {
    this.size = size;
    setSize();
  }
  
  void setString(String s)
  {
    this.s = s;
    setSize();
  }
  
  protected void setSize()
  {
    
    textSize(size);
    
    w = (int)textWidth(s);
    h = (int)(textAscent() + textDescent());
  }
  
  void draw()
  {
    if (active)
    {
      fill(textColor);
      textSize(size);
      
      text(s, x,y,w,h);
    }
  }
}
