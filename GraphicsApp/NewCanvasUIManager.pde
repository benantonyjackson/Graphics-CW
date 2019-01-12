class NewCanvasUIManager extends FloatingWindow
{
  TextInput txtWidth;
  TextInput txtHeight;
  Button confirmButton;
  
  NewCanvasUIManager()
  {
    x = 150;
    y = 150;
    w=300;
    h=200;
    
    txtWidth = new TextInput(50, 20, "500", 12);
    txtHeight = new TextInput(50, 60, "500", 12);
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
    
    //resize(0,0);
  }
  
  
  void mouseReleased()
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
