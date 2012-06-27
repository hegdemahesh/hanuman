package com.hegdemahesh.ui.components
{
	import com.hegdemahesh.events.ActionButtonEvent;
	import com.hegdemahesh.model.Assets;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ActionButton extends Sprite
	{
		public var img:Button =  new Button(Assets.getAtlas().getTexture('buttonBg'));
		private var iconImg:Image ;
		private var iconURL:String;
		public function ActionButton(iconImgURL:String =  "")
		{
			super();
			if (iconImgURL!= ""){
				this.iconImg =  new Image(Assets.getAtlas().getTexture(iconImgURL));
				this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
				this.iconURL = iconImgURL;
			}
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			this.addChild(img);
			this.addChild(iconImg);
			iconImg.touchable = false;
			iconImg.x = (img.width-iconImg.width)/2;
			iconImg.y = (img.height-iconImg.height)/2;
			this.addEventListener(starling.events.TouchEvent.TOUCH,onTouch);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			var target:DisplayObject = event.target as DisplayObject;
			
			
			if(event.getTouch(target, TouchPhase.ENDED))
			{
				var ev:ActionButtonEvent =  new ActionButtonEvent(ActionButtonEvent.GET);
				ev.actionString = iconURL;
				this.dispatchEvent(ev);
				//this.removeFromParent(true);
				
			}
		}
	}
}