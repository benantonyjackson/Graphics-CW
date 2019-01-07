class Label extends Widget
{
  //String that the lable displayes
  String s;
  //Font size of text
  int size = 12;
  
  color textColor = color(255,255,255);
  boolean border = false;
  color borderColor = color(0,0,0);
  
  Label()
  {}
  
  Label(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  Label(int x, int y, int size)
  {
    this.x = x;
    this.y = y;
    setFontSize(size);
  }
  
  Label (int x, int y, String s)
  {
    this.x = x;
    this.y = y;
    setString(s);
  }
  
  Label (int x, int y, String s, int size)
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
  
  //Calculates width and height of the text
  protected void setSize()
  {
    textSize(size);
    textAlign(LEFT, TOP);
    if (s.length() > 0)
    { 
      w = (int)textWidth(s);
    }
    else
    {
      //Sets the width to 10 if label has no text so that the user can still click on the lable
      w = 10;
    }
    h = (int)(textAscent() + textDescent());

  }
  
  void draw()
  {
    //if the lable is visible 
    if (active)
    {
      //Checks if the lable has a boarder
      if (border)
      {
        fill(borderColor);
      
        noFill();
      
        rect(x,y,w,h);
      }
      
      textAlign(LEFT, TOP);
      fill(textColor);
      textSize(size);
      
      text(s,x,y);
    }
  }
}
