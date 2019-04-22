class Slider extends Widget
{
  int rectX;
  int min, max;
  private float value;
  private int oldX;
  TextInput textInput;
  
  Slider(int x, int y, int w, int min, int max)
  {
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
    //Keeps the bar within bounds of the slider
    if (clicked)
    {
      rectX = clamp(mouseX, x, x+ w);
      
      //Gets current value of the slider
      getValue();
      
      //Displays current value of the slider
      textInput.setString(Float.toString(value));
    }

    rectX += x - oldX;

    oldX = x;
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

  void setValue(float val)
  {
    //Restricts the value of the slider
    value = clamp(val, min, max);

    //Sets the position of the rotation
    rectX = (int) map(value, min, max, x, w);

    //Changes the display text
    textInput.setString(Float.toString(value));

  }
  
  void resize(int dtW, int dtH)
  {
    super.resize(dtW, dtH);

    textInput.aligned = aligned;
    textInput.allignX = allignX;
    textInput.allignY = allignY;

    textInput.resize(dtW, dtH);
  }

  void draw()
  {
    textInput.x= x+w+10;
    textInput.y = y;

    fill(0,0,0);
    //Draws the line which shows where the slide bar begins and ends
    rect(x,y + 5,w,0);
    //Draw the bar that the user slides
    rect(rectX, y, 7, 10);
    
    textInput.draw();
  }
}
