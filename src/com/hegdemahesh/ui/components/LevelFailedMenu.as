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
	import com.hegdemahesh.events.ActionButtonEvent;
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
	
	public class LevelFailedMenu extends Sprite
	{
		public var bg:Image =  new Image(Assets.getAtlas().getTexture("levelFinish"));
		
		public var texture1:Texture =  Assets.getTexture('ShowCardGothicBitmap');
		
		public var xml1:XML = XML(new Assets.ShowCardGothicXML());
		
		public var level:Level;
		
		public var menuButton:ActionButton =  new ActionButton("menu");
		
		//public var nextButton:ActionButton = new ActionButton("next");
		
		public var replayButton:ActionButton =  new ActionButton("replay");
		
		public function LevelFailedMenu(levelCleared:Level = null)
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
			menuButton.addEventListener(ActionButtonEvent.GET,onActionButtonEvent);
			replayButton.addEventListener(ActionButtonEvent.GET,onActionButtonEvent);
			this.addChild(bg);
			
			TextField.registerBitmapFont(new BitmapFont(texture1,xml1));
			var headerText:TextField = new TextField(350, 50, "Level Failed!", "Showcard Gothic", 50);
			
			// the native bitmap font size, no scaling
			headerText.fontSize = 30;
			// use white to use the texture as it is (no tinting)
			headerText.color = Color.TEAL;
			// centers the text on stage
			headerText.x = bg.width - headerText.width >> 1;
			headerText.y = 15;
			// show it
			this.addChild(headerText);
			
			var yDiff:int = int(bg.height - (menuButton.img.height/2))-20;
			
			menuButton.y = yDiff;
			menuButton.x = 194;
			this.addChild(menuButton);
			
			
			replayButton.y = yDiff;
			replayButton.x = 278;
			this.addChild(replayButton);
			
			
			
			
			//bmpFontTF.touchable = false;
			
		}
		
		private function onActionButtonEvent(event:ActionButtonEvent):void
		{
			// TODO Auto Generated method stub
			var e:ActionButtonEvent =  new ActionButtonEvent(ActionButtonEvent.GET);
			e.actionString =  event.actionString;
			e.level =  level;
			this.dispatchEvent(e);
			//this.removeFromParent(true);
		}
	}
}