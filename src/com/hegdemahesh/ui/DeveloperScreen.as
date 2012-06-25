package com.hegdemahesh.ui
{
	import com.hegdemahesh.events.DeveloperScreenChanged;
	import com.hegdemahesh.model.Assets;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class DeveloperScreen extends Sprite
	{
		private var img:Image = new Image(Assets.getAtlas().getTexture('hegdeLogo'));
		private var devImg:Image = new Image(Assets.getAtlas().getTexture('hegdemahesh'));
		private var textImage:Image = new Image(Assets.getAtlas().getTexture('programmedBy'));
		
		public function DeveloperScreen()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,OnAddedToStage);
		}
		
		private function OnAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			img.x = int((stage.stageWidth - img.width)/2);
			img.y = int((stage.stageHeight - img.height)/2);
			img.alpha = 0;
			this.addChild(img);
			
			//devImg.x = int((stage.stageWidth - devImg.width)/2);
			devImg.y = int((stage.stageHeight - devImg.height)/2)+150;
			devImg.x = int((stage.stageWidth-devImg.width)/2);
			devImg.alpha = 0;
			this.addChild(devImg);
			
			textImage.x = int((stage.stageWidth - textImage.width)/2);
			textImage.y = 160;
			textImage.alpha = 0;
			this.addChild(textImage);
			addEffects();
		}
		
		private function addEffects():void
		{
			// TODO Auto Generated method stub
			var tween:Tween = new Tween(img,3.0,Transitions.EASE_IN_OUT);
			tween.animate("alpha",1);
			Starling.juggler.add(tween);
			
			
			var tween1:Tween = new Tween(devImg,3.0,Transitions.EASE_IN_OUT);
			tween1.animate("alpha",1);
			Starling.juggler.add(tween1);
			
			var tween2:Tween = new Tween(textImage,3.0,Transitions.EASE_IN_OUT);
			tween2.animate("alpha",.7);
			Starling.juggler.add(tween2);
			
			tween1.onComplete = onTweenComplete;
		}
		
		private function onTweenComplete():void
		{
			// TODO Auto Generated method stub
			var event:DeveloperScreenChanged = new DeveloperScreenChanged(DeveloperScreenChanged.GET);
			this.dispatchEvent(event);
		}
	}
}