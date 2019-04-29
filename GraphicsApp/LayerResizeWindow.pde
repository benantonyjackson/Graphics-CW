class LayerResizeWindow extends FloatingWindow
{
	Layer layer;
	Shape shape;

	Slider WidthSlider = null;
	Slider HeightSlider = null;

	LayerResizeWindow(Layer l, Shape s)
	{
		x = 50;
		y = 50;
		w = 500;
		h = 100;
		
		closeButton.x = x+w - 20;
    	closeButton.y =  y;

		layer = l;
		shape = s;

		if (l != null)
		{
			WidthSlider = new Slider(10, 10, 255, 1, l.actImage.width * 4);
			HeightSlider = new Slider(10, 40, 255, 1, l.actImage.height * 4);

			WidthSlider.setValue(l.actImage.width);
			HeightSlider.setValue(l.actImage.height);
		} 
		
		
		//WidthSlider.setValue(l.actImage.width);
		//HeightSlider.setValue(l.actImage.height);

		if (s != null)
		{
			WidthSlider = new Slider(10, 10, 255, 1, s.w * 4);
			HeightSlider = new Slider(10, 40, 255, 1, s.h * 4);

			WidthSlider.setValue(s.w);
			HeightSlider.setValue(s.h);

		}
		else
		{
			println("Big null");
		}
		if (WidthSlider != null)
		add(WidthSlider);
		if (WidthSlider != null)
		add(HeightSlider);

	}

	void mouseReleased()
	{
		super.mouseReleased();

		if(layer != null)
			layer.ResizeLayer((int)WidthSlider.getValue(), (int)HeightSlider.getValue());
		if(shape != null)
			shape.setSize((int)WidthSlider.getValue(), (int)HeightSlider.getValue());

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
			if(shape != null)
			shape.setSize((int)WidthSlider.getValue(), (int)HeightSlider.getValue());
		}
	}


	void draw()
	{
		super.draw();
	}
}