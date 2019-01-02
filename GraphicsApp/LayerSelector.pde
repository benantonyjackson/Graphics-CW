class LayerSelector extends UIManager 
{
  Button newLayer, upLayer, downLayer;
  ScrollBar scrollBar;
  LayerButtons layerButtons;
  
  LayerSelector()
  {
    x = width - 120;
    y = 20;
    newLayer = new Button ("New", x, y, 25, 15);
    newLayer.name = "newLayer";
    
    add(newLayer);
    layerButtons = new LayerButtons();
    add(layerButtons);
    
  }
  
  void mouseReleased()
  {
    super.mouseReleased();
    for (String wdgt: clickedList)
    {
      if (wdgt == "newLayer")
      {
        //println(wdgt);
        addLayer();
      }
    }
  }
  
  void add (Widget widget)
  {
    super.add(widget);
    
    widget.aligned = ALLIGNMENT.right;
  }
  
  void addLayer()
  {
    layerButtons.add(new LayerButton("layer1", x, y + 25 + layerButtons.h, 120, 40));
  }
}
