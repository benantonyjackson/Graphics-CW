import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.io.FileOutputStream; 
import java.io.ObjectOutputStream; 
import java.io.FileInputStream; 
import java.io.ObjectInputStream; 
import java.io.Serializable; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class GraphicsApp extends PApplet {






UIManager ui;
UIManager drawingUI;

//Stores the size of the window in the previous frame.
//Used to determin if the window has been resized
int oldWidth;
int oldHeight;

int windowColor = color(25,25,25);

public Canvas canvas;
public LayerSelector layerSelector;

public void setup()
{
  
  
  oldWidth = width;
  oldHeight = height;
  
  surface.setResizable(true);
  ui = new UIManager(new MenuBar());
  ui.name="ui";
  
  
  
}

public void draw()
{
  //Checks if the window has been resized
  if (oldWidth != width || oldHeight != height)
  {
    ui.resize((width - oldWidth), (height - oldHeight));
  }
  
  //Stores the size of the window to be compared to the size of the window in the next frame
  oldWidth = width;
  oldHeight = height;
  
  //print("width: " + width + " height: " + height + "\n");
  
  background(25,25,25);
  
  
  ui.draw();
}

public void mousePressed() 
{
  ui.mousePressed();
}

public void mouseClicked ()
{
  ui.mouseClicked();
}

public void mouseMoved()
{
  ui.mouseMoved();
}

public void mouseReleased()
{
  ui.mouseReleased();
}

public void mouseDragged()
{
  ui.mouseDragged();
}

public void keyPressed()
{
  
  
  ui.keyPressed();
}

//Function called when the user adds a new picture to the project
public void addLayer(File sourceImage)
{
  canvas.addLayer(sourceImage);
}

//Function called when the user exports the image
public void export(File outputDir)
{
  canvas.export(outputDir);
}

public void setupNewCanvas (int w, int h)
{
  //ui.pop();
  
  /*if (drawingUI != null)
  drawingUI.closed = true;
  ui.clean();*/

  ui.remove(drawingUI);

  //Main UI 
  //*******************************
  
  drawingUI = new UIManager();
  canvas = new Canvas(w,h);
  drawingUI.add(canvas);
  layerSelector = new LayerSelector();
  drawingUI.add(layerSelector);
  
   
   //*******************************
   //end of Main ui
   
   ui.add(drawingUI);
}

NewCanvasUIManager newCanvasUIManager;

public void openCanvasConfigWindow()
{
  ui.remove(newCanvasUIManager);

  newCanvasUIManager = new NewCanvasUIManager();

  ui.add(newCanvasUIManager);
}

public void saveCanvas(File outputDir)
{
  //https://examples.javacodegeeks.com/core-java/io/fileoutputstream/how-to-write-an-object-to-file-in-java/
  //https://www.codementor.io/java/tutorial/serialization-and-deserialization-in-java
  canvas.saveCanvas(outputDir);
  /*try 
  {
    FileOutputStream fileOut = new FileOutputStream(outputDir.getAbsolutePath());
    ObjectOutputStream objectOut = new ObjectOutputStream(fileOut);
    objectOut.writeObject(canvas);
    objectOut.close();
  
  } 
  catch (Exception ex) 
  {
    ex.printStackTrace();
  }*/

  //String header;

}

public void loadProject(File inputDir)
{
  /*try {
         FileInputStream fileIn = new FileInputStream(inputDir.getAbsolutePath());
         ObjectInputStream in = new ObjectInputStream(fileIn);
         canvas = (Canvas) in.readObject();
         in.close();
         fileIn.close();
      } catch (IOException i) {
         i.printStackTrace();
         return;
      } catch (ClassNotFoundException c) {
         System.out.println("Employee class not found");
         c.printStackTrace();
         return;
      }*/
  String[] lines = loadStrings(inputDir.getAbsolutePath());
      
  setupNewCanvas(Integer.parseInt(lines[0]), Integer.parseInt(lines[1]));
  
  canvas.loadProject(lines);

}
class Button extends Widget
{
  //Text which is displayed inside of the button
  String text = "";
  int textColor = color(0,0,0);
  int textSize = 11;
  
  //Color of the button when the user his clicking and holding on the button
  int clickedColor = color(105,105,105);
  //Color of the button when button is active and the user is not interacting with the button
  int passiveColor = color(200,200,200);
  //Color of the button when the mouse is hovering over the button
  //Also the color of the toggled button
  int activeColor = color(155,155,155);
  //Color of the button when the user is not currently able to click the button
  int notClickableColor = color(75,75,75);
  
  //Used to determin how rounded the corners of the button are
  int cornerRadius = 0;
  
  Button()
  {
   this.x = 0;
   this.y = 0;
   this.w = 75;
   this.h = 32;
  }
  
  Button(String s)
  {
    text = s;
    
    this.x = 0;
    this.y = 0;
    this.w = 75;
    this.h = 32;
  }
  
  Button(String s, String n)
  {
    text = s;
    name = n;
    
    this.x = 0;
    this.y = 0;
    this.w = 75;
    this.h = 32;
  }
  
  
  Button(String s, int x, int y, int w, int h)
  {
    text = s;
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
  }
  
  Button(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public void WidgetClickEvent()
  {
    super.WidgetClickEvent();
    //print(text + "\n");
  }
  
  public void draw()
  {
    //If the button is visible
    if (active)
    {
      //If the mouse is currently within the button
     if (mouseIsIn)
     {
       //If the user is currently clicking the button
      if (clicked)
      {
        fill(clickedColor);
      }
      else
      {
        fill(activeColor);
      }
      
    }
    else 
    {
      //If the user is not currently able to click the button
      if (!clickable)
      {
        fill(notClickableColor);
      }
      //If the button is currently toggled
      else if (toggleable && toggled)
      {
       fill(activeColor); 
      }
      //if the user is not currently interacting with the button
      else
      {
        fill(passiveColor);
      }
      
    }
    
    rect(x,y,w,h,cornerRadius);
    
    fill(textColor);
    
    textSize(textSize);
    
    textAlign(CENTER, CENTER);
    
    text(text,x,y,w,h);

    }
    
    
    
  }
}


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
  
  public void autoSetSize()
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
  
  public void draw()
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
  
  public void resize(int dtW, int dtH)
  {
    super.resize(dtW,dtH);
    //Scales canvas to the new size of the window
    autoSetSize();
  }
  
  //Saves image to png file
  public void export(File outputDir)
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
  public void setLayerIndex(int i)
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
  public int getLayerIndex()
  { 
    return layerIndex;
  }
  
  
  public void mouseDragged()
  {
      if (layerIndex != -1)
      {
        //println(layerIndex);
        //print("Why are you running");
        layers.get(layerIndex).mouseDragged();
      }
  }
  
  public void mousePressed()
  {
      if (layerIndex != -1)
      {
        //println(layerIndex);
        //print("Why are you running");
        layers.get(layerIndex).mousePressed();
      }
  }
  
  public void mouseMoved()
  {
      if (layerIndex != -1)
      {
        //println(layerIndex);
        //print("Why are you running");
        layers.get(layerIndex).mouseMoved();
      }
  }
  

  public void saveCanvas(File outputDir)
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
            int currentPixel = img.pixels[i++];
            
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
  
  public void loadProject(String [] Pixels)
  {
    String line;
    int i = 2;
    
    while (true)
    {
      
      line = Pixels[i++];
      
      if (line == "/")
      {
        println("point b");
        break;
      }
      println(line);
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
         
         int currentPixel = color(r,g,b,a);
         
         outputImage.set(x,y,currentPixel);
         
        } 
     
       }
     addLayer(outputImage, tempX, tempY);
     
    }
    
    
   
   autoSetSize();
   
  }
}
class FloatingWindow extends UIManager
{
  private int titleBarSize = 20;
  
  CloseButton closeButton;
  
  FloatingWindow()
  {
    draggable = true;
    
    closeButton = new CloseButton(x+w - 20, y+h - 20, 20, 20);
    
    widgetList.add(closeButton);
  }


  
  public void draw()
  {
    fill(windowColor);
    stroke(0);
    strokeWeight(1);
    rect(x,y,w,h);
    
    rect (x,y,w,titleBarSize);
    
    
    super.draw();
    
  }
  
  public void mouseReleased()
  {
    closeButton.mouseReleased();
    if (closeButton.wasClicked)
    {
      closed = true;
//print
    }
    
    super.mouseReleased();
  }
  
  public boolean checkMouseIsIn()
  {
    boolean res;
    int tempH = h;
    
    h = titleBarSize;
    res = super.checkMouseIsIn();
    h = tempH;
    
    return res;
  }
  
  public void mouseDragged()
  {
    int dx = x;
    int dy = y;
    
    super.mouseDragged();
    
    dx = x - dx;
    dy = y - dy;
    
    for (Widget w: widgetList)
    {
      w.x += dx;
      w.y += dy;
    }
  }
  
  public void add(Widget w)
  {
    w.x += x;
    w.y += y + titleBarSize;
    
    super.add(w);
  }
  
  public void resize(int dxW, int dxH)
  {
    int dx = x;
    int dy = y;
    
    super.resize(dxW, dxH);
    
    dx = x - dx;
    dy = y - dy;
    
    for (Widget w: widgetList)
    {
      w.x += dx;
      w.y += dy;
    }
  }

}


class CloseButton extends Widget
{
  int fillColor = color(windowColor);
  
  CloseButton(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    name = "close button";
  }
  
  
  public void draw()
  {
    if (mouseIsIn)
    {
     fill(color(255,0,0));
    }
    else
    {
     fill(fillColor);
    }
    
    
    rect(x,y,w,h);
    
    line(x + 3, y + 3, x + w - 3, y + h - 3);
    line(x + w - 3, y+3, x + 3, y + h - 3);
    
    
  }
}
//End of close button class
class Label extends Widget
{
  //String that the lable displayes
  String s;
  //Font size of text
  int size = 12;
  
  int textColor = color(255,255,255);
  boolean border = false;
  int borderColor = color(0,0,0);
  
  Label()
  {}
  
  Label(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  Label(int x, int y, int size)
  {
    this.x = x;
    this.y = y;
    setFontSize(size);
  }
  
  Label (int x, int y, String s)
  {
    this.x = x;
    this.y = y;
    setString(s);
  }
  
  Label (int x, int y, String s, int size)
  {
    this.x = x;
    this.y = y;
    setString(s);
    setFontSize(size);
  }
  
  public void setFontSize(int size)
  {
    this.size = size;
    setSize();
  }
  
  public void setString(String s)
  {
    this.s = s;
    setSize();
  }
  
  //Calculates width and height of the text
  protected void setSize()
  {
    textSize(size);
    textAlign(LEFT, TOP);
    if (s.length() > 0)
    { 
      w = (int)textWidth(s);
    }
    else
    {
      //Sets the width to 10 if label has no text so that the user can still click on the lable
      w = 10;
    }
    h = (int)(textAscent() + textDescent());

  }
  
  public void draw()
  {
    //if the lable is visible 
    if (active)
    {
      //Checks if the lable has a boarder
      if (border)
      {
        fill(borderColor);
      
        noFill();
      
        rect(x,y,w,h);
      }
      
      textAlign(LEFT, TOP);
      fill(textColor);
      textSize(size);
      
      text(s,x,y);
    }
  }
}
class Layer extends Widget
{
  //Image that is actually used to write to file
  PImage actImage;
  //Image that is diplayed to the screen
  PImage disImage;
  
  //Stores the position of the actual image for exporting the image
  //The widget x and y are used for the display image
  int offsetX = 100;
  int offsetY = 100;
  
  
  float scalar;
  
  
  Layer(File sourceImage)
  {
    //Loads the image that the layer is made of into memory
    actImage = loadImage(sourceImage.getAbsolutePath());
    
    disImage = actImage;
    
    name = "layer";
    
    draggable = true;
  }
  
  Layer(PImage p, int ox, int oy)
  {
    actImage = p;
    
    name = "layer";
    
    draggable = true;
    
    offsetX = ox;
    offsetY = oy;
  }
  
  public void draw()
  {
    image(disImage, x, y);
  }
  
  public void scaleAfterReize(float scalar)
  {
    //Scales display image to the size of the canvas 
    disImage = scaleUp_bilinear((int)((float)actImage.width * scalar), (int)((float)actImage.height * scalar), actImage);
    
    w = disImage.width;
    h = disImage.height;
    
    x = (int)((float)offsetX * scalar) + canvas.x;
    y = (int)((float)offsetY * scalar) + canvas.y;
    
    this.scalar = scalar;
  }
  
  public void mouseDragged()
  {
    super.mouseDragged();
    
    offsetX = (int)(((float)x - (float)canvas.x) / scalar);
    offsetY = (int)(((float)y - (float)canvas.y) / scalar);
    
  }
 
 //Start of Functions
public PImage scaleUp_bilinear(int destinationImageWidth, int destinationImageHeight, PImage img){
  //Create a blank image for the destination imgage
  PImage destinationImage = new PImage(destinationImageWidth, destinationImageHeight);
  //Loops through each pixel in the destination image
  for (int y = 0; y < destinationImageHeight; y++) {
    for (int x = 0; x < destinationImageWidth; x++){
      //Scales coordinates to origonal image pixel coordinates
      float parametricX = (x/(float)destinationImageWidth);
      float parametricY = (y/(float)destinationImageHeight); 
      
      //Gets the pixel color of the current pixel
      int thisPix = getPixelBilinear(parametricX,parametricY, img);
      destinationImage.set(x,y, thisPix);
    }
  
  }
  return destinationImage;
} 
 
 
public float getMantisa(float n)
{
  return n - ((int) n);
}


public int getPixelBilinear(float x, float y, PImage img){
  
  // scale up the paramteric coordinates to match this image's pixel coordinates
  // but keep it floating point
  float scaledX = img.width * x;
  float scaledY = img.height * y;
  
  // regarding the 4 pixels we are concerned with
  // A B
  // C D
  // (0,0) is the coordinate at the top left of A
  // B,C and D are ventured into as X and Y move between 0...1
  // This algorithm works out the average colour of them based on the degree of overlap of each pixel
  
 
  // get the four pixels
  int pA = img.get((int)scaledX,(int)scaledY);
  int pB = img.get((int)scaledX + 1, (int)scaledY);
  int pC = img.get((int)scaledX,(int)scaledY + 1);
  int pD = img.get((int)scaledX + 1,(int)scaledY + 1);
  
  // work out the foating point bit of the pixel location
  
  float mx = getMantisa(scaledX);
  
  float my = getMantisa(scaledY);

  
  // use this work out the overlap for each pixel
  float areaA = ((1.0f - mx) * (1.0f-my));
  
  float areaB = (mx * (1.0f-my));
  
  float areaC = ((1.0f - mx) * my);
  
  float areaD = (mx*my);
  
  // sanity chack that all the areas add up to 1
  
  
  //if ((areaA + areaB + areaC + areaD) != 1.0)
  //{
    //System.out.println((areaA + areaB + areaC + areaD));
    //System.out.println("Not 1!");
  //}
  
  // now average all the red colours based on their relative amounts in A,B,C & D
  int aRed = PApplet.parseInt(areaA * red(pA) + areaB * red(pB) + areaC * red(pC) + areaD * red(pD) );
  int aGreen = PApplet.parseInt(areaA * green(pA) + areaB * green(pB) + areaC * green(pC) + areaD * green(pD) );
  int aBlue = PApplet.parseInt(areaA * blue(pA) + areaB * blue(pB) + areaC * blue(pC) + areaD * blue(pD) );

  
  return color(aRed, aGreen,aBlue);
}

//End of functions
 
}
//End of class
class LayerButton extends Button
{
  PImage layerIMG;
  
  LayerButton(String s, int x, int y, int w, int h)
  {
    text = s;
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
  }
}
class LayerButtons extends RadioButtons
{
  public void add (Button btn)
  {
    super.add(btn);
    allignX = 120;
    btn.allignX = 120;
    h += btn.h;
    //println(h);
    btn.aligned = ALLIGNMENT.right;
  }
}
class LayerResizeSelector extends FloatingWindow
{
	LayerResizeSelector()
	{
		closeButton = new CloseButton(x+w - 20, y+h - 20, 20, 20);
		
		
	}
}
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
  
  public void mouseReleased()
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
      canvas.setLayerIndex((numberOfLayers-1) - (layerButtons.activeButton));
    }
    
    
  }
  
  public void add (Widget widget)
  {
    super.add(widget);
    
    widget.aligned = ALLIGNMENT.right;
  }
  
  public void addLayer()
  {
    layerButtons.add(new LayerButton("layer1", width - 120, y + 25 + layerButtons.h, 120, 40));
    numberOfLayers++;
  }
}
class Menu extends UIManager
{
  
  Menu()
  {
    
  }
  
  Menu(int x, int y)
  {
    this.x=x;
    this.y=y;
  }
  
  public void mouseReleased()
  {
    super.mouseReleased();
    setActive(mouseIsIn && active);
  }
  
  public void add(Widget widget)
  {
    //If the current widgets width is greater than the current width of the menu 
    if (widget.w > w)
    {
      //Increase the width of the menu 
      w = widget.w;
      
      //Increase the width of the menu items
      for (int i = 0; i < widgetList.size(); i++)
      {
        widgetList.get(i).w = w;
      }
    }
   
    //Increases the height of the menu
    h += widget.h;
    
    //Sets the position of the widget to be inline with the rest of the menu
    widget.x = x;
    widget.y = (y + h) - widget.h;
    
    //Adds widget to the widget list.
    widgetList.add(widget);
  }
  
  
  public void setActive(boolean act)
  {
    //Sets the menu visibilty 
    active = act;
    for (Widget widget: widgetList)
    {
      widget.active = act;
    }
  }
  
  public void setPosition(int x, int y)
  {
    //Moves the menu and its widgets to the new x and y position 
    int tempY = y;
    
    for (Widget widget: widgetList)
    {
      widget.x = x;
      
      widget.y = tempY;
      
      tempY += widget.h;
    }
  }
}
class MenuBar extends UIManager
{
  //List of buttons and the menus associated with those buttons
  ArrayList<Button> buttonList = new ArrayList<Button>();
  ArrayList<Menu> menuList = new ArrayList<Menu>();
  MenuBar()
  {
    FileMenu fileMenu = new FileMenu();
    
    fileMenu.add(new Button("New", "mnbtnNew"));
    fileMenu.add(new Button("Open", "mnbtnOpen"));
    fileMenu.add(new Button("Load Project", "mnbtnLoad"));
    fileMenu.add(new Button("Save", "nmbtnSave"));
    fileMenu.add(new Button("Export", "mnbtnExport"));
    fileMenu.setActive(false);
    
    Menu editMenu = new Menu();
    editMenu.add(new Button("Undo"));
    Button redo = new Button("Redo");
    redo.clickable = false;
    editMenu.add(redo);
    editMenu.add(new Button("Cut"));
    editMenu.add(new Button("Copy"));
    editMenu.add(new Button("Paste"));
    editMenu.setActive(false);
    
    addButton("File");
    addMenu(fileMenu);
    addButton("Edit");
    addMenu(editMenu);
    
    
    widgetList.addAll(buttonList);
    widgetList.addAll(menuList);
  }
  
  public void mouseReleased()
  {
    super.mouseReleased();
    
    //Loops through each button on the menu bar
    //If a button is toggled then that buttons menu is displayed
    for(int i = 0; i < buttonList.size(); i++)
    {
        menuList.get(i).setActive(buttonList.get(i).toggled);
    }
    
    
  }
  
  //Adds a button to the menu bar
  public void addButton(String s)
  {
    //Calculates width of the button based on the lenth of its lable
    textSize(11);
    int mX = (int)textWidth(s)+7;
    
    //Adds button to the end of the menu bar
    if (buttonList.size() != 0)
    {
      Button btnLast = buttonList.get(buttonList.size() - 1);
      
      buttonList.add(new Button(s, btnLast.x + btnLast.w, btnLast.y, mX, 17));
    }
    else 
    {
      buttonList.add(new Button(s, x, y, mX,17));
    }
  }
  
  //Menus must be added imidiatly after the corisponding menu button was added
  public void addMenu(Menu m)
  {
    //Sets the menus position to be under the button at the end of the menu bar
    
    Button btn = buttonList.get(buttonList.size()-1);
    m.setPosition(m.x=btn.x, m.y=btn.y+btn.h);
    
    menuList.add(m);
  }
  
}

class FileMenu extends Menu
{
  public void mouseReleased()
  {
    super.mouseReleased();
    
    for (String s: clickedList)
    {
      if(s == "mnbtnNew")
      {
        openCanvasConfigWindow();
      }
      //If the open menu button is pressed
      if (s == "mnbtnOpen")
      {
        //Opens a file dialoge and allows the user to select an image
        //The file directory will be passed to the addLayer function which can be found in the "GraphicApp" tab
        //The image selected is the added to the canvas
        selectInput("Select an Image: ", "addLayer");
      }
      //If the export menu button is pressed
      if (s == "mnbtnExport")
      {
        //The project is exported to an image file
        //canvas.export();
        
        selectOutput("Select save path for image", "export");
      }
      if (s == "nmbtnSave")
      {
        selectOutput("Select save path for image", "saveCanvas");
        
      }
      if (s == "mnbtnLoad")
      {
        selectInput("Select a project: ", "loadProject");
      }
    }
  }
}
class NewCanvasUIManager extends FloatingWindow
{
  TextInput txtWidth;
  TextInput txtHeight;
  Button confirmButton;
  Label lblWidth;
  Label lblHeight;

  NewCanvasUIManager()
  {
    x = 150;
    y = 150;
    w=300;
    h=200;
    
    lblWidth = new Label(25, 20, "Width");
    lblHeight = new Label(25, 60, "Height");

    txtWidth = new TextInput(70, 20, "500", 12);
    txtHeight = new TextInput(70, 60, "500", 12);
    confirmButton = new Button("Confirm", 200, 140, 60, 25);
    confirmButton.name = "confirmButton";
    
    //closeButton = new CloseButton(x+w - 20, y+h - 20, 20, 20);
    closeButton.x = x+w - 20;
    closeButton.y =  y;
    
    aligned = ALLIGNMENT.center;
    
    //txtWidth.aligned = ALLIGNMENT.center_top;
    //txtHeight.aligned = ALLIGNMENT.center_top;
    
    add(txtWidth);
    add(txtHeight);
    add(confirmButton);
    add(lblWidth);
    add(lblHeight);

    //resize(0,0);
  }
  
  
  public void mouseReleased()
  {
    super.mouseReleased();
    
    for (String s: clickedList)
    {
      if (s == confirmButton.name)
      {
        int canWidth, canHeight;
        
        if (txtWidth.s.matches("-?[0-9]+"))
        {
          canWidth = Integer.parseInt(txtWidth.s); 
        }
        else 
        {
          print("You did not enter an integer in canvas width");
          continue;
        }
        
        if (txtHeight.s.matches("-?[0-9]+"))
        {
          canHeight = Integer.parseInt(txtHeight.s); 
        }
        else 
        {
          print("You did not enter an integer in canvas height");
          continue;
        }
        
        
        
        setupNewCanvas(canWidth,canHeight);
        closed = true;
      }
    }
  }
}
class RadioButtons extends UIManager
{
  //ArrayList<Button> buttonList = new ArrayList<Button>();
  
  int activeButton = -1;
  
  
  RadioButtons()
  {
    untoggleAfterClick = false;
    
  }
  
  public void mouseReleased()
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseReleased();
      
      //If the current button is toggled and the current button is not the currently selected button
      if (i != activeButton && widgetList.get(i).toggled)
      {
        //Checks that a button was previously selected
        if (activeButton != -1)
        //deselects the currently active button
        widgetList.get(activeButton).toggled = false;
        //Sets the current button as the active button
        activeButton = i;
      }
    }
  }
  
  public void add(Button btn)
  {
    btn.toggleable = true; 
    btn.untoggleAfterClick = untoggleAfterClick;
    widgetList.add(btn);
  }
 
}
public enum Orientation
{
  vertical, horrizontal
}
class ScrollBar extends Widget
{
  
  int l;
  Orientation o;
  int max;
  int barSize;
  
  float value, rectX, rectY;
  
 
  
  
  ScrollBar(int x, int y, int l, Orientation orientation, int max)
  {
    this.x=x;
    this.y=y;
    this.l = l;
    o = orientation;
    
    this.max = max;
    
    rectX = x;
    rectY = y;
    
    if (o == Orientation.vertical)
    {
       h = l;
       w = 10;
    }
    else 
    {
      w = l;
      h = 10;
    }
    
    setMax(max);
  }
  
   
  public void setMax (int newMax)
  {
    max = newMax;
    
    barSize = l - (int)(((float)max / (float)l) * l);
  }
  
  public void mouseDragged()
  {
    //Keeps the bar within bounds of the scroll bar
    if (clicked)
    {      
      if (o == Orientation.vertical)
      {
         rectY = clamp(mouseY - (barSize/2), y, (y+h)- barSize);      
      }
      else
      {
        rectX = clamp(mouseX - (barSize/2), x, (x+ w) - barSize);
      }
      //Calculates the current selected value
      getValue();
    }
  }
  
  public void mouseReleased()
  {
    //Keeps the bar within bounds of the scroll bar
    if (clicked)
    {
      if (o == Orientation.vertical)
      {
         rectY = clamp(mouseY - (barSize/2), y, (y+h) - barSize);      
      }
      else
      {
        rectX = clamp(mouseX - (barSize/2), x, (x+ w) - barSize);
      }
     //Calculates the current selected value
     getValue();
    }
  }
  
  public float getValue()
  {
    int min = 0;
    float pos;
    int begin, end;
    
    //Calculates the position of the bar, the begining of the scrollbar and the end of the scroll bar depending on the orientation of the scroll bar
    if (Orientation.vertical == o)
    {
      pos = rectY;
      begin = y;
      end = h;
    }
    else
    {
      pos =  rectX;
      begin = x;
      end = w;
    }
    
    //Calcuates the value of the scroll bar
    value = ((float)pos - (float)begin) / (((float)end - (float)barSize));
    value = ((float)(max - min) * value) + min;
    
    return value;
  }
  
  
  public void draw()
  {
    fill(255,255,255);
    rect(x, y, w, h);
      fill(0,0,0);
      if (o == Orientation.vertical)
      {
        rect(rectX,rectY,10, barSize);
      }
      else
      {
        rect(rectX,rectY,barSize,10);
      }
  }
  
}
class Slider extends Widget
{
  int rectX;
  int min, max;
  float value;
  
  TextInput textInput;
  
  Slider(int x, int y, int w, int min, int max)
  {
    this.x = x;
    this.y = y - 5;
    this.w=w;
    this.min = min;
    this.max=max;
    h = 10;
    
    rectX = x + (w/2);
    
    textInput = new TextInput(x+w+10, y, Float.toString(value), 12);
    
  }
  
  
  public void mouseDragged()
  {
    //Keeps the bar within bounds of the slider
    if (clicked)
    {
      rectX = clamp(mouseX, x, x+ w);
      
      //Gets current value of the slider
      getValue();
      
      //Displays current value of the slider
      textInput.setString(Float.toString(value));
    }
  }
  
  public void mouseReleased()
  {
    //Keeps the bar within bounds of the slider
    if (clicked)
    {
      rectX = clamp(mouseX, x, x+ w);
      //Gets current value of the slider
      getValue();
      //Displays current value of the slider
      textInput.setString(Float.toString(value));
    }
  }
  
  public float getValue()
  {
    //Calculates the current value of the slider
    value = ((float)rectX - (float)x) / ((float)w);
    value = ((float)(max - min) * value) + min;
    return value;
  }
  
  public void draw()
  {
    fill(0,0,0);
    rect(x,y + 5,w,0);
    
    rect(rectX, y, 7, 10);
    
    textInput.draw();
  }
}
class TextInput extends Label
{
  
  int toggledColor = color(0,0,255);
  
  TextInput (int x, int y, String s, int size)
  {
    super(x,y,s,size);
    border = true;
  }
  
  public void keyPressed()
  {
    //If the user has clicked on the text input to type in it
    if (toggled)
    {
    char k = key;
    if (k == CODED)
    {
     
    }
    else 
    {
      //If the current keystroke is backspace or delete
      if (k == BACKSPACE || k == DELETE)
      {
        //Remove the character at the end of the string list
        if (s.length() > 0)
        {
          setString(s.substring(0, s.length() - 1));
        }
      }
      //If user pressed enter
      else if (k == ENTER)
      {
        //Deselects the text input
        toggled = false;
      }
      else
      {
        //Adds character to text
        setString(s + k);
      }
    }
    }
  }
  
  public void draw()
  {
    if (toggled)
    {
      
    }
    super.draw();
  }
}
class UIManager extends Widget
{
  ArrayList<Widget> widgetList = new ArrayList<Widget>();
  
  ArrayList<String> clickedList = new ArrayList<String>();
  
  MenuBar menuBar;

  int CurrnetID = 0;
  
  UIManager()
  {}
  
  UIManager(MenuBar m)
  {
    setMenuBar(m);
  }
  
  public void add(Widget widget)
  {  
    widget.id = CurrnetID++;

    widgetList.add(widget);
  }
  
  public void setMenuBar(MenuBar m)
  {
    menuBar = m;
  }
  
  public void draw()
  {
    super.draw();
    
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).draw();
    }
    
    if (menuBar != null)
    menuBar.draw();
  }
  
  public void mousePressed() {
    super.mousePressed();
    if (menuBar != null)
    menuBar.mousePressed();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mousePressed();
    }
  }
  
  public void mouseClicked ()
  {
    if (menuBar != null)
    menuBar.mouseClicked();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseClicked();
    }
    
    super.mouseClicked();
  }
  
  public void mouseMoved()
  {
    super.mouseMoved();
    if (menuBar != null)
    if (menuBar != null)
    menuBar.mouseMoved();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseMoved();
    }
  }
  
  public void mouseReleased()
  {
    if (menuBar != null)
    menuBar.mouseReleased();
    
    //Updates the array of widgets that were clicked
    clickedList = new ArrayList<String>();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseReleased();
      if (widgetList.get(i).wasClicked)
      {
        clickedList.add(widgetList.get(i).name);
        widgetList.get(i).wasClicked = false;
      }
      
      if (widgetList.get(i).closed)
      {
        widgetList.remove(i);
        i--;
      }
    }
    
    super.mouseReleased();
  }
  
  public void mouseDragged()
  {  
    if (menuBar != null)
    menuBar.mouseDragged();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseDragged();
    }
    
    super.mouseDragged();
  }
  
  public void resize(int dtW, int dtH)
  {
    if (menuBar != null)
    menuBar.resize(dtW, dtH);
    
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).resize(dtW, dtH);
    }
    
    super.resize(dtW, dtH);
  }
  
  public void keyPressed()
  {
    if (menuBar != null)
    menuBar.keyPressed();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).keyPressed();
    }
    super.keyPressed();
  }
  
  
  //Removes all widgets that have been marked as closed
  public void clean()
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      if (widgetList.get(i).closed)
      {
        widgetList.remove(i);
        i--;
      }
    }
  }

  public void remove(int i)
  {
    if (i < (widgetList.size() - 1) && i >= 0)
    widgetList.remove(i);
  }

  public int getIndexFromID(int WidgetID)
  {
    for (int i = 0; i < widgetList.size(); i++)
    {
      println("Point a");
      if (widgetList.get(i).id == WidgetID)
      {
        return i;
      }
    }
    return -1;

  }

  public void remove(Widget widget)
  {
    int i = -1;
    if (widget != null)
    {
      i = getIndexFromID(widget.id);

      println("Widet id: " + widget.id);
      println("Widget index: " + i);
    }
    

    if (i > -1)
    {
      remove(i);
    } 
  }
}
//Enums used to define a widgets behavior when the window is resized
public enum ALLIGNMENT
  {
    non, center, left, right, top, bottom, top_left, top_right, bottom_left, bottom_right, center_top, center_bottom, center_left, center_right
  }

//Ensures that a value is within givin minimum and maximum values
public float clamp(float val, float min, float max)
{
  if (val < min)
    return min;
  if (val > max)
    return max;
  return val;
}
//Ensures that a value is within givin minimum and maximum values
public int clamp(int val, int min, int max)
{
  if (val < min)
    return min;
  if (val > max)
    return max;
  return val;
}

class Widget implements Serializable
{ 
  //defines a widgets behavior when the window is resized
  ALLIGNMENT aligned = ALLIGNMENT.non;
  
  //Identifier used to address widgets when retrieved from a list
  String name;
  
  //Assigned by a UI manager when add function is used
  int id = -1;

  //When true the widget should be removed from the UI manager
  boolean closed = false;
  
  public void draw()
  {
    
  }

  //Checks if the mouse is within the clickable object
  public boolean checkMouseIsIn()
  {
    if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) 
    {
      return true;  
    } 
    else 
    {
      return false;
    }
  }
  
  //True if the user is able to see and interact with the widget
  boolean active = true;
  
  //True if the user is able to toggle to control with a mouse click
  boolean toggleable = false;
  //True if the widget is currently toggled on
  boolean toggled = false;
  boolean untoggleAfterClick = true;
  
  //True if the user is able to click on the widget
  boolean clickable = true;
  //True if the mouse is currently hovering the widget
  boolean mouseIsIn = false;
  //True if the user is currently clicking on the widget
  boolean clicked = false;
  //True if the user clicked on the widget
  boolean wasClicked = false;
  public void mousePressed() 
  {
    
    if (clickable)
    clicked = mouseIsIn;
    
    if (clicked)
    {
      mouseOffsetX = mouseX - x;
      mouseOffsetY = mouseY - y;
    }
    else
    {
      mouseOffsetX = 0;
      mouseOffsetY = 0;
    }
  }
  
  public void mouseReleased()
  {
    clicked = false;
    mouseIsIn=checkMouseIsIn();
    if (mouseIsIn)
    {
      //Click Event
      toggled = !toggled;
      if (active && clickable)
      WidgetClickEvent();
    }
    else if (untoggleAfterClick)
    {
      toggled = false;
    }
    
    
  }
  
  public void mouseMoved()
  {
    if (clickable)
    mouseIsIn = checkMouseIsIn();
  }
  
  boolean draggable = false;
  int mouseOffsetX = 0;
  int mouseOffsetY = 0;
  
  public void mouseDragged()
  {
     
    if (!clicked)
    {
      mouseIsIn = checkMouseIsIn();
    }
    else
    {
      if (draggable)
      {
        x = mouseX - mouseOffsetX;
        y = mouseY - mouseOffsetY;
      }
    }
    
  }
  
  //Called after a widget has been clicked 
  public void WidgetClickEvent()
  {
    wasClicked = true;
  }
  
  public void mouseClicked()
  {
  
  }
  
  public void keyPressed()
  {
    
  }
  
  int allignX;
  int allignY;
  
  public void resize(int dtW, int dtH)
  {
    //Moves widget when the window is resized depending on how they are aligned
    
    if (aligned == ALLIGNMENT.right || aligned == ALLIGNMENT.top_right)
    {
      x = width - allignX;
    }
    else if (aligned == ALLIGNMENT.center)
    {
      x = (width / 2) - (w / 2);
      y = (height / 2) - (h / 2);
    }
    else if (aligned == ALLIGNMENT.bottom || aligned == ALLIGNMENT.bottom_left)
    {
      y = height - allignY;
    }
    else if (aligned == ALLIGNMENT.bottom_right)
    {
      x = width - allignX;
      y = height - allignY;
    }
    else if (aligned == ALLIGNMENT.center_bottom)
    {
      x = (width / 2) - (w / 2);
      y = height - allignY;
    }
    else if (aligned == ALLIGNMENT.center_left)
    {
      y = (height / 2) - (h / 2);
    }
    else if (aligned == ALLIGNMENT.center_right)
    {
      x = width - allignX;
      y = (height / 2) - (h / 2);
    }
    else if (aligned == ALLIGNMENT.center_top)
    {
      x = (width / 2) - (w / 2);
    }
    
  }
  
  int x;
  int y;
  int w;
  int h;
}
  public void settings() {  size(900, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "GraphicsApp" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
