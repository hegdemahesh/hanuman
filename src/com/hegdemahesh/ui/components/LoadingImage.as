package com.hegdemahesh.ui.components
{
	import flash.display.Sprite;
	
	public class LoadingImage extends Sprite
	{
		public function LoadingImage()
		{
			this.graphics.beginFill(0x345689,1);
			this.graphics.drawRect(0,180,50,50);
			this.graphics.endFill();
			super();
		}
	}
}