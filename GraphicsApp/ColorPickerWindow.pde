class ColorPickerWindow extends FloatingWindow
{
	private PImage colorChart;
	private Slider bSlider;
	private int chartSize = 255;
	ColorPickerWindow()
	{
		x = 50;
		y = 50;
		w = 400;
		h = 400;

		bSlider = new Slider(10, 350, 255, 0, 255);
		add(bSlider);

		closeButton.x = x+w - 20;
    	closeButton.y =  y;
    	colorChart = new PImage(chartSize, chartSize);
    	setCharColor();

	}

	private void setCharColor()
	{
		for (int x = 0; x < chartSize; x ++)
    	{
    		for (int y = 0; y < chartSize; y++)
    		{
    			colorChart.set(x, y, color(x, y, bSlider.getValue()));

    		}
    	}
	}

	void mouseDragged()
	{
		super.mouseDragged();
		setCharColor();
	}

	void mousePressed()
	{
		super.mousePressed();
		setCharColor();
	}

	void draw()
	{
		super.draw();
		image(colorChart, x + 10, y + 30);
	}
}