public enum Orientation
{
  vertical, horrizontal
}
class ScrollBar extends Widget
{
  
  int l;
  Orientation o;
  int max;
  int barSize;
  
  float value, rectX, rectY;
  
 
  
  
  ScrollBar(int x, int y, int l, Orientation orientation, int max)
  {
    this.x=x;
    this.y=y;
    this.l = l;
    o = orientation;
    
    this.max = max;
    
    rectX = x;
    rectY = y;
    
    if (o == Orientation.vertical)
    {
       h = l;
       w = 10;
    }
    else 
    {
      w = l;
      h = 10;
    }
    
    setMax(max);
  }
  
   
  void setMax (int newMax)
  {
    max = newMax;
    
    barSize = l - (int)(((float)max / (float)l) * l);
  }
  
  void mouseDragged()
  {
    //Keeps the bar within bounds of the scroll bar
    if (clicked)
    {      
      if (o == Orientation.vertical)
      {
         rectY = clamp(mouseY - (barSize/2), y, (y+h)- barSize);      
      }
      else
      {
        rectX = clamp(mouseX - (barSize/2), x, (x+ w) - barSize);
      }
      //Calculates the current selected value
      getValue();
    }
  }
  
  void mouseReleased()
  {
    //Keeps the bar within bounds of the scroll bar
    if (clicked)
    {
      if (o == Orientation.vertical)
      {
         rectY = clamp(mouseY - (barSize/2), y, (y+h) - barSize);      
      }
      else
      {
        rectX = clamp(mouseX - (barSize/2), x, (x+ w) - barSize);
      }
     //Calculates the current selected value
     getValue();
    }
  }
  
  float getValue()
  {
    int min = 0;
    float pos;
    int begin, end;
    
    //Calculates the position of the bar, the begining of the scrollbar and the end of the scroll bar depending on the orientation of the scroll bar
    if (Orientation.vertical == o)
    {
      pos = rectY;
      begin = y;
      end = h;
    }
    else
    {
      pos =  rectX;
      begin = x;
      end = w;
    }
    
    //Calcuates the value of the scroll bar
    value = ((float)pos - (float)begin) / (((float)end - (float)barSize));
    value = ((float)(max - min) * value) + min;
    
    return value;
  }
  
  
  void draw()
  {
    fill(255,255,255);
    rect(x, y, w, h);
      fill(0,0,0);
      if (o == Orientation.vertical)
      {
        rect(rectX,rectY,10, barSize);
      }
      else
      {
        rect(rectX,rectY,barSize,10);
      }
  }
  
}
