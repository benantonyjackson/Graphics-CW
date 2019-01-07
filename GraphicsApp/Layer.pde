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
  
  void scaleAfterReize(float scalar)
  {
    disImage = scaleUp_bilinear((int)((float)actImage.width * scalar), (int)((float)actImage.height * scalar), actImage);
  }
  
}

PImage scaleUp_bilinear(int destinationImageWidth, int destinationImageHeight, PImage img){
  PImage destinationImage = new PImage(destinationImageWidth, destinationImageHeight);
  for (int y = 0; y < destinationImageHeight; y++) {
    for (int x = 0; x < destinationImageWidth; x++){
      
      float parametricX = (x/(float)destinationImageWidth);
      
      float parametricY = (y/(float)destinationImageHeight); 
        
      color thisPix = getPixelBilinear(parametricX,parametricY, img);
     
      destinationImage.set(x,y, thisPix);
    }
  
  }
  //destinationImage.save("scaleUp1_bilinear.png");
  return destinationImage;
} 
 
 
float getMantisa(float n)
{
  return n - ((int) n);
}


color getPixelBilinear(float x, float y, PImage img){
  
  // scale up the paramteric coordinates to match this image's pixel coordinates
  // but keep it floating point
  float scaledX = img.width * x;
  float scaledY = img.height * y;
  
  // regarding the 4 pixels we are concerned with
  // A B
  // C D
  // (0,0) is the coordinate at the top left of A
  // B,C and D are ventured into as X and Y move between 0...1
  // This algorithm works out the average colour of them based on the degree of overlap of each pixel
  
 
  // get the four pixels
  color pA = img.get((int)scaledX,(int)scaledY);
  color pB = img.get((int)scaledX + 1, (int)scaledY);
  color pC = img.get((int)scaledX,(int)scaledY + 1);
  color pD = img.get((int)scaledX + 1,(int)scaledY + 1);
  
  // work out the foating point bit of the pixel location
  
  float mx = getMantisa(scaledX);
  
  float my = getMantisa(scaledY);

  
  // use this work out the overlap for each pixel
  float areaA = ((1.0 - mx) * (1.0-my));
  
  float areaB = (mx * (1.0-my));
  
  float areaC = ((1.0 - mx) * my);
  
  float areaD = (mx*my);
  
  // sanity chack that all the areas add up to 1
  
  
  //if ((areaA + areaB + areaC + areaD) != 1.0)
  //{
    //System.out.println((areaA + areaB + areaC + areaD));
    //System.out.println("Not 1!");
  //}
  
  // now average all the red colours based on their relative amounts in A,B,C & D
  int aRed = int(areaA * red(pA) + areaB * red(pB) + areaC * red(pC) + areaD * red(pD) );
  int aGreen = int(areaA * green(pA) + areaB * green(pB) + areaC * green(pC) + areaD * green(pD) );
  int aBlue = int(areaA * blue(pA) + areaB * blue(pB) + areaC * blue(pC) + areaD * blue(pD) );

  
  return color(aRed, aGreen,aBlue);
}
  
