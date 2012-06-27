package com.hegdemahesh.ui.components
{
	import com.hegdemahesh.model.Assets;
	import com.hegdemahesh.vos.Level;
	
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class LevelClearedMenu extends Sprite
	{
		public var bg:Image =  new Image(Assets.getAtlas().getTexture("levelFinish"));
		
		public var texture1:Texture =  Assets.getTexture('ShowCardGothicBitmap');
		
		public var xml1:XML = XML(new Assets.ShowCardGothicXML());
		
		public var level:Level = new Level();
		
		public function LevelClearedMenu(levelCleared:Level = null)
		{
			super();
			if (levelCleared != null){
				level = levelCleared;
			}
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			this.addChild(bg);
			TextField.registerBitmapFont(new BitmapFont(texture1,xml1));
			var headerText:TextField = new TextField(350, 50, "Level Complete!", "Showcard Gothic", 50);
			
			// the native bitmap font size, no scaling
			headerText.fontSize = 30;
			// use white to use the texture as it is (no tinting)
			headerText.color = Color.TEAL;
			// centers the text on stage
			headerText.x = bg.width - headerText.width >> 1;
			headerText.y = 15;
			// show it
			this.addChild(headerText);
			//bmpFontTF.touchable = false;
				
		}
	}
}