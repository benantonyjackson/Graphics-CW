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

  Shape selectedShape = null;

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

    super.mouseReleased();
    for (Shape s: shapeList)
    {
      if (s.wasClicked)
      {
        wasClicked = true;
        s.wasClicked = false;
        selectedShape = s;
        s.selected = true;
        break;
      }
    }

    if (selectedShape != null)
    {
      //println(selectedShape.type);
    }
    else 
    {
      //println("Null");
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

  public void addShape(Shape s)
  {
    add(s);
    shapeList.add(s);
    clicked = true;
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

void blackAndWhite()
{
  actImage = BlackAndWhite(actImage);
  disImage = BlackAndWhite(disImage);
}

void greyscale()
{
  actImage = Greyscale(actImage);
  disImage = Greyscale(disImage);
}
void convolute(float [][] matrix)
{
  actImage = Convolute(actImage, matrix);
  disImage = Convolute(disImage, matrix);
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

public class Shape extends Widget
{
  boolean filled;
  color fillColor;
  color lineColor;
  float rotation = 0;
  boolean placed = false;
  float scalar;
  String type = "";
  boolean selected = false;

  void setFilled(boolean f)
  {
    filled = f;
  }

  void setFilled(boolean f, color c)
  {
    setFilled(f);
    setFillColor(c);
  }

  void mouseReleased()
  {
    super.mouseReleased();
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

public class Polygon extends Shape
{
  //Points to display
  ArrayList<Point> points = new ArrayList<Point>();
  //Stores points before the scalar is applied
  ArrayList<Point> actPoints = new ArrayList<Point>();

  boolean filled=false;
  boolean closedShape=false;

  PShape shape = createShape();

  Polygon(float scalar, boolean filled, boolean closedShape, color lineColor, color fillColor)
  {
    type = "Polygon";

    toggleable = true;


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
    
    type = "Polygon";

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

  void flatten(PGraphics pg, int offsetX, int offsetY)
  {
    PShape shape=createShape();

    shape.beginShape();
    if(!filled)
    {
      shape.noFill();
    }
    else
    {
      shape.fill(fillColor);
    }

    shape.stroke(lineColor);

    for (Point p: actPoints)
    {
      shape.vertex(p.x, p.y);
    }
    if (closedShape)
    {
      shape.endShape(CLOSE);
    }
    else
    {
      shape.endShape();
    }

    pg.shape(shape, 0, 0);
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

    if (x < this.x || points.size() == 1)
    {
      w += abs(this.x-x);
      this.x=x;
    }

    if (y < this.y || points.size() == 1)
    {
      h += abs(this.y-y);
      this.y=y;
    }

    if (x > this.x+this.w)
    {
      this.w=x-this.x;
    }

    if (y > this.y+this.h)
    {
      this.h = y-this.y;
    }
  }

  void place()
  {
     placed = true;
     if (closedShape && points.size() > 0)
     {
      addPoint(points.get(0).x, points.get(0).y);
     }

     scaleAfterReize(scalar);

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

    if (selected)
    {
      lineColorSelector.selectedColor = lineColor;
      fillColorSelector.selectedColor = fillColor;
    }
  }

  void scaleAfterReize(float scalar)
  {
    
    super.scaleAfterReize(scalar);
    points = new ArrayList<Point>();
    for (Point p: actPoints)
    {
      points.add(p.scale(scalar));
    }

    shape=createShape();

    shape.beginShape();
    if(!filled)
    {
      shape.noFill();
    }
    else
    {
      shape.fill(fillColor);
    }

    shape.stroke(lineColor);

    for (Point p: points)
    {
      shape.vertex(p.x, p.y);
    }
    if (closedShape)
    {
      shape.endShape(CLOSE);
    }
    else
    {

      shape.endShape();
    }


    for (Point p: points)
    {

      int x = p.x;
      int y = p.y;

      if (x < this.x || points.size() == 1)
      {
        w += abs(this.x-x);
        this.x=x;
      }

      if (y < this.y || points.size() == 1)
      {
        h += abs(this.y-y);
        this.y=y;
      }

      if (x > this.x+this.w)
      {
        this.w=x-this.x;
      }

      if (y > this.y+this.h)
      {
        this.h = y-this.y;
      }
    }

  }

  void draw()
  {
    
    if (!placed)
    {
      shape=createShape();

      shape.beginShape();
      shape.stroke(lineColor);

      for (Point p: points)
      {
        shape.vertex(p.x, p.y);
      }

      shape.vertex(mouseX, mouseY);
      shape.endShape();
    }
    

    shape(shape,0,0);

    if (selected && placed)
    {
      rect(x,y,w,h);
    }

  }


}// end of polygon class

void drawLine(Point pointA, Point pointB)
{
  //bresLine(pointA.x, pointA.y, pointB.x, pointB.y, col);
  //testDrawLine(pointA.x, pointA.y, pointB.x, pointB.y, col);


  line(pointA.x, pointA.y, pointB.x, pointB.y);
}

