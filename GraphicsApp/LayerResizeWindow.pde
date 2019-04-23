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

		WidthSlider = new Slider(10, 290, 255, 1, 2000);
		HeightSlider = new Slider(10, 320, 255, 1, 2000);
		
		add(WidthSlider);
		add(HeightSlider);

	}


	void draw()
	{
		super.draw();

		if(layer != null)
		layer.ResizeLayer((int)WidthSlider.getValue(), (int)HeightSlider.getValue());
	}
}