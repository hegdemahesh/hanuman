package com.hegdemahesh.ui
{
	import com.byxb.extensions.starling.display.CameraSprite;
	
	import flash.geom.Rectangle;
	
	public class World extends CameraSprite
	{
		public function World()
		{
			super(new Rectangle(0, 0, 850, 622), null, .3, .1, .01);
		}
		public function resetLevel():void {
			
		}
		public function loadLevel(levelName:String):void {
			
		}
	}
}