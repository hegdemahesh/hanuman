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
			levelSprite.x = int((stage.stageWidth-600)/2)-30;
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
			sound = Assets.getSound("background1");
			soundChannel = sound.play(0,9999);
			
		}
	}
}