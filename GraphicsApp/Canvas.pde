class Canvas extends UIManager
{
  //The dimentions of the resultant PImage
  int canvasWidth = 520;
  int canvasHeight = 520;
  
  //Displays the current level of zoom
  TextInput tbxZoom;
  //Stores the currently selected layers index
  private int layerIndex;
  
  //Stores a list of layers
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
    float scalar;
    
    //Scales the canvas on the X axsis
    //if (w > width - 150 || w == 0)
    {
      scalar = ((float)(width - 150) / (float)canvasWidth);
      
      w = (int)((float)canvasWidth * scalar);
      h = (int)((float)canvasHeight * scalar);
      
      //Scales all images on the canvas
      for (Layer l: layers)
      {
        l.scaleAfterReize(scalar);
      }
      
      tbxZoom.setString(scalar * 100 + "%");
    }
    
    //Scales the canvas on the y axsis
    if (h > height - 25 || h == 0)
    {
      scalar = ((float)(height - 150) / (float)canvasHeight);
      
      w = (int)((float)canvasWidth * scalar);
      h = (int)((float)canvasHeight * scalar);
      //Scales all images on the canvas
      for (Layer l: layers)
      {
        l.scaleAfterReize(scalar);
      }
      tbxZoom.setString((scalar * 100) + "%");
    }
    //Centers canvas body
    x = 25 + (((width-150-25) / 2) - (w / 2));
    y = (height / 2) - (h / 2);
  }
  
  void draw()
  {
    //Draws canvas body
    fill(color(255,255,255));
    rect(x,y,w,h);
    
    super.draw();
    
    //Draws layers
    for (Layer l: layers)
    {
      l.draw();
    }
  }
  
  void resize(int dtW, int dtH)
  {
    super.resize(dtW,dtH);
    //Scales canvas to the new size of the window
    autoSetSize();
  }
  
  //Saves image to png file
  void export()
  { 
    //Stores the image to be written to disk
    PImage output = new PImage(canvasWidth, canvasHeight);
    //Writes each layer to the output image
    for (Layer l: layers)
    {
      for (int x = 0; x < l.actImage.width; x++)
      {
        for (int y = 0; y < l.actImage.height; y++)
        {
          output.set(x,y,l.actImage.get(x,y));
        }
      }
    }
    output.save(dataPath("") + "scaleUp1_bilinear.png");
  }
  
  //Sets the active layer
  void setLayerIndex(int i)
  {
    layerIndex = i;
    
  }
  
  //Adds a new picture layer to the project
  public void addLayer(File sourceImage)
  {
    layers.add(new Layer(sourceImage));
    
    layerSelector.addLayer();
    
    autoSetSize();
  }
  
  //gets the current layer index
  int getLayerIndex()
  { 
    return layerIndex;
  }
}
