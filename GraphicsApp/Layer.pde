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

  //Width and height of the actual image after resizing
  //Used to keep origonal image quality after resizing
  int newWidth;
  int newHeight;
  
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

    newWidth = actImage.width;
    newHeight = actImage.height;
  }
  
  Layer(PImage p, int ox, int oy)
  {
    actImage = p;
    
    name = "layer";
    
    draggable = true;
    
    offsetX = ox;
    offsetY = oy;

    newWidth = actImage.width;
    newHeight = actImage.height;
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

  void ResizeLayer(int w, int h)
  {
    newWidth = w;
    newHeight = h;

    scaleAfterReize(scalar);
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
        if(selectedShape != null)
        {
          selectedShape.selected = false;
        }
        

        wasClicked = true;
        s.wasClicked = false;
        selectedShape = s;
        s.selected = true;
        println(selectedShape.filled);
        filledButton.toggled = selectedShape.filled;
        break;
      }
    }

    if (selectedShape != null)
    {
      //println(selectedShape.type);
      //println(filledButton.toggled);
      //selectedShape.filled = filledButton.toggled;
      //selectedShape.scaleAfterReize(scalar);
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
    disImage = scaleUp_bilinear((int)((float)actImage.width * scalar * ((float)newWidth / (float)actImage.width)),
     (int)((float)actImage.height * scalar * ((float)newHeight / (float)actImage.height)), actImage);

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

  void addRectangle(boolean filled, color lineColor, color fillColor)
  {
    addShape(new Rectangle(scalar, filled, lineColor, fillColor));
  }

  void addCircle(boolean filled, color lineColor, color fillColor)
  {
    addShape(new Circle(scalar, filled, lineColor, fillColor));
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

    if (wasClicked)
    {
      lineColorSelector.selectedColor = lineColor;
      fillColorSelector.selectedColor = fillColor;
    }
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

  void setSize(int w, int h)
  {
    this.w=w;
    this.h=h;
  }

} // End if shape class

public class Circle extends Shape
{
  int oldCanvasX;
  int oldCanvasY;
  Circle(float scalar, boolean filled, color lineColor, color fillColor)
  {
    type = "Rectangle";
    draggable=true;

    toggleable = true;
    w=0;
    h=0;

    this.scalar = scalar;
    this.lineColor = lineColor;
    this.filled = filled;
    this.fillColor = fillColor;

    oldCanvasX=canvas.x;
    oldCanvasY=canvas.y;
  }

  void mousePressed()
  {
    if (!placed)
    {
      x=mouseX;
      y=mouseY;
    }

    super.mousePressed();
  }

  void mouseReleased()
  {
    if (!placed)
    {
      placed = true;

      w=mouseX - x;
      h=mouseY - y;

      if (w < 0)
      {
        x += w;
        w = -w;
      }

      if (h < 0)
      {
        y += h;
        h = -h;
      }

    }


    super.mouseReleased();

  }

  void mouseDragged()
  {
    super.mouseDragged();
  }

  void draw()
  {
    if (!placed && mousePressed)
    {
      ellipse(x + ((mouseX - x) / 2), y + ((mouseY - y)/ 2), (mouseX - x), (mouseY - y));
    }
    else 
    {
      stroke(lineColor);
      if (!filled)
      {
        noFill();
      }
      else
      {
        fill(fillColor);
      }

      ellipse(x + (w / 2), y + (h/2), w, h);

      stroke(0);

      if (selected)
      {
        noFill();
        strokeWeight(5);

        rect(x, y, w, h);

        strokeWeight(1);
      }

      noFill();
    }
  }

  void flatten(PGraphics pg, int offsetX, int offsetY)
  {
     pg.stroke(lineColor);
      if (!filled)
      {
        pg.noFill();
      }
      else
      {
        pg.fill(fillColor);
      }
      pg.ellipse(round((float)((x + (w / 2)) - oldCanvasX) / this.scalar),round((float)((y + (h / 2)) - oldCanvasY) / this.scalar)
      ,round((float)w / this.scalar),round((float)h / this.scalar));
  }

  void scaleAfterReize(float scalar)
  {
     x = round((float)(x - oldCanvasX) / this.scalar);
     y = round((float)(y - oldCanvasY) / this.scalar);
     w = round((float)w / this.scalar);
     h = round((float)h / this.scalar);


     this.scalar = scalar;
     oldCanvasX = canvas.x;
     oldCanvasY = canvas.y;
     x = round(((float)x * scalar) + canvas.x);
     y = round(((float)y * scalar) + canvas.y);
     w = round((float)w * this.scalar);
     h = round((float)h * this.scalar);
    
  }


} // end of Circle class

public class Rectangle extends Shape 
{

  int oldCanvasX;
  int oldCanvasY;
  Rectangle(float scalar, boolean filled, color lineColor, color fillColor)
  {
    draggable = true;

    type = "Rectangle";

    toggleable = true;
    w=0;
    h=0;

    this.scalar = scalar;
    this.lineColor = lineColor;
    this.filled = filled;
    this.fillColor = fillColor;

    oldCanvasX=canvas.x;
    oldCanvasY=canvas.y;

  }

  void mousePressed()
  {
    
    if (!placed)
    {
      x=mouseX;
      y=mouseY;
    }
    else
    {
      super.mousePressed();
    }
  }

  void mouseDragged()
  {
    super.mouseDragged();
  }

  void mouseReleased()
  {

    if (!placed)
    {
      placed = true;


      w=(mouseX - x);
      h=(mouseY - y);

      if (w < 0)
      {
        x += w;
        w = -w;
      }

      if (h < 0)
      {
        y += h;
        h = -h;
      }
    }

    super.mouseReleased();
  }

  void draw()
  {
    if (!placed)
    {

      if (mousePressed)
      {
        rect(x, y, (mouseX - x), (mouseY - y));
      }

      
    }
    else 
    {
      stroke(lineColor);
      if (!filled)
      {
        noFill();
      }
      else
      {
        fill(fillColor);
      }

       rect(x,y,w,h);

      stroke(0);

      if (selected)
      {
        noFill();
        strokeWeight(5);

        rect(x,y,w,h);

        strokeWeight(1);
      }

      noFill();
    }

  }

  void flatten(PGraphics pg, int offsetX, int offsetY)
  {
    pg.stroke(lineColor);
    if (!filled)
    {
      pg.noFill();
    }
    else
    {
      pg.fill(fillColor);
    }
    pg.rect(round((float)(x - oldCanvasX) / this.scalar),round((float)(y - oldCanvasY) / this.scalar)
      ,round((float)w / this.scalar),round((float)h / this.scalar));

    pg.stroke(0);
  }



  void scaleAfterReize(float scalar)
  {
     x = round((float)(x - oldCanvasX) / this.scalar);
     y = round((float)(y - oldCanvasY) / this.scalar);
     w = round((float)w / this.scalar);
     h = round((float)h / this.scalar);


     this.scalar = scalar;
     oldCanvasX = canvas.x;
     oldCanvasY = canvas.y;
     x = round(((float)x * scalar) + canvas.x);
     y = round(((float)y * scalar) + canvas.y);
     w = round((float)w * this.scalar);
     h = round((float)h * this.scalar);
    
  }

} // End of Rectangle class

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
    w=0;
    h=0;

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
    draggable = true;
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

     scaleAfterReize(scalar);

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
  }

  void mouseDragged()
  {
    int oldX = x;
    int oldY = y;

    super.mouseDragged();
    oldX = x - oldX;
    oldY = y - oldY;

    ArrayList<Point> temp = new ArrayList<Point>();

    for (int i = 0; i < actPoints.size(); i++)
    {
      temp.add(new Point(actPoints.get(i).x + oldX, actPoints.get(i).y + oldY));
    }

    actPoints = temp;

    scaleAfterReize(scalar);
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

    int count = 0;
    w=0;
    h=0;
    for (Point p: points)
    {

      if(count == 0)
      {
        this.x=p.x;
        this.y=p.y;
      }


      if (p.x < this.x)
      {
        w = w + abs(this.x-p.x);
        this.x=p.x;
      }

      if (p.y < this.y)
      {
        h += abs(this.y-p.y);
        this.y=p.y;
      }

      if (p.x > this.x+this.w)
      {
        this.w = p.x-this.x;
      }

      if (p.y > this.y+this.h)
      {
        this.h = p.y-this.y;
      }
      count++;
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
  line(pointA.x, pointA.y, pointB.x, pointB.y);
}