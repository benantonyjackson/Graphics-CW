UIManager ui;

int oldWidth;
int oldHeight;


public Canvas canvas;
public LayerSelector layerSelector;

void setup()
{
  size(900, 600);
  
  oldWidth = width;
  oldHeight = height;
  
  surface.setResizable(true);
  
  ui = new UIManager();
  
  
  
  //ui.add(new Slider(300, 300, 150, -100, 100));
  
 

  canvas = new Canvas();
  ui.add(canvas);
  layerSelector = new LayerSelector();
  ui.add(layerSelector);
  
   ui.add(new MenuBar());
  
  //ui.add(new ScrollBar(width - 10,  0, height, Orientation.vertical, 30));
  //ui.add(new ScrollBar(0,  height - 15, width, Orientation.horrizontal, 500));
}

void draw()
{
  if (oldWidth != width || oldHeight != height)
  {
    ui.resize((width - oldWidth), (height - oldHeight));
  }
  
  oldWidth = width;
  oldHeight = height;
  
  //print("width: " + width + " height: " + height + "\n");
  
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
}

void mouseDragged()
{
  ui.mouseDragged();
}

void keyPressed()
{
  
  
  ui.keyPressed();
}

void addLayer(File sourceImage)
{
  canvas.addLayer(sourceImage);
}
