class Canvas extends UIManager
{
  //The dimentions of the resultant PImage
  int canvasWidth;
  int canvasHeight;
  
  //Displays the current level of zoom
  TextInput tbxZoom;
  //Stores the currently selected layers index
  private int layerIndex = -1;
  
  //Stores a list of layers
  private ArrayList<Layer> layers = new ArrayList<Layer>();
  
  Canvas(int canWidth, int canHeight)
  {
    canvasWidth= canWidth;
    canvasHeight = canHeight;
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
      //Centers canvas body
      x = 25 + (((width-150-25) / 2) - (w / 2));
      y = (height / 2) - (h / 2);
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
      
      //Centers canvas body
      x = 25 + (((width-150-25) / 2) - (w / 2));
      y = (height / 2) - (h / 2);
      
      //Scales all images on the canvas
      for (Layer l: layers)
      {
        l.scaleAfterReize(scalar);
      }
      
      tbxZoom.setString((scalar * 100) + "%");
    }
    
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
    //println("canavas " + id);
  }
  
  void resize(int dtW, int dtH)
  {
    super.resize(dtW,dtH);
    //Scales canvas to the new size of the window
    autoSetSize();
  }
  
  //Saves image to png file
  void export(File outputDir)
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
          output.set(x + l.offsetX,y + l.offsetY,l.actImage.get(x,y));
        }
      }
    }
    //output.save(dataPath("") + "scaleUp1_bilinear.png");
    output.save(outputDir.getAbsolutePath() + ".png");
  }
  
  //Sets the active layer
  void setLayerIndex(int i)
  {
    //println("AHoifadofhadono");
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
  
  
  void mouseDragged()
  {
      if (layerIndex != -1)
      {
        //println(layerIndex);
        //print("Why are you running");
        layers.get(layerIndex).mouseDragged();
      }
  }
  
  void mousePressed()
  {
      if (layerIndex != -1)
      {
        //println(layerIndex);
        //print("Why are you running");
        layers.get(layerIndex).mousePressed();
      }
  }
  
  void mouseMoved()
  {
      if (layerIndex != -1)
      {
        //println(layerIndex);
        //print("Why are you running");
        layers.get(layerIndex).mouseMoved();
      }
  }
  
}
