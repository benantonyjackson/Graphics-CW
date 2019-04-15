
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