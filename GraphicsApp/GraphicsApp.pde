UIManager ui;


void setup()
{
  size(900, 500);
  
  ui = new UIManager();
  //print("Point b");
  //ui.add(new Button(200, 100, 100, 50));
  //ui.add(new RadioButtons());
  //Menu testMenu = new Menu(100, 100);
  
  testMenu.add(new Button());
  testMenu.add(new Button());
  testMenu.add(new Button());
  testMenu.add(new Button());

  
  
  ui.add(testMenu);
    //print ("Point a");
}

void draw()
{
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
