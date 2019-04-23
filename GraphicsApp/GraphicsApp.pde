import java.io.FileOutputStream;
import java.io.ObjectOutputStream;
import java.io.FileInputStream;
import java.io.ObjectInputStream;


UIManager ui;
UIManager drawingUI;

//Stores the size of the window in the previous frame.
//Used to determin if the window has been resized
int oldWidth;
int oldHeight;

color windowColor = color(25,25,25);

public Canvas canvas;
public LayerSelector layerSelector;
//public Label lblLineColor = new Label(10, 100, "Line");
//public Label lblFillColor = new Label(10, 100, "Fill");
public ColorSelector lineColorSelector = new ColorSelector(35, 100);
public ColorSelector fillColorSelector = new ColorSelector(35, 130);



void setup()
{
  size(900, 600);
  
  oldWidth = width;
  oldHeight = height;
  
  surface.setResizable(true);
  ui = new UIManager(new MenuBar());
  ui.add(lineColorSelector);
  ui.add(fillColorSelector);
  ui.add(new Label(10, 100, "Line"));
  ui.add(new Label(10, 130, "Fill"));
 // ui.add(lblLineColor);
  //ui.add(lblFillColor);
  ui.name="ui";
  
  
  
}

void draw()
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

void mousePressed() 
{
  ui.mousePressed();
}

void mouseClicked ()
{
  ui.mouseClicked();
}

void mouseMoved()
{
  ui.mouseMoved();
}

void mouseReleased()
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

void mouseDragged()
{
  ui.mouseDragged();
}

void keyPressed()
{
  
  
  ui.keyPressed();
}

//Function called when the user adds a new picture to the project
void addLayer(File sourceImage)
{
  canvas.addLayer(sourceImage);
}

//Function called when the user exports the image
void export(File outputDir)
{
  canvas.export(outputDir);
}

void setupNewCanvas (int w, int h)
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

void openCanvasConfigWindow()
{
  ui.remove(newCanvasUIManager);

  newCanvasUIManager = new NewCanvasUIManager();

  ui.add(newCanvasUIManager);
}

void saveCanvas(File outputDir)
{
  canvas.saveCanvas(outputDir);
}

void loadProject(File inputDir)
{
  String[] lines = loadStrings(inputDir.getAbsolutePath());
      
  setupNewCanvas(Integer.parseInt(lines[0]), Integer.parseInt(lines[1]));
  
  canvas.loadProject(lines);
}

void PickColor(ColorSelector sel, int r, int g, int b)
{
  ui.add(new ColorPickerWindow(sel,r,g,b));
}
