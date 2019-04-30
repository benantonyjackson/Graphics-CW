// THE GRAPHING FUNCTIONS
//
//
// multiplies the input by a value. darkens OK, but causes clipping when brightening
float simpleScale(float v, float scl){
  
  float scaledV =  v*scl;
  return constrain(scaledV,0,1);
  
}

// interpolates the input value between the low and hi values
float ramp(float v, float low, float hi){
  
  float rampedV = lerp(low, hi, v);
  return constrain(rampedV,0,1);
}

// negates the input value
float invert(float v){
  
  return 1-v;
}


// raises the input value by a power
float gammaCurve(float v, float gamma){
  
  return pow(v,gamma);
  
}

// creates a "flipped" gamma curve
float inverseGammaCurve(float v, float gamma){
  
  return 1.0 - pow(1.0-v,gamma);
  
}

// creates a nice S-shaped curve, useful for contrast functions
float sigmoidCurve(float v){
  // contrast: generate a sigmoid function
  
  float f =  (1.0 / (1 + exp(-12 * (v  - 0.5))));
  
 
  return f;
}


// creates a stepped output. useful for posterising
float step(float v, int numSteps){
  float thisStep = (int) (v*numSteps);
  return thisStep/numSteps;
  
}

int[] makeSigmoidLUT(int offset){
  int[] lut = new int[256];
  for(int n = 0; n < 256; n++) {
    
    float p = (n+offset)/255.0f;  // p ranges between 0...1
    float val = sigmoidCurve(p);
    lut[n] = (int)(val*255);
  }
  return lut;
}


// makeFunctionLUT
// this function returns a LUT from the range of functions listed
// in the second TAB above
// The parameters are functionName: a string to specify the function used
// parameter1 and parameter2 are optional, some functions do not require
// any parameters, some require one, some two

int[] makeFunctionLUT(String functionName, float parameter1, float parameter2){
  
  int[] lut = new int[256];
  for(int n = 0; n < 256; n++) {
    
    float p = n/256.0f;  // ranges between 0...1
    float val = 0;
    
    switch(functionName) {
      // add in the list of functions here
      // and set the val accordingly
      
      case "makeSigmoidLUT":
       //lut[n] = int(step(n, (int)parameter1) * 255);
      case "simpleScale":
        print(int(simpleScale(p, 1.0) * 255) + "\n");
        val = simpleScale(p, parameter1);
      case "invert":
        val = invert(p);
      case "ramp":
        val = ramp(p, parameter1, parameter2);
      case "gammaCurve":
        val = gammaCurve(p, parameter1);
      case "inverseGammaCurve":
        val = inverseGammaCurve(p, parameter1);
      case "step":
        val = step(p, (int)parameter1);
      
      //
      }// end of switch statement

   
    lut[n] = (int)(val*255);
  }
  
  return lut;
}






PImage applyPointProcessing(int[] redLUT, int[] greenLUT, int[] blueLUT, PImage inputImage){
  PImage outputImage = createImage(inputImage.width,inputImage.height,RGB);
  
  
  inputImage.loadPixels();
  outputImage.loadPixels();
  int numPixels = inputImage.width*inputImage.height;
  for(int n = 0; n < numPixels; n++){
    
    color c = inputImage.pixels[n];
    
    int r = (int)red(c);
    int g = (int)green(c);
    int b = (int)blue(c);
    
    r = redLUT[r];
    g = greenLUT[g];
    b = blueLUT[b];
    
    outputImage.pixels[n] = color(r,g,b);
    
    
  }
  
  return outputImage;
}

PImage ChangeContrast(PImage src, int offset)
{
  int[] lut = makeSigmoidLUT(offset);
  
  return applyPointProcessing(lut,lut,lut, src);
}

PImage ChangeBrightness(PImage src, int offset)
{
  PImage ret = new PImage(src.width, src.height);
  
  for (int x = 0; x < src.width; x++)
  {
     for (int y = 0; y < src.height; y++)
     {
       color oldColor = src.get(x,y);
       color newColor = color(red(oldColor) + offset, green(oldColor) + offset, blue(oldColor) + offset);
       ret.set(x,y, newColor);
     }
    
  }
  
  return ret;
}