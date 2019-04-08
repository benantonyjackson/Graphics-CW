class Layer extends UIManager
{
  //Image that is actually used to write to file
  PImage actImage;
  //Image that is diplayed to the screen
  PImage disImage;
  
  //Stores the position of the actual image for exporting the image
  //The widget x and y are used for the display image
  int offsetX = 100;
  int offsetY = 100;
  
  //Set to true if a change needs to be added to the undo list
  boolean changed = false;
  
  float scalar;

  //Indicates whether or not the layer is selected
  private boolean selected = false;
  
  private float rotation = 0; 

  ArrayList<Shape> shapeList = new ArrayList<Shape>();
  
  Layer(File sourceImage)
  {
    //Loads the image that the layer is made of into memory
    actImage = loadImage(sourceImage.getAbsolutePath());
    
    disImage = actImage;
    
    name = "layer";
    
    draggable = true;


  }
  
  Layer(PImage p, int ox, int oy)
  {
    actImage = p;
    
    name = "layer";
    
    draggable = true;
    
    offsetX = ox;
    offsetY = oy;
  }
  
  Layer clone()
  {
    Layer l = new Layer(actImage, offsetX, offsetY);
    l.changed = changed;

    for (Shape shape: shapeList)
    {
      l.addShape(shape.clone());
    }



    return l;
  }

  void draw()
  {
    image(disImage, x, y);

    if (selected)
    {
      noFill();
      strokeWeight(3);
      rect(x, y, w, h);

      strokeWeight(1);
    }

    for (Shape s: shapeList)
    {
      s.draw();
    }
  }

  void mouseReleased()
  {
    println("point d");
    super.mouseReleased();
    for (Shape s: shapeList)
    {
      //s.mouseReleased();
      println("Point b");
      println("Was clicked 2: " + s.wasClicked);
      if (s.wasClicked)
      {
        println("Point a");
        wasClicked = true;
        s.wasClicked = false;
      }
    }
  }

  //Writes shape data to the final PGraphic 
  void flatten(PGraphics pg)
  {
    pg.image(actImage, offsetX, offsetY);

    for(Shape s: shapeList)
    {
      s.flatten(pg, offsetX, offsetY);
    }

  }
  
  //Sets whether or not the layer is selected or not
  void setSelected(boolean flag)
  {
    selected = flag;
  }

  void setRotation(float r)
  {
    rotation = r;
  }

  float getRotation()
  {
    return rotation;
  }

  void scaleAfterReize(float scalar)
  {
    //Scales display image to the size of the canvas 
    disImage = scaleUp_bilinear((int)((float)actImage.width * scalar), (int)((float)actImage.height * scalar), actImage);
    
    w = disImage.width;
    h = disImage.height;
    
    x = (int)((float)offsetX * scalar) + canvas.x;
    y = (int)((float)offsetY * scalar) + canvas.y;
    
    this.scalar = scalar;

    for (Shape s: shapeList)
    {
      s.scaleAfterReize(scalar);
    }
  }
  
  void mouseDragged()
  {
    super.mouseDragged();
    
    offsetX = (int)(((float)x - (float)canvas.x) / scalar);
    offsetY = (int)(((float)y - (float)canvas.y) / scalar);
    
  }

  void addShape(Shape s)
  {
    add(s);
    shapeList.add(s);
  }

  void addPolygon(boolean filled, boolean closedShape, color lineColor, color fillColor)
  {
    addShape(new Polygon(scalar, filled, closedShape, lineColor, fillColor));
  }
 
 //Start of Functions
PImage scaleUp_bilinear(int destinationImageWidth, int destinationImageHeight, PImage img){
  //Create a blank image for the destination imgage
  PImage destinationImage = new PImage(destinationImageWidth, destinationImageHeight);
  //Loops through each pixel in the destination image
  for (int y = 0; y < destinationImageHeight; y++) {
    for (int x = 0; x < destinationImageWidth; x++){
      //Scales coordinates to origonal image pixel coordinates
      float parametricX = (x/(float)destinationImageWidth);
      float parametricY = (y/(float)destinationImageHeight); 
      
      //Gets the pixel color of the current pixel
      color thisPix = getPixelBilinear(parametricX,parametricY, img);
      destinationImage.set(x,y, thisPix);
    }
  
  }
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
  
  // now average all the red colours based on their relative amounts in A,B,C & D
  int aRed = int(areaA * red(pA) + areaB * red(pB) + areaC * red(pC) + areaD * red(pD) );
  int aGreen = int(areaA * green(pA) + areaB * green(pB) + areaC * green(pC) + areaD * green(pD) );
  int aBlue = int(areaA * blue(pA) + areaB * blue(pB) + areaC * blue(pC) + areaD * blue(pD) );

  
  return color(aRed, aGreen,aBlue);
}


 
}
//End of layer class

class Point
{
  public int x, y;
  Point(int x,int y)
  {
    this.x=x;
    this.y=y;
  }

  public Point scale(float scalar)
  {
    float tx = x * scalar;
    float ty = y * scalar;

    return new Point(round(tx)+canvas.x,round(ty)+canvas.y);
  }
}

class Shape extends Widget
{
  boolean filled;
  color fillColor;
  color lineColor;
  float rotation = 0;
  boolean placed = false;
  float scalar;

  void setFilled(boolean f)
  {
    filled = f;
  }

  void setFilled(boolean f, color c)
  {
    setFilled(f);
    setFillColor(c);
  }



  boolean getFilled()
  {
    return filled;
  }

  void setFillColor (color c)
  {
    fillColor = c;
  }

  color getFillColor()
  {
    return fillColor;
  }

  void setRotation(float r)
  {
    rotation = r;
  }

  float getRotation()
  {
    return rotation;
  }

  void scaleAfterReize(float scalar)
  {
    this.scalar = scalar;
  }

  void flatten(PGraphics pg, int offsetX, int offsetY)
  {

  }

  Shape clone()
  {
    Shape temp = new Shape();

    temp.filled = filled;
    temp.fillColor=fillColor;
    temp.lineColor=lineColor;
    temp.rotation = 0;
    temp.placed = false;
    temp.scalar=scalar;

    return temp;
  }
} // End if shape class

class Polygon extends Shape
{
  //Points to display
  ArrayList<Point> points = new ArrayList<Point>();
  //Stores points before the scalar is applied
  ArrayList<Point> actPoints = new ArrayList<Point>();

  boolean filled=false;
  boolean closedShape=false;

  Polygon(float scalar, boolean filled, boolean closedShape, color lineColor, color fillColor)
  {
    this.scalar = scalar;
    this.lineColor = lineColor;
    this.filled = filled;
    this.closedShape = closedShape;
    this.fillColor = fillColor;

  } 

  Polygon(){}

  Shape clone()
  {
    Polygon temp = new Polygon( scalar,  filled,  closedShape,  lineColor,  fillColor);
    
    temp.placed=true;
    temp.x=x;
    temp.y=y;
    temp.h=h;
    temp.w=w;

    for (Point p: points)
    {
      temp.addPoint(p.x,p.y);
    }

    return temp;
  }

  void addPointAtMouseCursor()
  {
   addPoint(mouseX, mouseY); 
  }

  void addPoint(int x, int y)
  {
    Point p = new Point(x, y);
    points.add(p);
    Point ap = new Point(round((x-canvas.x) / scalar), round((y-canvas.y) / scalar));
    actPoints.add(ap);

    if (x < this.x)
    {
      this.x=x;
    }

    if (y < this.y)
    {
      this.y=y;
    }

    if (x > this.w)
    {
      this.w=x;
    }

    if (y > this.h)
    {
      this.h = y;
    }
  }

  void place()
  {
     placed = true;
     if (closedShape && points.size() > 0)
     {
      addPoint(points.get(0).x, points.get(0).y);
     }

     println("point c");
     wasClicked = true;

  }

  void mouseReleased()
  {
    super.mouseReleased();

    if (!placed)
    {
      if (mouseButton == LEFT)
      {
        addPointAtMouseCursor();
      }
      else if (mouseButton == RIGHT)
      {
       place();
      } 
    }

    println("Was clicked: " + wasClicked);
  }

  void scaleAfterReize(float scalar)
  {
    
    super.scaleAfterReize(scalar);
    points = new ArrayList<Point>();
    for (Point p: actPoints)
    {
      points.add(p.scale(scalar));
    }
  }

  void draw()
  {
    Point prevPoint =null;
    for (Point p: points)
    {

      if(prevPoint == null)
      {
        prevPoint = p;
      }
      
      //DrawLine between prevPoint and p
      stroke(lineColor);
      //strokeWeight(20);
      drawLine(prevPoint, p);
      stroke(color(0,0,0));
      //strokeWeight(0);
      prevPoint = p;
    }

    if (!placed && points.size() > 0)
    {
      
      Point mPoint = new Point(mouseX, mouseY);
      stroke(lineColor);
      drawLine (prevPoint, mPoint);
      stroke(color(0,0,0));
    }

    if (filled)
    {
      //TODO add code to fill shape
    }
  }

  void flatten(PGraphics pg, int offsetX, int offsetY)
  {
    pg.stroke(lineColor);
    for (int i = 0; i < actPoints.size() - 1; i++)
    {
      pg.line(actPoints.get(i).x, actPoints.get(i).y, actPoints.get(i+1).x, actPoints.get(i+1).y);
    }

    if (closedShape)
    {
      pg.line(actPoints.get(actPoints.size()-1).x, actPoints.get(actPoints.size()-1).y,
       actPoints.get(0).x, actPoints.get(0).y);
    }
    pg.stroke(0);
  }


}// end of polygon class

void drawLine(Point pointA, Point pointB)
{
  //bresLine(pointA.x, pointA.y, pointB.x, pointB.y, col);
  //testDrawLine(pointA.x, pointA.y, pointB.x, pointB.y, col);


  line(pointA.x, pointA.y, pointB.x, pointB.y);
}

void bresLine(int x1, int y1, int x2, int y2, color col){
  stroke(col);
  int incY = 1;
  if (y1 > y2)
  {
    /*int temp = y2;
    y2 = y1;
    y1 = temp;*/
    incY = -1;
  }
  int yd=y2-y1;  
  
  int lineEnd=x2;

  int inc = 1;
  if (x2 < x1)
  {
    /*int temp = x2;
    x2=x1;
    x1 = temp;*/
    
    inc = -1;
    lineEnd = x1;
  }
  int xd=x2-x1;  
  
  int e=0;  
  int y=y1;  
  for (int x=x1; x>=x2 && x<=x1; x+=inc){  
  point(x,y);
  if((2*(e+yd))<xd){  
    e+=yd;  
      }else{  
    y += incY;  
    e+=(yd-xd);  
     }
  }
  stroke(color(0,0,0));
}

void swap(double a, double b)
{
  a = a + b;
}

//Called to draw line to final image
//Currently unfished. Need to adapt to write to image instead of screen
void flattenLine(float x1, float y1, float x2, float y2, color col)
{
  //Ensures that line is drawn lowest point to highest point
  if (y1 > y2)
  {
    //swap(x1, x2);
    float temp = x1;
    x1 = x2;
    x2 = temp;
    swap(y1, y2);
    temp = y1;
    y1=y2;
    y2=temp;
  }

  //Stores the gradient of the line
  float gradient = 0;
  //
  float increment = 1;

   //Prevent divide by 0 error
  if (x1 == x2)
  {
    //If the line is perfectly horizontal then the line has no gradient
    gradient = 1;
  }
  else if (y1 != y2)
  {
    //Calculates the gradient of the line
    float o = y2 - y1;
    float a = abs(x2 - x1);
    gradient = (o / a);

    //Ensures pixels are no skippped at more extreme gradients
    increment = 1 / (gradient + 1);
    gradient /= gradient + 1;
  }

  //Determines whether the line is drawn left to right or right to left
  if (x2 < x1)
  {
    increment = -increment;
  }

  //Stores the y value of the current pixel being drawn
  //Initialised to the y value of lowest of the two points
  float y = y1;
  
  for (float x = x1; (int)x != (int)x2; x += increment)
  {
    //Increases y by the gradient
    y += gradient;

    stroke(col);
    point(x,y);
    stroke(color(0,0,0));
  }

}

