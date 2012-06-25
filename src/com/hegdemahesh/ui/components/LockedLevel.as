package com.hegdemahesh.ui.components
{
	import com.hegdemahesh.model.Assets;
	import com.hegdemahesh.vos.Level;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class LockedLevel extends Sprite
	{
		public var level:Level;
		private var img:Image = new Image(Assets.getAtlas().getTexture('levelButtonLocked'));
		public function LockedLevel(lev:Level=null)
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
		}
	}
}