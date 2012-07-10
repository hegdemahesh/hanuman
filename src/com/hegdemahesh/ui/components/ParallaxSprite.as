package com.hegdemahesh.ui.components
{
	import com.hegdemahesh.model.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ParallaxSprite extends Sprite
	{
		private var _gameXOffset:int;
		
		private var imageWidth:int;
		public function ParallaxSprite()
		{
			super();
			
		}
		
		public function addParallaxImage(imgURL:String,top:int):void {
			//var image:Image = Assets.getAtlas().getTexture(
			var img:Image =  new Image(Assets.getAtlas().getTexture(imgURL));
			img.addEventListener(starling.events.Event.COMPLETE,onImageLoaded);
		}
		
		public function onImageLoaded(event:Event):void
		{
			// TODO Auto Generated method stub
			trace("image Loaded");
		}
		
		public function set gameXOffset(gamex:int):void {
			_gameXOffset = gamex;
		}
		public function get gameXOffset():int {
			return _gameXOffset;
		}
	}
}