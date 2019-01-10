class LayerSelector extends UIManager 
{
  Button newLayer, upLayer, downLayer;
  ScrollBar scrollBar;
  LayerButtons layerButtons;
  
  int numberOfLayers = 0;
  
  LayerSelector()
  {
    x = width - 120;
    y = 20;
    newLayer = new Button ("New", x, y, 25, 15);
    newLayer.name = "newLayer";
    newLayer.allignX = 120;
    
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
    
    
    if (layerButtons.activeButton == -1)
    {
      canvas.setLayerIndex(-1);
    }
    else 
    {
      canvas.setLayerIndex(numberOfLayers - (layerButtons.activeButton + 1));
    }
    
    
  }
  
  void add (Widget widget)
  {
    super.add(widget);
    
    widget.aligned = ALLIGNMENT.right;
  }
  
  void addLayer()
  {
    layerButtons.add(new LayerButton("layer1", width - 120, y + 25 + layerButtons.h, 120, 40));
    numberOfLayers++;
  }
}
