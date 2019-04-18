PImage BlackAndWhite(PImage img)
{
	PImage res = new PImage(img.width, img.height);
	for (int x = 0; x < img.width; x++)
	{
		for (int y = 0; y < img.height; y++)
		{
			color c = img.get(x,y);
			int val = (int)(red(c) + green(c) + blue(c));

			if (val > 384)
			{
				res.set(x,y,color(255,255,255));
			}
			else 
			{
				res.set(x,y,color(0,0,0));
			}
		}
	}
	return res;
}

PImage Greyscale(PImage img)
{
	PImage res = new PImage(img.width, img.height);
	for (int x = 0; x < img.width; x++)
	{
		for (int y = 0; y < img.height; y++)
		{
			color c = img.get(x,y);
			int val = (int)(red(c) + green(c) + blue(c));

			res.set(x,y, color(round(val/3)));
		}
	}
	return res;
}

float[][] edge_matrix = { { 0,  -2,  0 },
                          { -2,  8, -2 },
                          { 0,  -2,  0 } }; 
                     
float[][] blur_matrix = {  {0.1,  0.1,  0.1 },
                           {0.1,  0.1,  0.1 },
                           {0.1,  0.1,  0.1 } };                      

float[][] sharpen_matrix = {  { 0, -1, 0 },
                              {-1, 5, -1 },
                              { 0, -1, 0 } }; 

color convolution(int x, int y, float[][] matrix, int matrixsize, PImage img)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc,0,img.pixels.length-1);
      // Calculate the convolution
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}

PImage Convolute(PImage inputImage, float[][] matrix)
{
	PImage outputImage = createImage(inputImage.width, inputImage.height, RGB);

	int matrixSize = 3;
  	for(int y = 0; y < inputImage.height; y++){
    	for(int x = 0; x < inputImage.width; x++){
    
    	color c = convolution(x, y, matrix, matrixSize, inputImage);
    
    	outputImage.set(x,y,c);
    
    }
  }

  return outputImage;
}