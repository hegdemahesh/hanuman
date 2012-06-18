package com.hegdemahesh.ui
{
	import com.byxb.extensions.starling.display.ParallaxSprite;
	
	import flash.geom.Rectangle;
	
	public class ParallaxBackground extends ParallaxSprite
	{
		public function ParallaxBackground(viewport:Rectangle, parallaxScaleX:Number=1, parallaxScaleY:Number=1)
		{
			super(viewport, parallaxScaleX, parallaxScaleY);
		}
	}
}