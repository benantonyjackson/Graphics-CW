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
    //If the user has clicked on the text input to type in it
    if (toggled)
    {
    char k = key;
    if (k == CODED)
    {
     
    }
    else 
    {
      //If the current keystroke is backspace or delete
      if (k == BACKSPACE || k == DELETE)
      {
        //Remove the character at the end of the string list
        if (s.length() > 0)
        {
          setString(s.substring(0, s.length() - 1));
        }
      }
      //If user pressed enter
      else if (k == ENTER)
      {
        //Deselects the text input
        toggled = false;
      }
      else
      {
        //Adds character to text
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
