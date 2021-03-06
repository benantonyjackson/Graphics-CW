class ColorSelector extends Widget
{

	color selectedColor = color(255,2,2);
	ColorSelector(int x, int y)
	{
		w = 20;
		h = 20;
		this.x=x;
		this.y=y;
	}

	void draw()
	{
		stroke(selectedColor);
		fill(selectedColor);
		rect(x,y,w,h);
		stroke(0);
	}

	void mouseReleased()
	{
		super.mouseReleased();
		if (wasClicked)
		{
			PickColor(this, (int)red(selectedColor), (int)green(selectedColor), (int)blue(selectedColor));
		}

	}

}