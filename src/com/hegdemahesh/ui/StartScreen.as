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
	import com.hegdemahesh.events.ActionButtonEvent;
	import com.hegdemahesh.events.StartScreenChanged;
	import com.hegdemahesh.model.Assets;
	import com.hegdemahesh.ui.components.ActionButton;
	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	public class StartScreen extends starling.display.Sprite
	{
		private var img:Image = new Image(Assets.getAtlas().getTexture('hanumanFront'));
		private var developerImage:Image =  new Image(Assets.getAtlas().getTexture('developedBy'));
		private var startButton:Button =  new Button(Assets.getAtlas().getTexture('startButton'));
		
		private var sky:Image = new Image(Assets.getTexture('bg'));
		
		private var buildings:Image = new Image(Assets.getAtlas().getTexture("buildings"));
		
		private var mParticleSystem:PDParticleSystem;
		
		private var muteButton:ActionButton =  new ActionButton("mute");
		
		private var psConfig:XML = XML(new com.hegdemahesh.model.Assets.FireConfig());
		private var psTexture:Texture = Texture.fromBitmap(new com.hegdemahesh.model.Assets.FireParticle());
		
		private var sound:Sound;
		private var soundChannel:SoundChannel;
		
		/**
		 * A parameter to check the game is muted or not 
		 */
		
		public var isMuted:Boolean = false;
		
		public function StartScreen()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onActionButtonEvent(event:ActionButtonEvent):void
		{
			
			muteAudio();
			
		}
		
		private function addMuteComp():void {
			muteButton =  new ActionButton("mute");
			muteButton.x = 5;
			muteButton.y = 0;
			muteButton.addEventListener(ActionButtonEvent.GET,onActionButtonEvent);
			this.addChild(muteButton);
		}
		
		private function muteAudio():void
		{
			// TODO Auto Generated method stub
			if (isMuted == false){
				isMuted = true;
				muteButton.iconImg.alpha = 0.4;
				SoundMixer.soundTransform = new SoundTransform(0,0);
			}
			else {
				isMuted = false;
				muteButton.iconImg.alpha = 1.0;
				SoundMixer.soundTransform = new SoundTransform(1,0);
			}
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			
			sky.blendMode = starling.display.BlendMode.NONE;
			this.addChild(sky);
			sky.pivotX = 0;
			sky.pivotY = 0;
			sky.scaleY = 1.4;
			
			var bgSprie:flash.display.Sprite = new flash.display.Sprite();
			bgSprie.graphics.beginFill(0x000000,1);
			bgSprie.graphics.drawRect(0,0,100,100);
			bgSprie.graphics.endFill();
			
			var bgData:BitmapData = new BitmapData(100,100,true,0x000000);
			bgData.draw(bgSprie);
			
			var bgTexture:Texture = Texture.fromBitmapData(bgData);
			
			var bgImage:Image =  new Image(bgTexture);
			bgImage.width = stage.stageWidth + 20;
			bgImage.height = 350;
			bgImage.y = 320;
			bgImage.blendMode =  starling.display.BlendMode.NONE;
			
			this.addChild(bgImage);
			
			buildings.y = 112;
			this.addChild(buildings);
			
			mParticleSystem = new PDParticleSystem(psConfig, psTexture);
			mParticleSystem.emitterX = 0;
			mParticleSystem.emitterY = 340;
			mParticleSystem.start();
			this.addChild(mParticleSystem);
			Starling.juggler.add(mParticleSystem);
			
			
			this.addChild(img);
			img.x = int((stage.stageWidth-img.width)/2);
			img.y = 73;
			
			this.addChild(startButton);
			startButton.x = 650;
			startButton.y = 470;
			
			sound =  Assets.getSound("background3");
			soundChannel = sound.play(0,9999);
			
			startButton.addEventListener(starling.events.TouchEvent.TOUCH,onStart);
			
			addMuteComp();
				
		}
		
		public override function dispose():void {
			soundChannel.stop();
			sound = null;
			soundChannel = null;
			super.dispose();
		}
		
		private function onStart(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			
			/*var ev:StartScreenChanged = new StartScreenChanged(StartScreenChanged.GET);
			this.dispatchEvent(ev);*/
			
			var target:DisplayObject = event.target as DisplayObject;
			
			if(event.getTouch(target, TouchPhase.HOVER))
			{
			
			}
			
			if(event.getTouch(target, TouchPhase.MOVED))
			{
				// mouse moving while down
				
			}
			
			if(event.getTouch(target, TouchPhase.BEGAN))
			{
				// mouse down
			}
			else if(event.getTouch(target, TouchPhase.ENDED))
			{
				removeObjects();
				var ev:StartScreenChanged = new StartScreenChanged(StartScreenChanged.GET);
				this.dispatchEvent(ev);
				
			}
			
		}
		
		private function removeObjects():void
		{
			// TODO Auto Generated method stub
			this.removeChild(sky);
			sky = null;
			
			this.removeChild(buildings);
			buildings = null;
			
			this.removeChild(mParticleSystem);
			mParticleSystem = null;
			
			this.removeChild(img);
			img = null;
			
			this.removeChild(startButton);
			startButton.removeEventListener(starling.events.TouchEvent.TOUCH,onStart);
			startButton = null;
		}
	}
}