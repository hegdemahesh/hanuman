package com.hegdemahesh.ui
{
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
		private var hills:Image;
		private var bg1:Image;
		private var bg2:Image;
		private var bg3:Image;
		private var bg4:Image;
		private var bg5:Image;
		private var buildings:Image;
		
		private var mParticleSystem:PDParticleSystem;
		
		private var psConfig:XML = XML(new Assets.FireConfig());
		private var psTexture:Texture = Texture.fromBitmap(new Assets.FireParticle());
		
		public var _gameXOffest:int = 0;
		
		public function set gameXOffset(offSet:int):void {
			_gameXOffest = offSet;
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
			
			bg1 = new Image(Assets.getAtlas().getTexture("bg1"));
			this.addChild(bg1);
			
			bg2 = new Image(Assets.getAtlas().getTexture("bg2"));
			this.addChild(bg2);
			
			bg3 = new Image(Assets.getAtlas().getTexture("bg3"));
			this.addChild(bg3);
			
			mParticleSystem = new PDParticleSystem(psConfig, psTexture);
			mParticleSystem.emitterX = 0;
			mParticleSystem.emitterY = 420;
			mParticleSystem.start();
			this.addChild(mParticleSystem);
			Starling.juggler.add(mParticleSystem);
			
			buildings = new Image(Assets.getAtlas().getTexture("buildings"));
			buildings.y = 250;
			this.addChild(buildings);
			
			/*var fireFront:PDParticleSystem =  new PDParticleSystem(psConfig, psTexture);
			fireFront.emitterX = 0;
			fireFront.emitterY = 450;
			fireFront.alpha = 0.6;
			fireFront.start();
			this.addChild(fireFront);
			Starling.juggler.add(fireFront);*/
			
			bg4 = new Image(Assets.getAtlas().getTexture("bg4"));
			this.addChild(bg4);
			
			
			
			bg5 = new Image(Assets.getAtlas().getTexture("bg5"));
			this.addChild(bg5);
		}
	}
}