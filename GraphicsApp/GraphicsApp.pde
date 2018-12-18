UIManager ui;

int oldWidth;
int oldHeight;


void setup()
{
  size(900, 500);
  
  oldWidth = 900;
  oldHeight = 500;
  
  surface.setResizable(true);
  
  ui = new UIManager();
  //print("Point b");
  //ui.add(new Button(200, 100, 100, 50));
  //ui.add(new RadioButtons());
  //Menu testMenu = new Menu(100, 100);
  
  /*testMenu.add(new Button());
  testMenu.add(new Button());
  testMenu.add(new Button());
  testMenu.add(new Button());*/
  
  Button btn = new Button("Test", 750, 400, 100, 50);
  
  btn.aligned = ALLIGNMENT.center_right;
  
  ui.add(new MenuBar());
  ui.add(btn);
  
  
  //ui.add(testMenu);
    //print ("Point a");
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
