package com.hegdemahesh.ui
{
	import com.hegdemahesh.model.Assets;
	import com.hegdemahesh.model.Constants;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class FireBackground extends Sprite
	{
		public var _contentWidth:int = 850;
		public function FireBackground(contentWidth:int = 0)
		{
			super();
			this._contentWidth = contentWidth;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			for (var i:int = 0; i < _contentWidth; i=i + Constants.FIRE_PIC_WIDTH ){
				var movieClip:MovieClip = new MovieClip(Assets.getAtlas().getTextures("fire"));
				movieClip.x = i;
				movieClip.y = 0;
				movieClip.currentFrame = int(Math.random() * 35);
				movieClip.fps = 25;
				this.addChild(movieClip);
				movieClip.play();
				Starling.juggler.add(movieClip);
				
				
			}
		}
	}
}