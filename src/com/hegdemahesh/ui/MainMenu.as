package com.hegdemahesh.ui
{
	import com.hegdemahesh.model.Assets;
	import com.hegdemahesh.ui.components.TileSprite;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class MainMenu extends Sprite
	{
		public var levelDetails:XML;
		private var img:Image = new Image(Assets.getAtlas().getTexture('transparentBg'));
		
		private var sound:Sound;
		private var soundChannel:SoundChannel;
		
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
			this.addChild(img);
			img.x = -50;
			img.y = -50;
			img.width = stage.stageWidth+ 100;
			img.height = stage.stageHeight + 100;
			var levelSprite:TileSprite =  new TileSprite(levelDetails,600,400);
			levelSprite.x = int((stage.stageWidth-600)/2);
			levelSprite.y = int((stage.stageHeight-400)/2);
			this.addChild(levelSprite);
			
			addSound();
		}
		public override function dispose():void {
			soundChannel.stop();
			soundChannel = null;
			sound = null;
			super.dispose();
		}
		
		private function addSound():void
		{
			// TODO Auto Generated method stub
			sound = Assets.getSound("background2");
			soundChannel = sound.play(0,9999);
			
		}
	}
}