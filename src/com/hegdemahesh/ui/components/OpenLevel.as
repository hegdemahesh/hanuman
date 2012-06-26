package com.hegdemahesh.ui.components
{
	import com.hegdemahesh.model.Assets;
	import com.hegdemahesh.vos.Level;
	
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class OpenLevel extends Sprite
	{
		public var level:Level;
		private var img:Button =  new Button(Assets.getAtlas().getTexture('levelButton'));
		
		//private var bitmap:Bitmap = Bitmap(new Assets.ShowCardGothicBitmap());
		public var texture1:Texture =  Assets.getTexture('ShowCardGothicBitmap');
		
		public var xml1:XML = XML(new Assets.ShowCardGothicXML());
		
		
		
		private var bmpFontTF:TextField = new TextField(400, 400, "1", "Showcard Gothic", 50);
		
		public function OpenLevel(lev:Level=null)
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
			
			TextField.registerBitmapFont(new BitmapFont(texture1,xml1));
			// the native bitmap font size, no scaling
			bmpFontTF.fontSize = 30;
			// use white to use the texture as it is (no tinting)
			bmpFontTF.color = Color.WHITE;
			// centers the text on stage
			bmpFontTF.x = img.width - bmpFontTF.width >> 1;
			bmpFontTF.y = img.height - bmpFontTF.height >> 1;
			// show it
			this.addChild(bmpFontTF);
			
			img.addEventListener(starling.events.TouchEvent.TOUCH,onImageTouch);
		}
		
		private function onImageTouch(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			var target:DisplayObject = event.target as DisplayObject;
			
			
			if(event.getTouch(target, TouchPhase.ENDED))
			{
								
			}
		}
	}
}