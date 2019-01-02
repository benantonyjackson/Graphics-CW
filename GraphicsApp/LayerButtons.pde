class LayerButtons extends RadioButtons
{
  void add (Button btn)
  {
    super.add(btn);
    
    h += btn.h;
    println(h);
    btn.aligned = ALLIGNMENT.right;
  }
}
