package com.hegdemahesh.ui
{
	import com.hegdemahesh.events.StartScreenChanged;
	import com.hegdemahesh.model.Assets;
	
	import starling.core.Starling;
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
	
	public class StartScreen extends Sprite
	{
		private var img:Image = new Image(Assets.getAtlas().getTexture('hanumanFront'));
		private var developerImage:Image =  new Image(Assets.getAtlas().getTexture('developedBy'));
		private var startButton:Button =  new Button(Assets.getAtlas().getTexture('startButton'));
		
		private var sky:Image = new Image(Assets.getAtlas().getTexture("sky"));
		
		private var buildings:Image = new Image(Assets.getAtlas().getTexture("buildings"));
		
		private var mParticleSystem:PDParticleSystem;
		
		
		private var psConfig:XML = XML(new com.hegdemahesh.model.Assets.FireConfig());
		private var psTexture:Texture = Texture.fromBitmap(new com.hegdemahesh.model.Assets.FireParticle());
		
		
		
		public function StartScreen()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			
			this.addChild(sky);
			sky.pivotX = 0;
			sky.pivotY = 0;
			sky.scaleY = 1.4;
			
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
			
			
			startButton.addEventListener(starling.events.TouchEvent.TOUCH,onStart);
			
				
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