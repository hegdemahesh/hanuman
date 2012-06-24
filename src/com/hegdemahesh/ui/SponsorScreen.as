package com.hegdemahesh.ui
{
	import com.hegdemahesh.model.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class SponsorScreen extends Sprite
	{
		private var img:Image = new Image(Assets.getAtlas().getTexture('sponsor_logo'));
		public function SponsorScreen()
		{
			
			super();
			this.addChild(img);
			img.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			addEffects();
		}
		
		private function addEffects():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}