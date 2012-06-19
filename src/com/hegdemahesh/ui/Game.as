package com.hegdemahesh.ui
{
	
	import com.hegdemahesh.events.ChangeBackgroundOffset;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class Game extends Sprite
	{
		private var levelScreen:LevelLoader;
		private var bg:Background;
		
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			
			bg =  new Background();
			this.addChild(bg);
			levelScreen = new LevelLoader();
			this.addChild(levelScreen);
			this.addEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
			levelScreen.addEventListener(ChangeBackgroundOffset.GET,onOffestChange);
		}	
		
		private function onOffestChange(event:ChangeBackgroundOffset):void
		{
			// TODO Auto Generated method stub
			bg.gameXOffset = event.globalXOffset;
		}
		
		private function onEnterFrame():void
		{
			
			
		}
	}
}