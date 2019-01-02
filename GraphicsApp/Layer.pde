class Layer extends UIManager
{
  //Image that is actually used to write to file
  PImage actImage;
  //Image that is diplayed to the screen
  PImage disImage;
  
  Layer(File sourceImage)
  {
    actImage = loadImage(sourceImage.getAbsolutePath());
    
    disImage = actImage;
    
    
  }
  
  void draw()
  {
    image(disImage, canvas.x + x, canvas.y + y);
  }
  
  
}
