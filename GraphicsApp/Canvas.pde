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
    tbxZoom.aligned = ALLIGNMENT.bottom_right;
    tbxZoom.name = "";
    tbxZoom.allignX = 180;
    tbxZoom.allignY = 10;
    add(tbxZoom);
    
    autoSetSize();
  }
  
  void autoSetSize()
  {
    //x = 25;
    //y = 25;
    float scalar;
    
    //if (w > width - 150 || w == 0)
    {
      scalar = ((float)(width - 150) / (float)canvasWidth);
      
      w = (int)((float)canvasWidth * scalar);
      h = (int)((float)canvasHeight * scalar);
      
      for (Layer l: layers)
      {
        l.scaleAfterReize(scalar);
      }
      
      tbxZoom.setString(scalar * 100 + "%");
    }
    
    if (h > height - 25 || h == 0)
    {
      scalar = ((float)(height - 150) / (float)canvasHeight);
      
      w = (int)((float)canvasWidth * scalar);
      h = (int)((float)canvasHeight * scalar);
      for (Layer l: layers)
      {
        l.scaleAfterReize(scalar);
      }
      tbxZoom.setString((scalar * 100) + "%");
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
    //print("sadasdsax");
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
