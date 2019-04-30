class RotateWindow extends FloatingWindow
{
	Layer layer;
	Shape shape;

	Slider rotateSlider = null;

	RotateWindow(Layer l, Shape s)
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
			rotateSlider = new Slider(10, 10, 255, 0, 360);

			rotateSlider.setValue(l.getRotation());
		} 
		
		
		//WidthSlider.setValue(l.actImage.width);
		//HeightSlider.setValue(l.actImage.height);

		if (s != null)
		{
			rotateSlider = new Slider(10, 10, 255, 0, 360);

			rotateSlider.setValue(s.getRotation());

		}
		
		if (rotateSlider != null)
		add(rotateSlider);
		else 
			closed = true;
	}

	void mouseReleased()
	{
		super.mouseReleased();

		if(layer != null)
			layer.setRotation((int)rotateSlider.getValue());
		if(shape != null)
			shape.setRotation((int)rotateSlider.getValue());

	}

	void mouseDragged()
	{
		int oldX = x;
		int oldY = y;
		super.mouseDragged();
		if (oldX == x && oldY == y)
		{
			if(layer != null)
			layer.setRotation((int)rotateSlider.getValue());
			if(shape != null)
			shape.setRotation((int)rotateSlider.getValue());
		}
	}


	void draw()
	{
		super.draw();
	}

} 