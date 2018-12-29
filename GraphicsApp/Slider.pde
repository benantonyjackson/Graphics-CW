class Slider extends Widget
{
  int rectX;
  int min, max;
  float value;
  
  TextInput textInput;
  
  Slider(int x, int y, int w, int min, int max)
  {
    this.x = x;
    this.y = y - 5;
    this.w=w;
    this.min = min;
    this.max=max;
    h = 10;
    
    rectX = x + (w/2);
    
    //rect(rectX, y - 5, 7, 10);
    
    textInput = new TextInput(x+w+10, y, Float.toString(value), 12);
    
  }
  
  
  void mouseDragged()
  {
    if (clicked)
    {
      rectX = clamp(mouseX, x, x+ w);
    
      getValue();
    
      textInput.setString(Float.toString(value));
    }
  }
  
  void mouseReleased()
  {
    if (clicked)
    {
      rectX = clamp(mouseX, x, x+ w);
    
      getValue();
    
      textInput.setString(Float.toString(value));
    }
  }
  
  float getValue()
  {
    value = ((float)rectX - (float)x) / ((float)w);
    
    value = ((float)(max - min) * value) + min;
    
    return value;
  }
  
  void draw()
  {
    fill(0,0,0);
    rect(x,y + 5,w,0);
    
    rect(rectX, y, 7, 10);
    
    textInput.draw();
  }
}
