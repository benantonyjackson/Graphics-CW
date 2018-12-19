class TextInput extends Label
{
  
  TextInput (int x, int y, String s, int size)
  {
    super(x,y,s,size);
    
  }
  
  void keyPressed()
  {
    char k = key;
    if (k == CODED)
    {
      print("mdsofnmosdn");
      //print("\n keyCode: " + keyCode);
    }
    else 
    {
      print ("grr");
      if (k == BACKSPACE || k == DELETE)
      {
        if (s.length() > 0)
        {
          setString(s.substring(0, s.length() - 1));
        }
      }
      else
      {
        setString(s + k);
      }
    }
  }
}
