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
  
  //Button btn = new Button("Test", 750, 400, 100, 50);
  
  //btn.aligned = ALLIGNMENT.center_right;
  
  
  /*Menu m = new Menu(300, 300);
  
  m.add(new Button("btn1"));
  m.add(new Button("btn1"));
  m.add(new Button("btn1"));
  m.aligned = ALLIGNMENT.center;*/
  
  
  //ui.add(new TextInput(0, 300, "Test",32));
  
  ui.add(new Slider(10, 300, 300, 0, 100));
  
  ui.add(new MenuBar());

  
  
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

void keyPressed()
{
  
  
  ui.keyPressed();
}
