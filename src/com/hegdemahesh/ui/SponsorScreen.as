package com.hegdemahesh.ui
{
	import com.hegdemahesh.events.SponsorScreenChanged;
	import com.hegdemahesh.model.Assets;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.utils.deg2rad;
	
	public class SponsorScreen extends Sprite
	{
		private var img:Image = new Image(Assets.getAtlas().getTexture('innoBrik'));
		private var developerImage:Image =  new Image(Assets.getAtlas().getTexture('developedBy'));
		
		public function SponsorScreen()
		{
			
			super();
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			developerImage.x = int((stage.stageWidth-img.width)/2)+ 80;
			//developerImage.y = ((stage.stageHeight-img.height)/2);
			developerImage.y = 0;
			this.addChild(developerImage);
			//developerImage.addEventListener(starling.events.Event.ADDED_TO_STAGE,onDeveloperImageAddedToStage);
			
			
			img.x = int((stage.stageWidth-img.width)/2);
			img.y = int((stage.stageHeight-img.height)/2);
			img.alpha = 0;
			this.addChild(img);
			//img.addEventListener(starling.events.Event.ADDED_TO_STAGE,onImgAddedToStage);
			
			addEffects();
		}
		
		private function onImgAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			animateLogo();
		}
		
		private function onDeveloperImageAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			animateText();
		}
		
		private function animateLogo():void {
			var tween:Tween = new Tween(img, 3.0, Transitions.EASE_IN_OUT);
			tween.animate("alpha", 1);
			//tween.animate("rotation", deg2rad(45));
			//tween.fadeTo(0);    // equivalent to 'animate("alpha", 0)'
			Starling.juggler.add(tween);
			
		}
		private function animateText():void {
			var tween:Tween = new Tween(developerImage, 3.0, Transitions.EASE_IN_OUT);
			tween.animate("y", 250);
			Starling.juggler.add(tween);
			tween.onComplete = onTweenComplete;
		}
		
		private function onTweenComplete():void
		{
			// TODO Auto Generated method stub
			//return null;
			var event:SponsorScreenChanged =  new SponsorScreenChanged(SponsorScreenChanged.GET);
			this.dispatchEvent(event);
			this.removeChild(img);
			this.removeChild(developerImage);
			img = null;
			developerImage = null;
			
		}
		
		private function addEffects():void
		{
			// TODO Auto Generated method stub
			animateLogo();
			animateText();
		}
	}
}