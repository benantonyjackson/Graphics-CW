class Canvas extends Widget
{
  //The dimentions of the resultant PImage
  int canvasWidth;
  int canvasHeight;
  private int layerIndex;
  
  private ArrayList<Layer> layers = new ArrayList<Layer>();
  
  Canvas()
  {
    autoSetSize();
    
   
  }
  
  void autoSetSize()
  {
    x = 25;
    y = 25;
    
    w = width - 150;
    h = height - 50;
  }
  
  void draw()
  {
    fill(color(255,255,255));
    
    rect(x,y,w,h);
    
    for (Layer l: layers)
    {
      l.draw();
    }
  }
  
  void resize(int dtW, int dtH)
  {
    autoSetSize();
  }
  
  void setLayerIndex(int i)
  {
    layerIndex = i;
    
  }
  
  public void addLayer(File sourceImage)
  {
    layers.add(new Layer(sourceImage));
    
    layerSelector.addLayer();
  }
  
  int getLayerIndex()
  { 
    return layerIndex;
  }
}
