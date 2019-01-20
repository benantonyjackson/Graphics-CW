class LayerButtons extends RadioButtons
{
  
  boolean layerChanged = false;
  
  LayerButtons()
  {
    x = width - 120;
    y = 45;
    allignX = 120;
    aligned = ALLIGNMENT.right;
    name = "LayerButtons";  
  }
  
  
  void add (Button btn)
  {
    super.add(btn);
    allignX = 120;
    btn.allignX = 120;
    h += btn.h;
    
    if (btn.w > w)
    {
      w = btn.w;
    }
    
    //println(h);
    
    btn.name = "LayerButton";
    btn.aligned = ALLIGNMENT.right;
  }
  
  void mouseReleased()
  {
    super.mouseReleased();

    //print(clickedList.size());

    if (clickedList.size() > 1)
    {
      layerChanged = true;
    }
    else 
    {
      layerChanged = false;
    }
  }
}
