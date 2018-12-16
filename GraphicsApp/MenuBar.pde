class MenuBar extends UIManager
{
  ArrayList<Button> buttonList = new ArrayList<Button>();
  ArrayList<Menu> menuList = new ArrayList<Menu>();
  MenuBar()
  {
    Menu fileMenu = new Menu();
    
    fileMenu.add(new Button("New"));
    fileMenu.add(new Button("Open"));
    fileMenu.add(new Button("Save"));
    fileMenu.add(new Button("Export"));
    fileMenu.setActive(false);
    
    Menu editMenu = new Menu();
    editMenu.add(new Button("Undo"));
    Button redo = new Button("Redo");
    redo.clickable = false;
    editMenu.add(redo);
    editMenu.add(new Button("Cut"));
    editMenu.add(new Button("Copy"));
    editMenu.add(new Button("Paste"));
    editMenu.setActive(false);
    
    addButton("File");
    addMenu(fileMenu);
    addButton("Edit");
    addMenu(editMenu);
    
    
    widgetList.addAll(buttonList);
    widgetList.addAll(menuList);
  }
  
  void mouseReleased()
  {
    super.mouseReleased();
    
    for(int i = 0; i < buttonList.size(); i++)
    {
        menuList.get(i).setActive(buttonList.get(i).toggled);
    }
  }
  
  void addButton(String s)
  {
    textSize(11);
    
    int mX = (int)textWidth(s)+7;
    
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
  
  
  void addMenu(Menu m)
  { 
      Button btn = buttonList.get(buttonList.size()-1);
      
      m.setPosition(m.x=btn.x, m.y=btn.y+btn.h);
      
      menuList.add(m);
  }
  
}
