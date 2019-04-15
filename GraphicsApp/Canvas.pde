import java.io.Serializable;

color selectedColor = color(0,0,0);

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

  undoListNode undoList = new undoListNode();
  undoListNode head = undoList;
  
  Slider rotation;

  //Layer oldLayer;
  
  Canvas()
  {

  }

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

    rotation = new Slider(10, height - 20, 100, 0, 360);
    rotation.aligned = ALLIGNMENT.bottom;
    rotation.allignY = 20;
    add(rotation);
    
    autoSetSize();
  }
  
  void addPolygon(boolean filled, boolean closedShape, color lineColor, color fillColor)
  {
    if (layerIndex > -1)
    {
      saveLayersToUndo(true);
      layers.get(layerIndex).addPolygon(filled,closedShape,lineColor,fillColor);
    }
    
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
    try
    {
      
      for (Layer l: layers)
      {
        l.draw();
      }
    }
    catch (Exception ex)
    {
      
    }
    
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
    //Testing using pgraphic
    PGraphics pg = createGraphics(canvasWidth, canvasHeight);
    pg.beginDraw();
    //pg.image(output,0,0);
    for (Layer l: layers)
    {
      l.flatten(pg);
    }
    pg.save(outputDir.getAbsolutePath() + ".png");
  }
  
  //Sets the active layer
  void setLayerIndex(int index)
  {
    if (layerIndex >= 0)
    layers.get(layerIndex).setSelected(false);

    layerIndex = index;

    if (layerIndex >= 0)
    layers.get(layerIndex).setSelected(true);
    if (layerIndex >= 0)
    rotation.setValue(layers.get(layerIndex).getRotation());
  }
  
  //Adds a new picture layer to the project
  public void addLayer(File sourceImage)
  {
    layers.add(new Layer(sourceImage));
    
    layerSelector.addLayer();
    
    autoSetSize();
  }
  
  public void addLayer(PImage sourceImage, int ox, int oy)
  {
    layers.add(new Layer(sourceImage, ox, oy));
    
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
    super.mouseDragged();
      if (layerIndex != -1)
      {
        layers.get(layerIndex).mouseDragged();
      }
  }

  void saveLayersToUndo(boolean cloneCurrentLayer)
  {
          undoList.layers = new ArrayList<Layer>();
          for (int i = 0; i < layers.size(); i++)
          {
            if (i == layerIndex && cloneCurrentLayer)
            {
              println("Point b");
              layers.get(i).changed = true;
              undoList.layers.add(layers.get(layerIndex).clone());
            } 
            else if (layers.get(i).changed)
            {
              
              undoList.layers.add(layers.get(i).clone());
              layers.get(i).changed = false;
            }
            else
            {
              undoList.layers.add(null);
            }
          }
  }
  
  void mousePressed()
  {
    super.mousePressed();
      if (layerIndex != -1)
      {
        
        layers.get(layerIndex).mousePressed();
        saveLayersToUndo(layers.get(layerIndex).clicked);
      }
  }
  
  void mouseMoved()
  {
    super.mouseMoved();
      if (layerIndex != -1)
      {
        layers.get(layerIndex).mouseMoved();
      }
  }

  void mouseReleased()
  {
    super.mouseReleased();

    if (layerIndex != -1)
    {
      layers.get(layerIndex).mouseReleased();

      if (layers.get(layerIndex).wasClicked == true)
      { 
        //Saves the current undo node
        undoList.forward = new undoListNode();
        undoList.forward.backward = undoList;
        undoList = undoList.forward;
        
        //undoList.l = layers.get(layerIndex).clone();
        //undoList.layerIndex = layerIndex+0;
        
        //Sets up the current node
        undoList.layers = new ArrayList<Layer>();
        for (int i = 0; i < layers.size(); i++)
        {
          // (i == layerIndex)
          if (layers.get(i).changed || layers.get(i).wasClicked)
          {
            
            undoList.layers.add(layers.get(i).clone());
            layers.get(i).changed = false;

          } 
          else
          {
            undoList.layers.add(null);
          }
        }
        
        //layers.get(layerIndex).changed = true;
        layers.get(layerIndex).changed = true;

        layers.get(layerIndex).wasClicked = false;
      }
    }

  }
  

  void saveCanvas(File outputDir)
  {
    int time = millis();
    PrintWriter output = createWriter(outputDir.getAbsolutePath() + ".gff");
    
    //String header;

    String data = "";
    
    data += canvasWidth;
    output.println(data);
    data = "";
    data += canvasHeight;
    output.println(data);
    data = "";

    for (Layer l: layers)
    {
      PImage img = l.actImage;
     // println("Point b");
      l.actImage.loadPixels();
     // println("Point c");

      data += img.width;
      data += ".";
      data += img.height;
      data += ".";
      data += l.offsetX;
      data += ".";
      data += l.offsetY;
      //data += ".";
      output.println(data);
      data = "";
      int i = 0;
      for (int x = 0; x < img.width; x++)
      {
        for (int y = 0; y < img.height; y++)
          {
            color currentPixel = img.pixels[i++];
            
            //Gets red chanel value
            data += (currentPixel >> 16) & 0xFF;
            data += ".";
            //Gets green chanel value
            data += (currentPixel >> 8) & 0xFF;
            data += ".";
            //Gets blue chanel value
            data += currentPixel & 0xFF;
            data += ".";
            //Gets Alhpa chanel value
            data += (currentPixel >> 24) & 0xFF;

            //curr
            output.println(data);
            data = "";
          }
      }
      println("Point a");
    }

    output.println("/");
    output.flush();
    output.close();
    
    print("Time:" + (millis() - time));
  }
  
  void loadProject(String [] Pixels)
  {
    String line;
    int i = 2;
    
    while (true)
    {
      
      line = Pixels[i++];
      
      if (line.contains("/"))
      {
        break;
      }
      
      int tempW = Integer.parseInt(split(line, ".")[0]);
      int tempH = Integer.parseInt(split(line, ".")[1]);
      int tempX = Integer.parseInt(split(line, ".")[2]);
      int tempY = Integer.parseInt(split(line, ".")[3]);
      
      PImage outputImage = new PImage(tempW, tempH);
      
      for (int y = 0; y < tempH; y++)
      {
       for (int x = 0; x < tempW; x++)
       {
         line = (String)Pixels[i++];
         String [] pixel = split(line, '.');
         
         int r = Integer.parseInt(pixel[0]);
         int g = Integer.parseInt(pixel[1]);
         int b = Integer.parseInt(pixel[2]);
         int a = Integer.parseInt(pixel[3]);
         
         color currentPixel = color(r,g,b,a);
         
         outputImage.set(x,y,currentPixel);
         
        } 
     
       }
     addLayer(outputImage, tempX, tempY);
     
    }
    
   autoSetSize();
   
  }

  void undo()
  {
    if (undoList.backward == null)
    {
      //TODO:
      //Disable undo button 
      println("Cannot undo anymore");
      return;
    }

    undoList = undoList.backward;
    
    //Adds old layer to the layer list
    ArrayList<Layer> tempLayerList = new ArrayList<Layer>();
    
    for (int i = 0; i < undoList.layers.size(); i++)
    {
      if (undoList.layers.get(i) != null)
      {
        tempLayerList.add(undoList.layers.get(i).clone());
      }
      else
      {
        tempLayerList.add(layers.get(i));
      }
    }

    layers = tempLayerList;
    
    autoSetSize();
    
  }

  void redo()
  {  
    if (undoList.forward == null)
    {
      //TODO:
      //Disable undo button 
      println("Cannot redo anymore");
      return;
    }
    //if (undoList.backward == null)
    undoList = undoList.forward;
    
    ArrayList<Layer> tempLayerList = new ArrayList<Layer>();
    
    for (int i = 0; i < undoList.layers.size(); i++)
    {
      if (undoList.layers.get(i) != null)
      {
        tempLayerList.add(undoList.layers.get(i).clone());
      }
      else
      {
        tempLayerList.add(layers.get(i));
      }
    }
    
    layers = tempLayerList;
    //if (undoList.backward != null)
    //undoList = undoList.forward;
    autoSetSize();
  
  }

  //Filters

  void blackAndWhite()
  {
    if (layerIndex != -1)
      {
        layers.get(layerIndex).blackAndWhite();
      }
  }


}// End of canvas class


class undoListNode
{
  ArrayList<Layer> layers = new ArrayList<Layer>();
  undoListNode forward;
  undoListNode backward;
  
  undoListNode ()
  {
  }

  
}
