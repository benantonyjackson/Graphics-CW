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
    
    menuList.add(testMenu);
    
    buttonList.add(new Button(100,0, 100, 50));
    
    
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
  
  
}
