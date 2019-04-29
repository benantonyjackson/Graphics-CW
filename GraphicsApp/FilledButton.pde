class FilledButton extends Button
{
	FilledButton(String s, int x, int y, int w, int h)
  	{
    	text = s;
    
	    this.x = x;
	    this.y = y;
	    this.w = w;
	    this.h = h;
    
  	}


	void WidgetClickEvent()
	{
		if (canvas != null)
		{
			if (canvas.layerIndex > -1)
			{
				Layer l = canvas.layers.get(canvas.layerIndex);

				if (l.selectedShape != null)
				{
					l.selectedShape.setFilled(toggled);
				}
			}
		}
	}
}