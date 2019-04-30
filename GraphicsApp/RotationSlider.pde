class RotationSlider extends Slider
{
  
  RotationSlider(int x, int y, int w, int min, int max)
  {
    //Slider(x,y,w,min,max);
    this.x = x;
    oldX = x;
    this.y = y - 5;
    this.w=w;
    this.min = min;
    this.max=max;
    h = 10;
    
    rectX = x + (w/2);
    
    textInput = new TextInput(x+w+10, y, Float.toString(value), 12);
    
  }
  
  void mouseDragged()
  {
    super.mouseDragged();
    
    if (clicked)
    {
    if (canvas != null)
    {
      if (canvas.layerIndex > -1)
      {
        Layer l = canvas.layers.get(canvas.layerIndex);

        if (l.selectedShape != null)
        {
          //l.selectedShape.setRotation(toggled);
        }
      }
    }
    }
  }
  
  void mouseReleased()
  {
    super.mouseReleased();
    
    
  }
  
  void WidgetClickEvent()
  {
    if (canvas != null)
    {
      if (canvas.layerIndex > -1)
      {
        Layer l = canvas.layers.get(canvas.layerIndex);

        if (l.selectedShape != null)
        {
          //l.selectedShape.setFilled(toggled);
        }
      }
    }
  }
}