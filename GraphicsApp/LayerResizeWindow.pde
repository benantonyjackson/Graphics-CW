class LayerResizeWindow extends FloatingWindow
{
	Layer layer;

	Slider WidthSlider = null;
	Slider HeightSlider = null;

	LayerResizeWindow(Layer l)
	{
		x = 50;
		y = 50;
		w = 400;
		h = 400;
		
		closeButton.x = x+w - 20;
    	closeButton.y =  y;

		layer = l;

		WidthSlider = new Slider(10, 290, 255, 1, l.actImage.width * 4);
		HeightSlider = new Slider(10, 320, 255, 1, l.actImage.height * 4);
		
		WidthSlider.setValue(l.actImage.width);
		HeightSlider.setValue(l.actImage.height);

		add(WidthSlider);
		add(HeightSlider);

	}

	void mouseReleased()
	{
		super.mouseReleased();

		if(layer != null)
			layer.ResizeLayer((int)WidthSlider.getValue(), (int)HeightSlider.getValue());

	}

	void mouseDragged()
	{
		int oldX = x;
		int oldY = y;
		super.mouseDragged();
		if (oldX == x && oldY == y)
		{
			if(layer != null)
			layer.ResizeLayer((int)WidthSlider.getValue(), (int)HeightSlider.getValue());
		}
	}


	void draw()
	{
		super.draw();
	}
}