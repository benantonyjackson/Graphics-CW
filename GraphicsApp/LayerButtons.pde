class LayerButtons extends RadioButtons
{
  void add (Button btn)
  {
    super.add(btn);
    allignX = 120;
    btn.allignX = 120;
    h += btn.h;
    println(h);
    btn.aligned = ALLIGNMENT.right;
  }
}
