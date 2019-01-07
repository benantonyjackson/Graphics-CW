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
    
    textInput = new TextInput(x+w+10, y, Float.toString(value), 12);
    
  }
  
  
  void mouseDragged()
  {
    //Keeps the bar within bounds of the slider
    if (clicked)
    {
      rectX = clamp(mouseX, x, x+ w);
      
      //Gets current value of the slider
      getValue();
      
      //Displays current value of the slider
      textInput.setString(Float.toString(value));
    }
  }
  
  void mouseReleased()
  {
    //Keeps the bar within bounds of the slider
    if (clicked)
    {
      rectX = clamp(mouseX, x, x+ w);
      //Gets current value of the slider
      getValue();
      //Displays current value of the slider
      textInput.setString(Float.toString(value));
    }
  }
  
  float getValue()
  {
    //Calculates the current value of the slider
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
