class FloatingWindow extends UIManager
{
  private int titleBarSize = 20;
  
  CloseButton closeButton;
  
  FloatingWindow()
  {
    draggable = true;
    
    closeButton = new CloseButton(x+w - 20, y+h - 20, 20, 20);
    
    widgetList.add(closeButton);
  }
  
  void draw()
  {
    fill(windowColor);
    stroke(0);
    strokeWeight(1);
    rect(x,y,w,h);
    
    rect (x,y,w,titleBarSize);
    
    
    super.draw();
    
  }
  
  void mouseReleased()
  {
    closeButton.mouseReleased();
    if (closeButton.wasClicked)
    {
      closed = true;
      print
    }
    
    super.mouseReleased();
  }
  
  boolean checkMouseIsIn()
  {
    boolean res;
    int tempH = h;
    
    h = titleBarSize;
    res = super.checkMouseIsIn();
    h = tempH;
    
    return res;
  }
  
  void mouseDragged()
  {
    int dx = x;
    int dy = y;
    
    super.mouseDragged();
    
    dx = x - dx;
    dy = y - dy;
    
    for (Widget w: widgetList)
    {
      w.x += dx;
      w.y += dy;
    }
  }
  
  void add(Widget w)
  {
    w.x += x;
    w.y += y + titleBarSize;
    
    super.add(w);
  }
  
  void resize(int dxW, int dxH)
  {
    int dx = x;
    int dy = y;
    
    super.resize(dxW, dxH);
    
    dx = x - dx;
    dy = y - dy;
    
    for (Widget w: widgetList)
    {
      w.x += dx;
      w.y += dy;
    }
  }

}


class CloseButton extends Widget
{
  color fillColor = color(windowColor);
  
  CloseButton(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    name = "close button";
  }
  
  
  void draw()
  {
    if (mouseIsIn)
    {
     fill(color(255,0,0));
    }
    else
    {
     fill(fillColor);
    }
    
    
    rect(x,y,w,h);
    
    line(x + 3, y + 3, x + w - 3, y + h - 3);
    line(x + w - 3, y+3, x + 3, y + h - 3);
    
    
  }
}
