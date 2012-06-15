package com.hegdemahesh.ui
{
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class Game extends Sprite
	{
		private var levelScreen:LevelLoader;
		public var gameXOffset:int = 0;
		private var bg:Background;
		
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			/*trace("starling framework intialised");
			welcomeScreen =  new Welcome();
			this.addChild(welcomeScreen);*/
			bg =  new Background();
			this.addChild(bg);
			levelScreen = new LevelLoader();
			this.addChild(levelScreen);
			this.addEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
			//this.addEventListener(starling.events
		}	
		
		private function onEnterFrame():void
		{
			// TODO Auto Generated method stub
			if (gameXOffset != levelScreen.x){
				levelScreen.x = gameXOffset;
			}
			if (bg.gameXOffset != gameXOffset){
				bg.gameXOffset == this.gameXOffset;
			}
			
		}
	}
}