UIManager ui;

int oldWidth;
int oldHeight;


Canvas canvas;

void setup()
{
  size(900, 500);
  
  oldWidth = 900;
  oldHeight = 500;
  
  surface.setResizable(true);
  
  ui = new UIManager();
  
  
  
  //ui.add(new Slider(300, 300, 150, -100, 100));
  
  ui.add(new MenuBar());

  canvas = new Canvas();
  ui.add(canvas);
  
  ui.add(new ScrollBar(0,  height - 15, width, Orientation.horrizontal, 450));
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
