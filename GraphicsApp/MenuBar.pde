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
  
  void mouseReleased()
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
  void addButton(String s)
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
  void addMenu(Menu m)
  {
    //Sets the menus position to be under the button at the end of the menu bar
    
    Button btn = buttonList.get(buttonList.size()-1);
    m.setPosition(m.x=btn.x, m.y=btn.y+btn.h);
    
    menuList.add(m);
  }
  
}

class FileMenu extends Menu
{
  void mouseReleased()
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
  void mouseReleased()
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
  void mouseReleased()
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
  void mouseReleased()
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

  void mouseReleased()
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