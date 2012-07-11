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
		private var imageHeight:int;
		private var parallaxX:Number;
		private var topMargin:int;
		private var imageURL:String;
		
		public function ParallaxSprite(imgURL:String,top:int,parallaxRatio:Number = 0)
		{
			super();
			parallaxX = parallaxRatio;
			imageWidth = Assets.getAtlas().getTexture(imgURL).width;
			imageHeight = Assets.getAtlas().getTexture(imgURL).height;
			topMargin = top;
			imageURL = imgURL;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			addParallaxImage();
		}
		
		public function addParallaxImage():void {
			//var image:Image = Assets.getAtlas().getTexture(
			
			//var img:Image =  new Image(Assets.getAtlas().getTexture(imgURL));
			//img.addEventListener(starling.events.Event.COMPLETE,onImageLoaded);
			var imgWidthTemp:int = 0;
			while (imgWidthTemp < (stage.stageWidth + imageWidth)){
				var img:Image =  new Image(Assets.getAtlas().getTexture(imageURL));
				img.y = topMargin;
				img.x = imgWidthTemp;
				this.addChild(img);
				imgWidthTemp = imgWidthTemp + imageWidth;
			}
		}
		
		public function onImageLoaded(event:Event):void
		{
			// TODO Auto Generated method stub
			trace("image Loaded");
		}
		
		public function set gameXOffset(gameX:int):void {
			if (parallaxX != 0){
				gameX = int(gameX / parallaxX);
				while (gameX < (-imageWidth)){
					gameX = gameX + imageWidth;
				}
			}
			else {
				gameX = 0;
			}
			if (this.x != gameX){
				this.x = gameX;
			}
			_gameXOffset = gameX;
		}
		public function get gameXOffset():int {
			return _gameXOffset;
		}
	}
}