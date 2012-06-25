package com.hegdemahesh.ui.components
{
	import com.hegdemahesh.model.Assets;
	import com.hegdemahesh.vos.Level;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class OpenLevel extends Sprite
	{
		public var level:Level;
		private var img:Image = new Image(Assets.getAtlas().getTexture('levelButton'));
		public function OpenLevel(lev:Level=null)
		{
			super();
			if (lev != null){
				level =  lev;
				this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
			}
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			this.addChild(img);
			img.addEventListener(starling.events.TouchEvent.TOUCH,onImageTouch);
		}
		
		private function onImageTouch(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			var target:DisplayObject = event.target as DisplayObject;
			
			
			if(event.getTouch(target, TouchPhase.ENDED))
			{
								
			}
		}
	}
}