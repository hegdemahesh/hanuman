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
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
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
		
		private var img:Image = new Image(Assets.getAtlas().getTexture('transparentBg'));
		
		public var texture1:Texture =  Assets.getTexture('ShowCardGothicBitmap');
		
		public var xml1:XML = XML(new Assets.ShowCardGothicXML());
		
		public var level:Level = new Level();
		
		public var menuButton:ActionButton =  new ActionButton("menu");
		
		public var nextButton:ActionButton = new ActionButton("next");
		
		public var replayButton:ActionButton =  new ActionButton("replay");
		
		public var nextLevelValidated:Boolean =  false;
		
		public var _score:int = 0;
		
		public var scoreText:TextField;
		
		public var sound:Sound;
		
		public var soundChannel:SoundChannel;
		
		public function LevelClearedMenu(levelCleared:Level = null,levelValidate:Boolean = false,sc:int= 0)
		{
			super();
			if (levelCleared != null){
				level = levelCleared;
			}
			nextLevelValidated =  levelValidate;
			score = sc;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		public function set score(sc:int):void {
			_score = sc;
			//scoreText.text = "score - " + sc.toString();
		}
		
		public function get score():int {
			return _score;
		}
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			this.addChild(img);
			img.x = -50;
			img.y = -50;
			img.width = stage.stageWidth+ 100;
			img.height = stage.stageHeight + 100;
			
			menuButton.addEventListener(ActionButtonEvent.GET,onActionButtonEvent);
			replayButton.addEventListener(ActionButtonEvent.GET,onActionButtonEvent);
			nextButton.addEventListener(ActionButtonEvent.GET,onActionButtonEvent);
			
			var xT:int = int((stage.stageWidth - bg.width)/2);
			var yT:int = int((stage.stageHeight - bg.height)/2);
			
			bg.x = xT;
			bg.y = yT;
			this.addChild(bg);
			
			TextField.registerBitmapFont(new BitmapFont(texture1,xml1));
			var headerText:TextField = new TextField(350, 50, "Level Complete!", "Showcard Gothic", 50);
			
			scoreText =  new TextField(350,50,"Score - "+score.toString(),"Showcard Gothic" , 50);
			
			scoreText.fontSize = 30;
			scoreText.color = Color.MAROON;
			
			scoreText.x = xT+ (bg.width - headerText.width >> 1);
			scoreText.y = yT+85;
			this.addChild(scoreText)
			
			var yDiff:int = int(bg.height - (menuButton.img.height/2))-20;
			
			
			if(nextLevelValidated == false){
				headerText.text = "Game Complete!";
				menuButton.x = xT+194;
				
				replayButton.x = xT+278;
			}
			
			else {
				menuButton.x = xT+110;
				
				replayButton.x = xT+194;
				
				nextButton.y = yT+yDiff;
				nextButton.x = xT+278;
				this.addChild(nextButton);
			}
			
			menuButton.y =yT+ yDiff;
			
			this.addChild(menuButton);
			
			
			replayButton.y = yT+yDiff;
			
			this.addChild(replayButton);
			
			// the native bitmap font size, no scaling
			headerText.fontSize = 30;
			// use white to use the texture as it is (no tinting)
			headerText.color = Color.TEAL;
			// centers the text on stage
			headerText.x = xT+ (bg.width - headerText.width >> 1);
			headerText.y = yT+15;
			// show it
			this.addChild(headerText);
			
			//bmpFontTF.touchable = false;
			
			startSound();	
		}
		
		private function startSound():void
		{
			// TODO Auto Generated method stub
			sound = Assets.getSound("background2");
			soundChannel = sound.play(0,2);
		}
		public override function dispose():void {
			
			soundChannel.stop();
			sound = null;
			super.dispose();
		}
		
		private function onActionButtonEvent(event:ActionButtonEvent):void
		{
			// TODO Auto Generated method stub
			var e:ActionButtonEvent =  new ActionButtonEvent(ActionButtonEvent.GET);
			e.actionString =  event.actionString;
			e.level = level;
			this.dispatchEvent(e);
			//this.removeFromParent(true);
		}
	}
}