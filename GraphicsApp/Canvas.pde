class Canvas extends UIManager
{
  //The dimentions of the resultant PImage
  int canvasWidth = 300;
  int canvasHeight = 100;
  
  TextInput tbxZoom;
  
  private int layerIndex;
  
  private ArrayList<Layer> layers = new ArrayList<Layer>();
  
  Canvas()
  {
    //aligned = ALLIGNMENT.center;
    tbxZoom = new TextInput(width - 180, height - 10,"",10);
    
    add(tbxZoom);
    
    autoSetSize();
  }
  
  void autoSetSize()
  {
    //x = 25;
    //y = 25;
    
    if (canvasWidth > canvasHeight)
    {
      w = (int)((float)canvasWidth * ((float)(width - 150) / (float)canvasWidth));
      h = (int)((float)canvasHeight * ((float)(width - 150) / (float)canvasWidth));
      
      tbxZoom.setString((((width-150) / canvasWidth) * 100) + "%");
    }
    else 
    {
      w = (int)((float)canvasWidth * ((float)(height - 150) / (float)height));
      h = (int)((float)canvasHeight * ((float)(height - 150) / (float)height));
    }
    
    
    x = 25 + (((width-150-25) / 2) - (w / 2));
    y = (height / 2) - (h / 2);
    //w = width - 150;
    //h = height - 50;
  }
  
  void draw()
  {
    fill(color(255,255,255));
    
    rect(x,y,w,h);
    
    super.draw();
    
    for (Layer l: layers)
    {
      l.draw();
    }
  }
  
  void resize(int dtW, int dtH)
  {
    super.resize(dtW,dtH);
    autoSetSize();
    
    //super.resize(dtW, dtH);
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
