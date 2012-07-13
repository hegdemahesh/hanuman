/**
 * The Hanuman Game V1.0
 * Copyright (c) 2012 Maheshchandra hegde, http://www.hegdemahesh.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.hegdemahesh.ui.components
{
	import com.hegdemahesh.events.LoadLevelEvent;
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
			var bmpFontTF:TextField = new TextField(400, 400, level.levelId.toString(), "Showcard Gothic", 50);
			
			// the native bitmap font size, no scaling
			bmpFontTF.fontSize = 30;
			// use white to use the texture as it is (no tinting)
			bmpFontTF.color = Color.WHITE;
			// centers the text on stage
			bmpFontTF.x = img.width - bmpFontTF.width >> 1;
			bmpFontTF.y = img.height - bmpFontTF.height >> 1;
			// show it
			this.addChild(bmpFontTF);
			bmpFontTF.touchable = false;
			img.addEventListener(starling.events.TouchEvent.TOUCH,onImageTouch);
		}
		
		private function onImageTouch(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			var target:DisplayObject = event.target as DisplayObject;
			
			
			if(event.getTouch(target, TouchPhase.ENDED))
			{
				var ev:LoadLevelEvent =  new LoadLevelEvent(LoadLevelEvent.GET);
				ev.level =  level;
				this.dispatchEvent(ev);
			}
		}
	}
}