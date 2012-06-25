package com.hegdemahesh.ui
{
	import com.hegdemahesh.model.Assets;
	import com.hegdemahesh.ui.components.TileSprite;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class MainMenu extends Sprite
	{
		public var levelDetails:XML;
		public function MainMenu(levelXML:XML=null)
		{
			super();
			if (levelXML != null){
				this.levelDetails = levelXML;
				this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
			}
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			var levelSprite:TileSprite =  new TileSprite(levelDetails,600,400);
			this.addChild(levelSprite);
		}
	}
}