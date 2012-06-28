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
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	public class Background extends Sprite
	{
		private var sky:Image;
		private var skyCopy:Image;
		private var hills:Image;
		private var bg1:Image;
		private var bg2:Image;
		private var bg3:Image;
		private var bg4:Image;
		private var bg5:Image;
		private var buildings:Image;
		
		//private var mParticleSystem:PDParticleSystem;
		
		private var hillsCopy:Image;
		private var bg1Copy:Image;
		private var bg2Copy:Image;
		private var bg3Copy:Image;
		private var bg4Copy:Image;
		private var bg5Copy:Image;
		private var buildingsCopy:Image;
		
		private var fireBg:FireBackground;
		
		//private var mParticleSystemCopy:PDParticleSystem;
		
		
		//private var psConfig:XML = XML(new com.hegdemahesh.model.Assets.FireConfig());
		//private var psTexture:Texture = Texture.fromBitmap(new com.hegdemahesh.model.Assets.FireParticle());
		
		public var _gameXOffest:int = 0;
		
		public var parallaxOffSet:int = 850;
		
		public function set gameXOffset(offSet:int):void {
			if (_gameXOffest != offSet){
				_gameXOffest = offSet;
				bg5.x = int(offSet);
				bg4.x = int(offSet/1.2);
				buildings.x = int(offSet/1.5);
				//mParticleSystem.x = int(offSet/1.5);
				bg3.x = int(offSet/3);
				bg2.x = int(offSet/5);
				bg1.x = int(offSet/8);
				hills.x = int(offSet/16);
				
				fireBg.x = int(offSet/1.5);
				
				bg5Copy.x = parallaxOffSet+int(offSet);
				bg4Copy.x = parallaxOffSet+int(offSet/1.2);
				buildingsCopy.x = parallaxOffSet+int(offSet/1.5);
				//mParticleSystemCopy.x = parallaxOffSet+int(offSet/1.5);
				bg3Copy.x = parallaxOffSet+int(offSet/3);
				bg2Copy.x = parallaxOffSet+int(offSet/5);
				bg1Copy.x = parallaxOffSet+int(offSet/8);
				hillsCopy.x = parallaxOffSet+int(offSet/16);
			}
			
		}
		
		public function get gameXOffset():int {
			return _gameXOffest;
		}
		public function Background()
		{
			
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			// TODO Auto Generated method stub
			sky = new Image(Assets.getAtlas().getTexture("sky"));
			this.addChild(sky);
			
			hills = new Image(Assets.getAtlas().getTexture("hills"));
			this.addChild(hills);
			
			hillsCopy = new Image(Assets.getAtlas().getTexture("hills"));
			this.addChild(hillsCopy);
			hillsCopy.x = parallaxOffSet;
			
			bg1 = new Image(Assets.getAtlas().getTexture("bg1"));
			this.addChild(bg1);
			
			bg1Copy = new Image(Assets.getAtlas().getTexture("bg1"));
			this.addChild(bg1Copy);
			bg1Copy.x = parallaxOffSet;
			
			bg2 = new Image(Assets.getAtlas().getTexture("bg2"));
			this.addChild(bg2);
			
			bg2Copy = new Image(Assets.getAtlas().getTexture("bg2"));
			this.addChild(bg2Copy);
			bg2Copy.x = parallaxOffSet;
			
			bg3 = new Image(Assets.getAtlas().getTexture("bg3"));
			this.addChild(bg3);
			
			bg3Copy = new Image(Assets.getAtlas().getTexture("bg3"));
			this.addChild(bg3Copy);
			bg3Copy.x = parallaxOffSet;
			
			/*mParticleSystem = new PDParticleSystem(psConfig, psTexture);
			mParticleSystem.emitterX = 0;
			mParticleSystem.emitterY = 440;
			mParticleSystem.start();
			this.addChild(mParticleSystem);
			Starling.juggler.add(mParticleSystem);*/
			
			/*mParticleSystemCopy = new PDParticleSystem(psConfig, psTexture);
			mParticleSystemCopy.emitterX = 0;
			mParticleSystemCopy.emitterY = 440;
			mParticleSystemCopy.start();
			this.addChild(mParticleSystemCopy);
			Starling.juggler.add(mParticleSystemCopy);
			mParticleSystemCopy.x = parallaxOffSet;*/
			
			fireBg =  new FireBackground(1700);
			fireBg.y = 280;
			this.addChild(fireBg);
			
			buildings = new Image(Assets.getAtlas().getTexture("buildings"));
			buildings.y = 250;
			this.addChild(buildings);
			
			buildingsCopy = new Image(Assets.getAtlas().getTexture("buildings"));
			buildingsCopy.y = 250;
			buildingsCopy.x = parallaxOffSet;
			this.addChild(buildingsCopy);
			
			/*var fireFront:PDParticleSystem =  new PDParticleSystem(psConfig, psTexture);
			fireFront.emitterX = 0;
			fireFront.emitterY = 450;
			fireFront.alpha = 0.6;
			fireFront.start();
			this.addChild(fireFront);
			Starling.juggler.add(fireFront);*/
			
			bg4 = new Image(Assets.getAtlas().getTexture("bg4"));
			this.addChild(bg4);
			
			bg4Copy = new Image(Assets.getAtlas().getTexture("bg4"));
			this.addChild(bg4Copy);
			bg4Copy.x = parallaxOffSet;
			
			bg5 = new Image(Assets.getAtlas().getTexture("bg5"));
			this.addChild(bg5);
			
			bg5Copy = new Image(Assets.getAtlas().getTexture("bg5"));
			this.addChild(bg5Copy);
			bg5Copy.x = parallaxOffSet;
		}
	}
}