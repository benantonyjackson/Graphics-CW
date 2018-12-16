class MenuBar extends UIManager
{
  ArrayList<Button> buttonList = new ArrayList<Button>();
  ArrayList<Menu> menuList = new ArrayList<Menu>();
  MenuBar()
  {
    Menu testMenu = new Menu(100, 50);
    
    testMenu.add(new Button());
    testMenu.add(new Button());
    testMenu.add(new Button());
    testMenu.add(new Button());
    
    testMenu.setActive(false);
    
    //menuList.add(testMenu);
    
    //buttonList.add(new Button(100,0, 100, 50));
    addButton("File");
    addMenu(testMenu);
    
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
      
      m.x=btn.x;
      
      m.y=btn.y+btn.w;
      
      menuList.add(m);
  }
  
}
