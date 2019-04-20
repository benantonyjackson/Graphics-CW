class ColorPickerWindow extends FloatingWindow
{
	private PImage colorChart;
	private Slider rSlider;
	private Slider gSlider;
	private Slider bSlider;
	private int chartSize = 255;
	private Button confirmButton = null;

	ColorSelector selector = null;
	ColorPickerWindow(ColorSelector sel)
	{
		x = 50;
		y = 50;
		w = 400;
		h = 400;

		rSlider = new Slider(10, 290, 255, 0, 255);
		gSlider = new Slider(10, 320, 255, 0, 255);
		bSlider = new Slider(10, 350, 255, 0, 255);

		add(rSlider);
		add(gSlider);
		add(bSlider);

		closeButton.x = x+w - 20;
    	closeButton.y =  y;
    	colorChart = new PImage(chartSize, chartSize);
    	setCharColor();

    	selector = sel;

    	confirmButton = new Button("Confirm", 320, 300, 50, 25);

    	add(confirmButton);

	}

	private void setCharColor()
	{
		for (int x = 0; x < chartSize; x ++)
    	{
    		for (int y = 0; y < chartSize; y++)
    		{
    			colorChart.set(x, y, color(rSlider.getValue() ,gSlider.getValue() ,bSlider.getValue()));
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

	void mouseReleased()
	{
		super.mouseReleased();

		if (confirmButton.wasClicked)
		{
			closed=true;

			if(selector != null)
			{
				selector.selectedColor = color(rSlider.getValue() ,gSlider.getValue() ,bSlider.getValue());
			}
			
		}
	}

	void draw()
	{
		super.draw();



		image(colorChart, x + 10, y + 30);
	}
}