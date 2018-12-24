class TextInput extends Label
{
  
  color toggledColor = color(0,0,255);
  
  TextInput (int x, int y, String s, int size)
  {
    super(x,y,s,size);
    border = true;
  }
  
  void keyPressed()
  {
    if (toggled)
    {
    char k = key;
    if (k == CODED)
    {
     
    }
    else 
    {
      
      if (k == BACKSPACE || k == DELETE)
      {
        if (s.length() > 0)
        {
          setString(s.substring(0, s.length() - 1));
        }
      }
      else if (k == ENTER)
      {
        toggled = false;
      }
      else
      {
        setString(s + k);
      }
    }
    }
  }
  
  void draw()
  {
    if (toggled)
    {
      
    }
    super.draw();
  }
}
