UIManager ui;


void setup()
{
  size(900, 500);
  
  ui = new UIManager();
  
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
