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
public ColorSelector lineColorSelector = new ColorSelector(35, 100);
public ColorSelector fillColorSelector = new ColorSelector(35, 130);
public FilledButton filledButton = new FilledButton("Filled " , 10, 155, 70, 35);



public void setup()
{
  
  
  oldWidth = width;
  oldHeight = height;
  
  surface.setResizable(true);
  ui = new UIManager(new MenuBar());
  ui.add(lineColorSelector);
  ui.add(fillColorSelector);
  ui.add(new Label(10, 100, "Line"));
  ui.add(new Label(10, 130, "Fill"));
  filledButton.toggleable = true;
  filledButton.untoggleAfterClick = false;
  ui.add(filledButton);
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

  if (canvas != null)
  {
    if (canvas.layerIndex > -1)
    {
      Layer l = canvas.layers.get(canvas.layerIndex);

      if (l.selectedShape != null)
      {
        l.selectedShape.lineColor = lineColorSelector.selectedColor;
        l.selectedShape.fillColor = fillColorSelector.selectedColor;
        l.selectedShape.scaleAfterReize(l.scalar);
      }
    }
  }
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
  canvas.saveCanvas(outputDir);
}

public void loadProject(File inputDir)
{
  String[] lines = loadStrings(inputDir.getAbsolutePath());
      
  setupNewCanvas(Integer.parseInt(lines[0]), Integer.parseInt(lines[1]));
  
  canvas.loadProject(lines);
}

public void PickColor(ColorSelector sel, int r, int g, int b)
{
  ui.add(new ColorPickerWindow(sel,r,g,b));
}

public void ResizeLayer(Layer l, Shape s)
{
  ui.add(new LayerResizeWindow(l,s));
}

public void RotateLayer(Layer l, Shape s)
{
  ui.add(new RotateWindow(l, s));
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


int selectedColor = color(0,0,0);

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
  public ArrayList<Layer> layers = new ArrayList<Layer>();

  undoListNode undoList = new undoListNode();
  undoListNode head = undoList;
  
  float scalar;

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
  
  public void addPolygon(boolean filled, boolean closedShape, int lineColor, int fillColor)
  {
    if (layerIndex > -1)
    {
      saveLayersToUndo(true);
      layers.get(layerIndex).addPolygon(filled,closedShape,lineColor,fillColor);
    }
    
  }

  public void addRectangle(boolean filled, int lineColor, int fillColor)
  {
    if (layerIndex > -1)
    {
      saveLayersToUndo(true);
      layers.get(layerIndex).addRectangle(filled,lineColor,fillColor);
    }
    
  }

  public void addCircle(boolean filled, int lineColor, int fillColor)
  {
    if (layerIndex > -1)
    {
      saveLayersToUndo(true);
      layers.get(layerIndex).addCircle(filled,lineColor,fillColor);
    }
    
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

      this.scalar = scalar; 
      
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

      this.scalar = scalar;
      
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
  public void setLayerIndex(int index)
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
  public int getLayerIndex()
  { 
    return layerIndex;
  }
  
  
  public void mouseDragged()
  {
    super.mouseDragged();
      if (layerIndex != -1)
      {
        layers.get(layerIndex).mouseDragged();
      }
  }

  public void saveLayersToUndo(boolean cloneCurrentLayer)
  {
          undoList.layers = new ArrayList<Layer>();
          for (int i = 0; i < layers.size(); i++)
          {
            if (i == layerIndex && cloneCurrentLayer)
            {
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
  
  public void mousePressed()
  {
    super.mousePressed();
      if (layerIndex != -1)
      {
        
        layers.get(layerIndex).mousePressed();
        saveLayersToUndo(layers.get(layerIndex).clicked);
      }
  }
  
  public void mouseMoved()
  {
    super.mouseMoved();
      if (layerIndex != -1)
      {
        layers.get(layerIndex).mouseMoved();
      }
  }

  public void mouseReleased()
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
     img =  scaleUp_bilinear(l.newWidth,l.newHeight, img);
      l.actImage.loadPixels();
     // println("Point c");scaleUp

      data += img.width;
      data += ".";
      data += img.height;
      data += ".";
      data += l.offsetX;
      data += ".";
      data += l.offsetY;
      //data += ".";
      output.println(data);
      //data += l.rotation;
      output.println((int)l.getRotation());
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


      for (Shape s: l.shapeList)
      {
        output.println(s.type);

        if (s.type == "Polygon")
        {
          Polygon poly = (Polygon) s;

          output.println(poly.scalar);
          output.println(poly.filled);
          output.println(poly.closedShape);
          output.println(poly.lineColor);
          output.println(poly.fillColor);
          output.println(poly.rotation);

          for (Point p: poly.actPoints)
          {
            output.println(p.x);
            output.println(p.y);
          }
        }

        else if (s.type == "Rectangle")
        {
          Rectangle rectangle = (Rectangle) s;

          s.scaleAfterReize(1);

          output.println(rectangle.scalar);
          output.println(rectangle.filled);
          output.println(rectangle.lineColor);
          output.println(rectangle.fillColor);
          output.println(rectangle.rotation);

          output.println(rectangle.x);
          output.println(rectangle.y);
          output.println(rectangle.w);
          output.println(rectangle.h);

          s.scaleAfterReize(scalar);
        }
        
        else if (s.type == "Circle")
        {
          Circle circle = (Circle) s;

          s.scaleAfterReize(1);

          output.println(circle.scalar);
          output.println(circle.filled);
          output.println(circle.lineColor);
          output.println(circle.fillColor);
          output.println(circle.rotation);

          output.println(circle.x);
          output.println(circle.y);
          output.println(circle.w);
          output.println(circle.h);

          s.scaleAfterReize(scalar);
        }

        //Marks the end of a layers shape data
        output.println("*");

      }
      //marks the end of a layers data
      output.println("**");
    }

    output.println("/");
    output.flush();
    output.close();
    
    print("Time:" + (millis() - time));
  }
  
  public void loadProject(String [] Pixels)
  {
    String line;
    int i = 2;
    noLoop();
    while (true)
    {
      line = Pixels[i++];
      if (line.contains("/"))
      {
        break;
      }

      if (line.contentEquals("**"))
      {
        continue;
      }
      if (line.contentEquals("Polygon"))
      {
        Polygon poly = new Polygon(Float.parseFloat(Pixels[i++])
          , Boolean.parseBoolean(Pixels[i++]), Boolean.parseBoolean(Pixels[i++])
          , Integer.parseInt(Pixels[i++]), Integer.parseInt(Pixels[i++]));

        poly.rotation = round(Float.parseFloat(Pixels[i++]));

        while (!Pixels[i].contentEquals("*"))
        {

          int pointX = Integer.parseInt(Pixels[i++]);
          int pointY = Integer.parseInt(Pixels[i++]);

          poly.actPoints.add(new Point(pointX, pointY));
        }

        poly.placed = true;
        layers.get(layers.size()-1).addShape(poly);
        //The current line was read by the while loop but the line index was not incremented
        //So the line index must be incremented now for the next itteration of the loop
        i++;
        continue;
      }

      if (line.contentEquals("Rectangle"))
      {
        Rectangle rectangle = new Rectangle(Float.parseFloat(Pixels[i++])
          , Boolean.parseBoolean(Pixels[i++])
          , Integer.parseInt(Pixels[i++]), Integer.parseInt(Pixels[i++]));
        rectangle.rotation = Integer.parseInt(Pixels[i++]);
          
        rectangle.x = Integer.parseInt(Pixels[i++]);
        rectangle.y = Integer.parseInt(Pixels[i++]);
        rectangle.w = Integer.parseInt(Pixels[i++]);
        rectangle.h = Integer.parseInt(Pixels[i++]);

        rectangle.placed = true;
        layers.get(layers.size()-1).addShape(rectangle);
        //The current line was read by the while loop but the line index was not incremented
        //So the line index must be incremented now for the next itteration of the loop
        i++;
        continue;
      }
      
      if (line.contentEquals("Circle"))
      {
        Circle circle = new Circle(Float.parseFloat(Pixels[i++])
          , Boolean.parseBoolean(Pixels[i++])
          , Integer.parseInt(Pixels[i++]), Integer.parseInt(Pixels[i++]));

          circle.rotation = Integer.parseInt(Pixels[i++]);
        circle.x = Integer.parseInt(Pixels[i++]);
        circle.y = Integer.parseInt(Pixels[i++]);
        circle.w = Integer.parseInt(Pixels[i++]);
        circle.h = Integer.parseInt(Pixels[i++]);

        circle.placed = true;
        layers.get(layers.size()-1).addShape(circle);
        //The current line was read by the while loop but the line index was not incremented
        //So the line index must be incremented now for the next itteration of the loop
        i++;
        continue;
      }
      
      int tempW = Integer.parseInt(split(line, ".")[0]);
      int tempH = Integer.parseInt(split(line, ".")[1]);
      int tempX = Integer.parseInt(split(line, ".")[2]);
      int tempY = Integer.parseInt(split(line, ".")[3]);
      
      PImage outputImage = new PImage(tempW, tempH);
      int rotation = Integer.parseInt(Pixels[i++]);
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
         
         int currentPixel = color(r,g,b,a);
         
         outputImage.set(x,y,currentPixel);
         
        } 
     
       }
     addLayer(outputImage, tempX, tempY);
     layers.get(layers.size() - 1).setRotation(rotation);
    }
    
   autoSetSize();
   loop();
  }

  public void undo()
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

  public void redo()
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

  public void blackAndWhite()
  {
    if (layerIndex != -1)
      {
        layers.get(layerIndex).blackAndWhite();
      }
  }

  public void greyscale()
  {
      if (layerIndex != -1)
      {
        layers.get(layerIndex).greyscale();
      }
  }

  public void convolute(float [][] matrix)
  {
    if (layerIndex != -1)
      {
        layers.get(layerIndex).convolute(matrix);
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
class ColorPickerWindow extends FloatingWindow
{
	private PImage colorChart;
	private Slider rSlider;
	private Slider gSlider;
	private Slider bSlider;
	private int chartSize = 255;
	private Button confirmButton = null;

	ColorSelector selector = null;
	ColorPickerWindow(ColorSelector sel, int r, int g, int b)
	{
		x = 50;
		y = 50;
		w = 400;
		h = 400;

		rSlider = new Slider(10, 290, 255, 0, 255);
		gSlider = new Slider(10, 320, 255, 0, 255);
		bSlider = new Slider(10, 350, 255, 0, 255);

		rSlider.setValue(r);
		gSlider.setValue(g);
		bSlider.setValue(b);

		add(rSlider);
		add(gSlider);
		add(bSlider);

		closeButton.x = x+w - 20;
    	closeButton.y =  y;
    	colorChart = new PImage(chartSize, chartSize);
    	setCharColor();

    	selector = sel;

    	confirmButton = new Button("Confirm", 320, 300, 50, 25);

    	add(confirmButton);

	}

	private void setCharColor()
	{
		for (int x = 0; x < chartSize; x ++)
    	{
    		for (int y = 0; y < chartSize; y++)
    		{
    			colorChart.set(x, y, color(rSlider.getValue() ,gSlider.getValue() ,bSlider.getValue()));
    		}
    	}
	}

	public void mouseDragged()
	{
		super.mouseDragged();
		setCharColor();
	}

	public void mousePressed()
	{
		super.mousePressed();
		setCharColor();
	}

	public void mouseReleased()
	{
		super.mouseReleased();

		if (confirmButton.wasClicked)
		{
			closed=true;

			if(selector != null)
			{
				selector.selectedColor = color(rSlider.getValue() ,gSlider.getValue() ,bSlider.getValue());

				

				
			}
			
		}
	}

	public void draw()
	{
		super.draw();



		image(colorChart, x + 10, y + 30);
	}
}
class ColorSelector extends Widget
{

	int selectedColor = color(255,2,2);
	ColorSelector(int x, int y)
	{
		w = 20;
		h = 20;
		this.x=x;
		this.y=y;
	}

	public void draw()
	{
		stroke(selectedColor);
		fill(selectedColor);
		rect(x,y,w,h);
		stroke(0);
	}

	public void mouseReleased()
	{
		super.mouseReleased();
		if (wasClicked)
		{
			PickColor(this, (int)red(selectedColor), (int)green(selectedColor), (int)blue(selectedColor));
		}

	}

}
class FilledButton extends Button
{
	FilledButton(String s, int x, int y, int w, int h)
  	{
    	text = s;
    
	    this.x = x;
	    this.y = y;
	    this.w = w;
	    this.h = h;
    
  	}


	public void WidgetClickEvent()
	{
		if (canvas != null)
		{
			if (canvas.layerIndex > -1)
			{
				Layer l = canvas.layers.get(canvas.layerIndex);

				if (l.selectedShape != null)
				{
					l.selectedShape.setFilled(toggled);
				}
			}
		}
	}
}
public PImage BlackAndWhite(PImage img)
{
	PImage res = new PImage(img.width, img.height);
	for (int x = 0; x < img.width; x++)
	{
		for (int y = 0; y < img.height; y++)
		{
			int c = img.get(x,y);
			int val = (int)(red(c) + green(c) + blue(c));

			if (val > 384)
			{
				res.set(x,y,color(255,255,255));
			}
			else 
			{
				res.set(x,y,color(0,0,0));
			}
		}
	}
	return res;
}

public PImage Greyscale(PImage img)
{
	PImage res = new PImage(img.width, img.height);
	for (int x = 0; x < img.width; x++)
	{
		for (int y = 0; y < img.height; y++)
		{
			int c = img.get(x,y);
			int val = (int)(red(c) + green(c) + blue(c));

			res.set(x,y, color(round(val/3)));
		}
	}
	return res;
}

float[][] edge_matrix = { { 0,  -2,  0 },
                          { -2,  8, -2 },
                          { 0,  -2,  0 } }; 
                     
float[][] blur_matrix = {  {0.1f,  0.1f,  0.1f },
                           {0.1f,  0.1f,  0.1f },
                           {0.1f,  0.1f,  0.1f } };                      

float[][] sharpen_matrix = {  { 0, -1, 0 },
                              {-1, 5, -1 },
                              { 0, -1, 0 } }; 

public int convolution(int x, int y, float[][] matrix, int matrixsize, PImage img)
{
  float rtotal = 0.0f;
  float gtotal = 0.0f;
  float btotal = 0.0f;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc,0,img.pixels.length-1);
      // Calculate the convolution
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}

public PImage Convolute(PImage inputImage, float[][] matrix)
{
	PImage outputImage = createImage(inputImage.width, inputImage.height, RGB);

	int matrixSize = 3;
  	for(int y = 0; y < inputImage.height; y++){
    	for(int x = 0; x < inputImage.width; x++){
    
    	int c = convolution(x, y, matrix, matrixSize, inputImage);
    
    	outputImage.set(x,y,c);
    
    }
  }

  return outputImage;
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
      w.setPosition(w.x + dx, w.y + dy);
    }
  }
  
  public void add(Widget w)
  {
    w.setPosition(w.x + x, w.y + y + titleBarSize);
    
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
class Layer extends UIManager
{
  //Image that is actually used to write to file
  PImage actImage;
  //Image that is diplayed to the screen
  PImage disImage;
  
  //Stores the position of the actual image for exporting the image
  //The widget x and y are used for the display image
  int offsetX = 100;
  int offsetY = 100;

  //Width and height of the actual image after resizing
  //Used to keep origonal image quality after resizing
  int newWidth;
  int newHeight;
  
  //Set to true if a change needs to be added to the undo list
  boolean changed = false;
  
  float scalar;

  //Indicates whether or not the layer is selected
  private boolean selected = false;
  
  private int rotation = 0; 

  Shape selectedShape = null;

  ArrayList<Shape> shapeList = new ArrayList<Shape>();
  
  Layer(File sourceImage)
  {
    //Loads the image that the layer is made of into memory
    actImage = loadImage(sourceImage.getAbsolutePath());
    
    disImage = actImage;
    
    name = "layer";
    
    draggable = true;

    newWidth = actImage.width;
    newHeight = actImage.height;
  }
  
  Layer(PImage p, int ox, int oy)
  {
    actImage = p;
    
    name = "layer";
    
    draggable = true;
    
    offsetX = ox;
    offsetY = oy;

    newWidth = actImage.width;
    newHeight = actImage.height;
  }
  
  public Layer clone()
  {
    Layer l = new Layer(actImage, offsetX, offsetY);
    l.changed = changed;

    for (Shape shape: shapeList)
    {
      l.addShape(shape.clone());
    }

    return l;
  }

  public void ResizeLayer(int w, int h)
  {
    newWidth = w;
    newHeight = h;

    scaleAfterReize(scalar);
  }

  public void changeContrast(int offset)
  {
    actImage = ChangeContrast(actImage, offset);
    disImage = ChangeContrast(disImage, offset);
  }
  
  public void changeBrightness(int offset)
  {
    actImage = ChangeBrightness(actImage, offset);
    disImage = ChangeBrightness(disImage, offset);
    
  }

  public void draw()
  {
    pushMatrix();
    Translate();
    rotate(radians(rotation));
    image(disImage, -(disImage.width / 2), -(disImage.height / 2));
    popMatrix();

    if (selected)
    {
      noFill();
      strokeWeight(3);
      rect(x, y, w, h);

      strokeWeight(1);
    }

    for (Shape s: shapeList)
    {
      s.draw();
    }
  }

  public void mouseReleased()
  {

    super.mouseReleased();
    for (Shape s: shapeList)
    {
      if (s.wasClicked)
      {
        if(selectedShape != null)
        {
          selectedShape.selected = false;
        }
        

        wasClicked = true;
        s.wasClicked = false;
        selectedShape = s;
        s.selected = true;
        println(selectedShape.filled);
        filledButton.toggled = selectedShape.filled;
        break;
      }
    }
  }

  //Writes shape data to the final PGraphic 
  public void flatten(PGraphics pg)
  {
    pg.pushMatrix();
    pg.translate(offsetX+(actImage.width / 2), offsetY+(actImage.height / 2));
    pg.rotate(radians(rotation));
    pg.image(actImage, -(actImage.width / 2) , -(actImage.width / 2));
    pg.popMatrix();

    for(Shape s: shapeList)
    {
      s.flatten(pg, offsetX, offsetY);
    }

  }
  
  //Sets whether or not the layer is selected or not
  public void setSelected(boolean flag)
  {
    selected = flag;
  }

  public void setRotation(float r)
  {
    rotation = (int) r;
  }

  public float getRotation()
  {
    return rotation;
  }

  public void scaleAfterReize(float scalar)
  {
    //Scales display image to the size of the canvas 
    disImage = scaleUp_bilinear((int)((float)actImage.width * scalar * ((float)newWidth / (float)actImage.width)),
     (int)((float)actImage.height * scalar * ((float)newHeight / (float)actImage.height)), actImage);

    w = disImage.width;
    h = disImage.height;
    
    x = (int)((float)offsetX * scalar) + canvas.x;
    y = (int)((float)offsetY * scalar) + canvas.y;
    
    this.scalar = scalar;

    for (Shape s: shapeList)
    {
      s.scaleAfterReize(scalar);
    }
  }
  
  public void mouseDragged()
  {
    super.mouseDragged();
    
    offsetX = (int)(((float)x - (float)canvas.x) / scalar);
    offsetY = (int)(((float)y - (float)canvas.y) / scalar);
    
  }

  public void addShape(Shape s)
  {
    add(s);
    shapeList.add(s);
    clicked = true;
  }

  public void addPolygon(boolean filled, boolean closedShape, int lineColor, int fillColor)
  {
    addShape(new Polygon(scalar, filled, closedShape, lineColor, fillColor));
  }

  public void addRectangle(boolean filled, int lineColor, int fillColor)
  {
    addShape(new Rectangle(scalar, filled, lineColor, fillColor));
  }

  public void addCircle(boolean filled, int lineColor, int fillColor)
  {
    addShape(new Circle(scalar, filled, lineColor, fillColor));
  }

   public void Translate()
  {
    //translate(-(x + (w/2)), -(y + (h / 2)));
    //translate(x + (w/2), y + (h / 2));

    //translate(-(w/2), (-h/2));

    //translate(w/2, h/2);
    //translate(-x, -y);
    translate(x + (w/2), y + (h / 2));
  }

  public void FlattenTranslate(PGraphics pg, int oldCanvasX, int oldCanvasY)
  {
    //pg.rect(round((float)(x - oldCanvasX) / this.scalar),round((float)(y - oldCanvasY) / this.scalar)
     // ,round((float)w / this.scalar),round((float)h / this.scalar));

    int tempX = round((float)(x - oldCanvasX) / scalar);
    int tempY = round((float)(y - oldCanvasY) / this.scalar);
    int tempW = round((float)w / this.scalar);
    int tempH = round((float)h / this.scalar);

    pg.translate(tempX + (tempW / 2), tempY + (tempH / 2));
  }
 

 
 


public void blackAndWhite()
{
  actImage = BlackAndWhite(actImage);
  disImage = BlackAndWhite(disImage);
}

public void greyscale()
{
  actImage = Greyscale(actImage);
  disImage = Greyscale(disImage);
}
public void convolute(float [][] matrix)
{
  actImage = Convolute(actImage, matrix);
  disImage = Convolute(disImage, matrix);
}
 
}
//End of layer class

class Point
{
  public int x, y;
  Point(int x,int y)
  {
    this.x=x;
    this.y=y;
  }

  public Point scale(float scalar)
  {
    float tx = x * scalar;
    float ty = y * scalar;

    return new Point(round(tx)+canvas.x,round(ty)+canvas.y);
  }
}

public class Shape extends Widget
{
  boolean filled;
  int fillColor;
  int lineColor;
  float rotation = 0;
  boolean placed = false;
  float scalar;
  String type = "";
  boolean selected = false;

  public void setFilled(boolean f)
  {
    filled = f;
  }



  public void setFilled(boolean f, int c)
  {
    setFilled(f);
    setFillColor(c);
  }

  public void mouseReleased()
  {
    super.mouseReleased();

    if (wasClicked)
    {
      lineColorSelector.selectedColor = lineColor;
      fillColorSelector.selectedColor = fillColor;
    }
  }


  public boolean getFilled()
  {
    return filled;
  }

  public void setFillColor (int c)
  {
    fillColor = c;
  }

  public int getFillColor()
  {
    return fillColor;
  }

  public void setRotation(float r)
  {
    rotation = r;
  }

  public float getRotation()
  {
    return rotation;
  }

  public void scaleAfterReize(float scalar)
  {
    this.scalar = scalar;
  }

  public void flatten(PGraphics pg, int offsetX, int offsetY)
  {

  }

  public void Translate()
  {
    //translate(-(x + (w/2)), -(y + (h / 2)));
    //translate(x + (w/2), y + (h / 2));

    //translate(-(w/2), (-h/2));

    //translate(w/2, h/2);
    //translate(-x, -y);
    translate(x + (w/2), y + (h / 2));
  }

  public void FlattenTranslate(PGraphics pg, int oldCanvasX, int oldCanvasY)
  {
    //pg.rect(round((float)(x - oldCanvasX) / this.scalar),round((float)(y - oldCanvasY) / this.scalar)
     // ,round((float)w / this.scalar),round((float)h / this.scalar));

    int tempX = round((float)(x - oldCanvasX) / scalar);
    int tempY = round((float)(y - oldCanvasY) / this.scalar);
    int tempW = round((float)w / this.scalar);
    int tempH = round((float)h / this.scalar);

    pg.translate(tempX + (tempW / 2), tempY + (tempH / 2));
  }

  public Shape clone()
  {
    Shape temp = new Shape();

    temp.filled = filled;
    temp.fillColor=fillColor;
    temp.lineColor=lineColor;
    temp.rotation = 0;
    temp.placed = false;
    temp.scalar=scalar;

    return temp;
  }

  public void setSize(int w, int h)
  {
    this.w=w;
    this.h=h;
  }

} // End if shape class

public class Circle extends Shape
{
  int oldCanvasX;
  int oldCanvasY;
  Circle(float scalar, boolean filled, int lineColor, int fillColor)
  {
    type = "Circle";
    draggable=true;

    toggleable = true;
    w=0;
    h=0;

    this.scalar = scalar;
    this.lineColor = lineColor;
    this.filled = filled;
    this.fillColor = fillColor;

    oldCanvasX=canvas.x;
    oldCanvasY=canvas.y;
  }

  public void mousePressed()
  {
    if (!placed)
    {
      x=mouseX;
      y=mouseY;
    }

    super.mousePressed();
  }

  public void mouseReleased()
  {
    if (!placed)
    {
      placed = true;

      w=mouseX - x;
      h=mouseY - y;

      if (w < 0)
      {
        x += w;
        w = -w;
      }

      if (h < 0)
      {
        y += h;
        h = -h;
      }

    }


    super.mouseReleased();

  }

  public void mouseDragged()
  {
    super.mouseDragged();
  }

  public void draw()
  {
    if (!placed && mousePressed)
    {
      ellipse(x + ((mouseX - x) / 2), y + ((mouseY - y)/ 2), (mouseX - x), (mouseY - y));
    }
    else 
    {
      stroke(lineColor);
      if (!filled)
      {
        noFill();
      }
      else
      {
        fill(fillColor);
      }

      pushMatrix();
      Translate();
      rotate(radians(rotation));
      //invTranslate();
      ellipse(0, 0, w, h);
      rotate(radians(-rotation));
      popMatrix();
      
      stroke(0);

      if (selected)
      {
        noFill();
        strokeWeight(5);

        rect(x, y, w, h);

        strokeWeight(1);
      }

      noFill();
    }
  }

  public void flatten(PGraphics pg, int offsetX, int offsetY)
  {
     pg.stroke(lineColor);
      if (!filled)
      {
        pg.noFill();
      }
      else
      {
        pg.fill(fillColor);
      }

      pg.pushMatrix();
      FlattenTranslate(pg, oldCanvasX, oldCanvasY);
      pg.rotate(radians(rotation));
      pg.ellipse(0,0,round((float)w / this.scalar), round((float)h / this.scalar));
      pg.popMatrix();
  }

  public void scaleAfterReize(float scalar)
  {
     x = round((float)(x - oldCanvasX) / this.scalar);
     y = round((float)(y - oldCanvasY) / this.scalar);
     w = round((float)w / this.scalar);
     h = round((float)h / this.scalar);


     this.scalar = scalar;
     oldCanvasX = canvas.x;
     oldCanvasY = canvas.y;
     x = round(((float)x * scalar) + canvas.x);
     y = round(((float)y * scalar) + canvas.y);
     w = round((float)w * this.scalar);
     h = round((float)h * this.scalar);
    
  }


} // end of Circle class

public class Rectangle extends Shape 
{

  int oldCanvasX;
  int oldCanvasY;
  Rectangle(float scalar, boolean filled, int lineColor, int fillColor)
  {
    draggable = true;

    type = "Rectangle";

    toggleable = true;
    w=0;
    h=0;

    this.scalar = scalar;
    this.lineColor = lineColor;
    this.filled = filled;
    this.fillColor = fillColor;

    oldCanvasX=canvas.x;
    oldCanvasY=canvas.y;

  }

  public void mousePressed()
  {
    
    if (!placed)
    {
      x=mouseX;
      y=mouseY;
    }
    else
    {
      super.mousePressed();
    }
  }

  public void mouseDragged()
  {
    super.mouseDragged();
  }

  public void mouseReleased()
  {

    if (!placed)
    {
      placed = true;


      w=(mouseX - x);
      h=(mouseY - y);

      if (w < 0)
      {
        x += w;
        w = -w;
      }

      if (h < 0)
      {
        y += h;
        h = -h;
      }
    }

    super.mouseReleased();
  }

  public void draw()
  {
    if (!placed)
    {

      if (mousePressed)
      {
        rect(x, y, (mouseX - x), (mouseY - y));
      }

      
    }
    else 
    {
      stroke(lineColor);
      if (!filled)
      {
        noFill();
      }
      else
      {
        fill(fillColor);
      }

      pushMatrix();
      Translate();
      rotate(radians(rotation));
      //invTranslate();

      rect(-(w/2),-(h/2),w,h);
      popMatrix();

      stroke(0);

      if (selected)
      {
        noFill();
        strokeWeight(5);

        rect(x,y,w,h);

        strokeWeight(1);
      }

      noFill();
    }

  }

  public void flatten(PGraphics pg, int offsetX, int offsetY)
  {
    pg.stroke(lineColor);
    if (!filled)
    {
      pg.noFill();
    }
    else
    {
      pg.fill(fillColor);
    }
    //pg.rect(round((float)(x - oldCanvasX) / this.scalar),round((float)(y - oldCanvasY) / this.scalar)
    //  ,round((float)w / this.scalar),round((float)h / this.scalar));

    pg.pushMatrix();
    FlattenTranslate(pg, oldCanvasX, oldCanvasY);
    pg.rotate(radians(rotation));
    pg.rect(-round((float)w / this.scalar) / 2, - round((float)h / this.scalar) / 2, round((float)w / this.scalar), round((float)h / this.scalar));
    pg.popMatrix();
    pg.stroke(0);
  }



  public void scaleAfterReize(float scalar)
  {
     x = round((float)(x - oldCanvasX) / this.scalar);
     y = round((float)(y - oldCanvasY) / this.scalar);
     w = round((float)w / this.scalar);
     h = round((float)h / this.scalar);


     this.scalar = scalar;
     oldCanvasX = canvas.x;
     oldCanvasY = canvas.y;
     x = round(((float)x * scalar) + canvas.x);
     y = round(((float)y * scalar) + canvas.y);
     w = round((float)w * this.scalar);
     h = round((float)h * this.scalar);
    
  }

} // End of Rectangle class

public class Polygon extends Shape
{
  //Points to display
  ArrayList<Point> points = new ArrayList<Point>();
  //Stores points before the scalar is applied
  ArrayList<Point> actPoints = new ArrayList<Point>();

  //boolean filled=false;
  boolean closedShape=false;

  PShape shape = createShape();

  Polygon(float scalar, boolean filled, boolean closedShape, int lineColor, int fillColor)
  {
    type = "Polygon";

    toggleable = true;
    w=0;
    h=0;

    this.scalar = scalar;
    this.lineColor = lineColor;
    this.filled = filled;
    this.closedShape = closedShape;
    this.fillColor = fillColor;

  } 

  public void setFilled(boolean f)
  {
    filled = f;
    scaleAfterReize(scalar);
  }

  public void setSize(int w, int h)
  {
    println("w: " + this.w + " h:" + this.h);
    float scalarW = w / (float)this.w;
    float scalarH = h / (float)this.h;

    for (int i = 0; i < actPoints.size(); i++)
    {
      actPoints.set(i, new Point(round((float)actPoints.get(i).x * scalarW),round((float)actPoints.get(i).y * scalarH)));
    }

    scaleAfterReize(scalar);

    this.w=w;
    this.h=h;
  }

  Polygon(){}

  public Shape clone()
  {
    Polygon temp = new Polygon( scalar,  filled,  closedShape,  lineColor,  fillColor);
    
    type = "Polygon";
    draggable = true;
    temp.placed=true;
    temp.x=x;
    temp.y=y;
    temp.h=h;
    temp.w=w;

    for (Point p: points)
    {
      temp.addPoint(p.x,p.y);
    }

    return temp;
  }

  public void flatten(PGraphics pg, int offsetX, int offsetY)
  {
    PShape shape=createShape();

    shape.beginShape();
    if(!filled)
    {
      shape.noFill();
    }
    else
    {
      shape.fill(fillColor);
    }

    shape.stroke(lineColor);

    for (Point p: actPoints)
    {
      shape.vertex(p.x - round((float)(x - canvas.x) /scalar), p.y - round((float)(y - canvas.y)/scalar));
    }
    if (closedShape)
    {
      shape.endShape(CLOSE);
    }
    else
    {
      shape.endShape();
    }

    pg.pushMatrix();
    //FlattenTranslate(pg, canvas.x,canvas.y);
    pg.translate(((x-canvas.x) / scalar) + ((w/scalar)/2), ((y-canvas.y) / scalar) + ((h/scalar)/2));
    pg.rotate(radians(rotation));
    pg.shape(shape, -((w/scalar)/2), -((h/scalar)/2) );
    pg.popMatrix();
  }

  public void addPointAtMouseCursor()
  {
   addPoint(mouseX, mouseY); 
  }

  public void addPoint(int x, int y)
  {
    Point p = new Point(x, y);
    points.add(p);
    Point ap = new Point(round((x-canvas.x) / scalar), round((y-canvas.y) / scalar));
    actPoints.add(ap);

    
  }

  public void place()
  {
     placed = true;
     if (closedShape && points.size() > 0)
     {
      addPoint(points.get(0).x, points.get(0).y);
     }

     scaleAfterReize(scalar);

     wasClicked = true;

     scaleAfterReize(scalar);

  }

  public void mouseReleased()
  {
    super.mouseReleased();

    if (!placed)
    {
      if (mouseButton == LEFT)
      {
        addPointAtMouseCursor();
      }
      else if (mouseButton == RIGHT)
      {
       place();
      } 
    }
  }

  public void mouseDragged()
  {
    int oldX = x;
    int oldY = y;

    super.mouseDragged();
    oldX = x - oldX;
    oldY = y - oldY;

    ArrayList<Point> temp = new ArrayList<Point>();

    for (int i = 0; i < actPoints.size(); i++)
    {
      temp.add(new Point(actPoints.get(i).x + oldX, actPoints.get(i).y + oldY));
    }

    actPoints = temp;

    scaleAfterReize(scalar);
  }

  public void scaleAfterReize(float scalar)
  {
    
    super.scaleAfterReize(scalar);
    points = new ArrayList<Point>();
    for (Point p: actPoints)
    {
      points.add(p.scale(scalar));
    }

    shape=createShape();

    shape.beginShape();
    if(!filled)
    {
      shape.noFill();
    }
    else
    {
      shape.fill(fillColor);
    }

    shape.stroke(lineColor);

    for (Point p: points)
    {
      shape.vertex(p.x - x, p.y - y);
    }
    if (closedShape)
    {
      shape.endShape(CLOSE);
    }
    else
    {

      shape.endShape();
    }

    int count = 0;
    w=0;
    h=0;
    for (Point p: points)
    {

      if(count == 0)
      {
        this.x=p.x;
        this.y=p.y;
      }


      if (p.x < this.x)
      {
        w = w + abs(this.x-p.x);
        this.x=p.x;
      }

      if (p.y < this.y)
      {
        h += abs(this.y-p.y);
        this.y=p.y;
      }

      if (p.x > this.x+this.w)
      {
        this.w = p.x-this.x;
      }

      if (p.y > this.y+this.h)
      {
        this.h = p.y-this.y;
      }
      count++;
    }
    
  }

  public void draw()
  {
    
    if (!placed)
    {
      shape=createShape();

      shape.beginShape();
      shape.stroke(lineColor);

      for (Point p: points)
      {
        shape.vertex(p.x, p.y);
      }

      shape.vertex(mouseX, mouseY);
      shape.endShape();
      shape(shape, 0,0);
    }
    else
    {
      pushMatrix();
      Translate();
      rotate(radians(rotation));
      shape(shape,-(w/2),-(h/2));
      popMatrix();

      if (selected && placed)
      {
        rect(x,y,w,h);
      }
    }
    
    

  }


}// end of polygon class

public void drawLine(Point pointA, Point pointB)
{
  line(pointA.x, pointA.y, pointB.x, pointB.y);
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
  
  // now average all the red colours based on their relative amounts in A,B,C & D
  int aRed = PApplet.parseInt(areaA * red(pA) + areaB * red(pB) + areaC * red(pC) + areaD * red(pD) );
  int aGreen = PApplet.parseInt(areaA * green(pA) + areaB * green(pB) + areaC * green(pC) + areaD * green(pD) );
  int aBlue = PApplet.parseInt(areaA * blue(pA) + areaB * blue(pB) + areaC * blue(pC) + areaD * blue(pD) );

  
  return color(aRed, aGreen,aBlue);
}
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
  
  boolean layerChanged = false;
  
  LayerButtons()
  {
    x = width - 120;
    y = 45;
    allignX = 120;
    aligned = ALLIGNMENT.right;
    name = "LayerButtons";  
  }
  
  
  public void add (Button btn)
  {
    super.add(btn);
    allignX = 120;
    btn.allignX = 120;
    h += btn.h;
    
    if (btn.w > w)
    {
      w = btn.w;
    }
        
    btn.name = "LayerButton";
    btn.aligned = ALLIGNMENT.right;
  }
  
  public void mouseReleased()
  {
    super.mouseReleased();

    if (clickedList.size() > 1)
    {
      layerChanged = true;
    }
    else 
    {
      layerChanged = false;
    }
  }
}
class LayerResizeWindow extends FloatingWindow
{
	Layer layer;
	Shape shape;

	Slider WidthSlider = null;
	Slider HeightSlider = null;

	LayerResizeWindow(Layer l, Shape s)
	{
		x = 50;
		y = 50;
		w = 500;
		h = 100;
		
		closeButton.x = x+w - 20;
    	closeButton.y =  y;

		layer = l;
		shape = s;

		if (l != null)
		{
			WidthSlider = new Slider(10, 10, 255, 1, l.actImage.width * 4);
			HeightSlider = new Slider(10, 40, 255, 1, l.actImage.height * 4);

			WidthSlider.setValue(l.actImage.width);
			HeightSlider.setValue(l.actImage.height);
		} 
		
		
		//WidthSlider.setValue(l.actImage.width);
		//HeightSlider.setValue(l.actImage.height);

		if (s != null)
		{
			WidthSlider = new Slider(10, 10, 255, 1, s.w * 4);
			HeightSlider = new Slider(10, 40, 255, 1, s.h * 4);

			WidthSlider.setValue(s.w);
			HeightSlider.setValue(s.h);

		}
		
		if (WidthSlider != null)
		add(WidthSlider);
		if (WidthSlider != null)
		add(HeightSlider);

	}

	public void mouseReleased()
	{
		super.mouseReleased();

		if(layer != null)
			layer.ResizeLayer((int)WidthSlider.getValue(), (int)HeightSlider.getValue());
		if(shape != null)
			shape.setSize((int)WidthSlider.getValue(), (int)HeightSlider.getValue());

	}

	public void mouseDragged()
	{
		int oldX = x;
		int oldY = y;
		super.mouseDragged();
		if (oldX == x && oldY == y)
		{
			if(layer != null)
			layer.ResizeLayer((int)WidthSlider.getValue(), (int)HeightSlider.getValue());
			if(shape != null)
			shape.setSize((int)WidthSlider.getValue(), (int)HeightSlider.getValue());
		}
	}


	public void draw()
	{
		super.draw();
	}
}
class LayerSelector extends UIManager 
{
  Button newLayer, upLayer, downLayer;
  ScrollBar scrollBar;
  LayerButtons layerButtons;
  
  int numberOfLayers = 0;
  
  int oldIndex = -1;

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
        addLayer();
      }
       
    }
    
    
    if (layerButtons.activeButton == -1)
    {
      canvas.setLayerIndex(-1);
    }
    else 
    {
      if (oldIndex != layerButtons.activeButton) 
      canvas.setLayerIndex((numberOfLayers-1) - (layerButtons.activeButton));
    }
    oldIndex = layerButtons.activeButton;
    
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
    
    Menu editMenu = new EditMenu();
    editMenu.add(new Button("Undo", "mnbtnUndo"));
    Button redo = new Button("Redo", "mnbtnRedo");
    //redo.clickable = false;
    editMenu.add(redo);
    editMenu.add(new Button("Cut"));
    editMenu.add(new Button("Copy"));
    editMenu.add(new Button("Paste"));
    editMenu.setActive(false);

    Menu imageMenu = new ImageMenu();
    imageMenu.add(new Button("Resize image", "mnbtnResize"));
    imageMenu.add(new Button("Resize shape", "mnbtnResizeShape"));
    imageMenu.add(new Button("Rotate image", "mnbtnRotateImage"));
    imageMenu.add(new Button("Rotate shape", "mnbtnRotateShape"));
    imageMenu.setActive(false);

    Menu shapeMenu = new ShapeMenu();
    shapeMenu.add(new Button("Polyline", "mnbtnPolyline"));
    shapeMenu.add(new Button("Polyshape", "mnbtnPolyshape"));
    shapeMenu.add(new Button("Rectangle", "mnbtnRectangle"));
    shapeMenu.add(new Button("Circle", "mnbtnCircle"));
    shapeMenu.setActive(false);

    Menu filterMenu = new FilterMenu();
    filterMenu.add(new Button("Black and white", "mnbtnBlackAndWhite"));
    filterMenu.add(new Button("Greyscale", "mnbtnGreyscale"));
    filterMenu.add(new Button("Blur", "mnbtnBlur"));
    filterMenu.add(new Button("Sharpen", "mnbtnSharpen"));
    filterMenu.add(new Button("Edge detect", "mnbtnEdgeDetect"));
    filterMenu.add(new Button("Increase Contrast", "mnbtnIncContrast"));
    filterMenu.add(new Button("Decrease Contrast", "mnbtnDecContrast"));
    filterMenu.add(new Button("Increase Brightness", "mnbtnIncBrightness"));
    filterMenu.add(new Button("Decrease Brightness", "mnbtnDecBrightness"));

    filterMenu.setActive(false);

    addButton("File");
    addMenu(fileMenu);
    addButton("Edit");
    addMenu(editMenu);
    addButton("Resize");
    addMenu(imageMenu);
    addButton("Shapes");
    addMenu(shapeMenu);
    addButton("Filters");
    addMenu(filterMenu);

    
    widgetList.addAll(buttonList);
    widgetList.addAll(menuList);
  }
  
  public void mouseReleased()
  {
    wasClicked = false;
    super.mouseReleased();
    
    //Loops through each button on the menu bar
    //If a button is toggled then that buttons menu is displayed
    for(int i = 0; i < buttonList.size(); i++)
    {
        menuList.get(i).setActive(buttonList.get(i).toggled);

        if (menuList.get(i).clickedList.size() > 0)
        {
          wasClicked = true;
        }
        
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
//End of file menu class

class EditMenu extends Menu
{
  public void mouseReleased()
  {
    super.mouseReleased();
    
    for (String s: clickedList)
    {
      if (s == "mnbtnUndo")
      {
        canvas.undo();
      }

      if (s == "mnbtnRedo")
      {
        canvas.redo();
      }
    }
  }

} // end of edit menu class

class ImageMenu extends Menu
{
  public void mouseReleased()
  {

    super.mouseReleased();
    
    for (String s: clickedList)
    {
      if (s == "mnbtnResize")
      {
        if (canvas.layerIndex > -1)
        {
          ResizeLayer(canvas.layers.get(canvas.layerIndex), null);
        }

      }
      if (s == "mnbtnResizeShape")
      {
        if (canvas.layerIndex > -1)
        {
          ResizeLayer(null, canvas.layers.get(canvas.layerIndex).selectedShape);
        }
      }
      if (s == "mnbtnRotateImage")
      {
        if (canvas.layerIndex > -1)
        {
          RotateLayer(canvas.layers.get(canvas.layerIndex), null);
        }
      }
      if (s == "mnbtnRotateShape")
      {
        if (canvas.layerIndex > -1)
        {
          RotateLayer(null, canvas.layers.get(canvas.layerIndex).selectedShape);
        }
      }
      
      
        
    }
  }

}

class ShapeMenu extends Menu
{
  public void mouseReleased()
  {
    super.mouseReleased();
    
    for (String s: clickedList)
    {
      if (s == "mnbtnPolyline")
      {
        canvas.addPolygon(/*boolean filled*/filledButton.toggled, /*boolean closedShape*/false
          , /*color lineColor*/lineColorSelector.selectedColor, /*color fillColor*/fillColorSelector.selectedColor);

      }
      if (s == "mnbtnPolyshape")
      {
        canvas.addPolygon(/*boolean filled*/filledButton.toggled, /*boolean closedShape*/true
          , /*color lineColor*/lineColorSelector.selectedColor, /*color fillColor*/fillColorSelector.selectedColor);
      }

      if (s == "mnbtnRectangle")
      {
        canvas.addRectangle(/*boolean filled*/filledButton.toggled
          , /*color lineColor*/lineColorSelector.selectedColor, /*color fillColor*/fillColorSelector.selectedColor);
      }

      if (s == "mnbtnCircle")
      {
        canvas.addCircle(/*boolean filled*/filledButton.toggled
          , /*color lineColor*/lineColorSelector.selectedColor, /*color fillColor*/fillColorSelector.selectedColor);
      }
    }
  }

}


class FilterMenu extends Menu
{

  public void mouseReleased()
  {
    super.mouseReleased();

    for (String s: clickedList)
    {
      if (s == "mnbtnBlackAndWhite")
      {
        canvas.blackAndWhite();
      }

      if(s == "mnbtnGreyscale")
      {
        canvas.greyscale();
      }

      if (s == "mnbtnBlur")
      {
        canvas.convolute(blur_matrix);
      }

      if (s == "mnbtnSharpen")
      {
        canvas.convolute(sharpen_matrix);
      }

      if (s == "mnbtnEdgeDetect")
      {
        canvas.convolute(edge_matrix);
      }
      
      if (s == "mnbtnIncContrast")
      {
        if (canvas.layerIndex > -1)
        {
          canvas.layers.get(canvas.layerIndex).changeContrast(0);
        }
      }
      
      if (s == "mnbtnDecContrast")
      {
        if (canvas.layerIndex > -1)
        {
          canvas.layers.get(canvas.layerIndex).changeContrast(-10);
        }
      }
      
      if (s == "mnbtnIncBrightness")
      {
        if (canvas.layerIndex > -1)
        {
          canvas.layers.get(canvas.layerIndex).changeBrightness(50);
        }
      }
      
      if (s == "mnbtnDecBrightness")
      {
        if (canvas.layerIndex > -1)
        {
          canvas.layers.get(canvas.layerIndex).changeBrightness(-50);
        }
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
// THE GRAPHING FUNCTIONS
//
//
// multiplies the input by a value. darkens OK, but causes clipping when brightening
public float simpleScale(float v, float scl){
  
  float scaledV =  v*scl;
  return constrain(scaledV,0,1);
  
}

// interpolates the input value between the low and hi values
public float ramp(float v, float low, float hi){
  
  float rampedV = lerp(low, hi, v);
  return constrain(rampedV,0,1);
}

// negates the input value
public float invert(float v){
  
  return 1-v;
}


// raises the input value by a power
public float gammaCurve(float v, float gamma){
  
  return pow(v,gamma);
  
}

// creates a "flipped" gamma curve
public float inverseGammaCurve(float v, float gamma){
  
  return 1.0f - pow(1.0f-v,gamma);
  
}

// creates a nice S-shaped curve, useful for contrast functions
public float sigmoidCurve(float v){
  // contrast: generate a sigmoid function
  
  float f =  (1.0f / (1 + exp(-12 * (v  - 0.5f))));
  
 
  return f;
}


// creates a stepped output. useful for posterising
public float step(float v, int numSteps){
  float thisStep = (int) (v*numSteps);
  return thisStep/numSteps;
  
}

public int[] makeSigmoidLUT(int offset){
  int[] lut = new int[256];
  for(int n = 0; n < 256; n++) {
    
    float p = (n+offset)/255.0f;  // p ranges between 0...1
    float val = sigmoidCurve(p);
    lut[n] = (int)(val*255);
  }
  return lut;
}


// makeFunctionLUT
// this function returns a LUT from the range of functions listed
// in the second TAB above
// The parameters are functionName: a string to specify the function used
// parameter1 and parameter2 are optional, some functions do not require
// any parameters, some require one, some two

public int[] makeFunctionLUT(String functionName, float parameter1, float parameter2){
  
  int[] lut = new int[256];
  for(int n = 0; n < 256; n++) {
    
    float p = n/256.0f;  // ranges between 0...1
    float val = 0;
    
    switch(functionName) {
      // add in the list of functions here
      // and set the val accordingly
      
      case "makeSigmoidLUT":
       //lut[n] = int(step(n, (int)parameter1) * 255);
      case "simpleScale":
        print(PApplet.parseInt(simpleScale(p, 1.0f) * 255) + "\n");
        val = simpleScale(p, parameter1);
      case "invert":
        val = invert(p);
      case "ramp":
        val = ramp(p, parameter1, parameter2);
      case "gammaCurve":
        val = gammaCurve(p, parameter1);
      case "inverseGammaCurve":
        val = inverseGammaCurve(p, parameter1);
      case "step":
        val = step(p, (int)parameter1);
      
      //
      }// end of switch statement

   
    lut[n] = (int)(val*255);
  }
  
  return lut;
}






public PImage applyPointProcessing(int[] redLUT, int[] greenLUT, int[] blueLUT, PImage inputImage){
  PImage outputImage = createImage(inputImage.width,inputImage.height,RGB);
  
  
  inputImage.loadPixels();
  outputImage.loadPixels();
  int numPixels = inputImage.width*inputImage.height;
  for(int n = 0; n < numPixels; n++){
    
    int c = inputImage.pixels[n];
    
    int r = (int)red(c);
    int g = (int)green(c);
    int b = (int)blue(c);
    
    r = redLUT[r];
    g = greenLUT[g];
    b = blueLUT[b];
    
    outputImage.pixels[n] = color(r,g,b);
    
    
  }
  
  return outputImage;
}

public PImage ChangeContrast(PImage src, int offset)
{
  int[] lut = makeSigmoidLUT(offset);
  
  return applyPointProcessing(lut,lut,lut, src);
}

public PImage ChangeBrightness(PImage src, int offset)
{
  PImage ret = new PImage(src.width, src.height);
  
  for (int x = 0; x < src.width; x++)
  {
     for (int y = 0; y < src.height; y++)
     {
       int oldColor = src.get(x,y);
       int newColor = color(red(oldColor) + offset, green(oldColor) + offset, blue(oldColor) + offset);
       ret.set(x,y, newColor);
     }
    
  }
  
  return ret;
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
    
    /*ArrayList<Widget> temp = widgetList;
    
    widgetList = new ArrayList<Widget>();
    
    super.mouseReleased();
    
    widgetList = temp;*/
  }
  
  public void add(Button btn)
  {
    btn.toggleable = true; 
    btn.untoggleAfterClick = untoggleAfterClick;
    widgetList.add(btn);
  }
 
}
class RotateWindow extends FloatingWindow
{
	Layer layer;
	Shape shape;

	Slider rotateSlider = null;

	RotateWindow(Layer l, Shape s)
	{
		x = 50;
		y = 50;
		w = 500;
		h = 100;
		
		closeButton.x = x+w - 20;
    	closeButton.y =  y;

		layer = l;
		shape = s;

		if (l != null)
		{
			rotateSlider = new Slider(10, 10, 255, 0, 360);

			rotateSlider.setValue(l.getRotation());
		} 
		
		
		//WidthSlider.setValue(l.actImage.width);
		//HeightSlider.setValue(l.actImage.height);

		if (s != null)
		{
			rotateSlider = new Slider(10, 10, 255, 0, 360);

			rotateSlider.setValue(s.getRotation());

		}
		
		if (rotateSlider != null)
		add(rotateSlider);
		else 
			closed = true;
	}

	public void mouseReleased()
	{
		super.mouseReleased();

		if(layer != null)
			layer.setRotation((int)rotateSlider.getValue());
		if(shape != null)
			shape.setRotation((int)rotateSlider.getValue());

	}

	public void mouseDragged()
	{
		int oldX = x;
		int oldY = y;
		super.mouseDragged();
		if (oldX == x && oldY == y)
		{
			if(layer != null)
			layer.setRotation((int)rotateSlider.getValue());
			if(shape != null)
			shape.setRotation((int)rotateSlider.getValue());
		}
	}


	public void draw()
	{
		super.draw();
	}

} 
class RotationSlider extends Slider
{
  
  RotationSlider(int x, int y, int w, int min, int max)
  {
    //Slider(x,y,w,min,max);
    this.x = x;
    oldX = x;
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
    super.mouseDragged();
    
    if (clicked)
    {
    if (canvas != null)
    {
      if (canvas.layerIndex > -1)
      {
        Layer l = canvas.layers.get(canvas.layerIndex);

        if (l.selectedShape != null)
        {
          //l.selectedShape.setRotation(toggled);
        }
      }
    }
    }
  }
  
  public void mouseReleased()
  {
    super.mouseReleased();
    
    
  }
  
  public void WidgetClickEvent()
  {
    if (canvas != null)
    {
      if (canvas.layerIndex > -1)
      {
        Layer l = canvas.layers.get(canvas.layerIndex);

        if (l.selectedShape != null)
        {
          //l.selectedShape.setFilled(toggled);
        }
      }
    }
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
  protected float value;
  protected int oldX;
  TextInput textInput;
  
  Slider(int x, int y, int w, int min, int max)
  {
    this.x = x;
    oldX = x;
    this.y = y - 5;
    this.w=w;
    this.min = min;
    this.max=max;
    h = 10;
    
    rectX = x + (w/2);
    
    textInput = new TextInput(x+w+10, y, Float.toString(value), 12);
    
  }
  Slider()
  {}
  
  public void mouseDragged()
  {
    super.mouseDragged();
    //Keeps the bar within bounds of the slider
    if (clicked)
    {
      rectX = clamp(mouseX, x, x+ w);
      
      //Gets current value of the slider
      getValue();
      
      //Displays current value of the slider
      textInput.setString(Float.toString(value)); 
    }

    //rectX += x - oldX;

    //oldX = x;
  }
  
  public void mouseReleased()
  {
    super.mouseReleased();
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

  public void setValue(float val)
  {
    //Restricts the value of the slider
    value = clamp(val, min, max);

    //Sets the position of the rotation
    rectX = (int) map(value, min, max, x, x+w);

    //Changes the display text
    textInput.setString(Float.toString(value));

    mouseDragged();

  }
  
  public void resize(int dtW, int dtH)
  {
    super.resize(dtW, dtH);

    textInput.aligned = aligned;
    textInput.allignX = allignX;
    textInput.allignY = allignY;

    textInput.resize(dtW, dtH);
  }

  public void draw()
  {
    textInput.x= x+w+10;
    textInput.y = y;

    fill(0,0,0);
    //Draws the line which shows where the slide bar begins and ends
    rect(x,y + 5,w,0);
    //Draw the bar that the user slides
    rect(rectX, y, 7, 10);
    
    textInput.draw();
  }

  public void setPosition(int x, int y)
  {
    //println("Old x: " + this.x + "new x: " + x);

    //rectX = this.x - rectX;
    //rectX = rectX + x;
    rectX += (x - this.x);
    super.setPosition(x,y);
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
    {
      menuBar.mouseClicked();
    }
    
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
    for (Widget widget: widgetList)
    {
      widget.wasClicked = false;
    }

    if (menuBar != null)
    {
      menuBar.mouseReleased();
    
      if (menuBar.wasClicked)
      {
        return;
      }
    }
    

    //Updates the array of widgets that were clicked
    clickedList = new ArrayList<String>();
    for (int i = 0; i < widgetList.size(); i++)
    {
      widgetList.get(i).mouseReleased();
      if (widgetList.get(i).wasClicked)
      {
        clickedList.add(widgetList.get(i).name);
        //widgetList.get(i).wasClicked = false;
        break;
      }
      
      /*if (widgetList.get(i).closed)
      {
        widgetList.remove(i);
        i--;
      }*/
    }

    for (int i = 0; i < widgetList.size(); i++)
    {
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
      if (widgetList.get(i).clicked)
        return;
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

  public void setPosition(int x, int y)
  {
    this.x=x;
    this.y=y;
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
