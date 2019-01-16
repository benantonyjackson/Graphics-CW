import java.io.Serializable;

class Canvas extends UIManager implements Serializable
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
      //output.println(data);
      //data += "/";
      //output.println(data);
      //data = "";
    }

    //PrintWriter output = createWriter(outputDir.getAbsolutePath() + ".gff");
    //output.println(data);
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
         //print(i);
         
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
}
