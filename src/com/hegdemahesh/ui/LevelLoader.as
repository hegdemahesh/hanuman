package com.hegdemahesh.ui
{
	
	import com.hegdemahesh.events.WeaponReleased;
	
	import nape.constraint.AngleJoint;
	import nape.constraint.PivotJoint;
	import nape.constraint.WeldJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	public class LevelLoader extends Sprite
	{
		
		
		
		private var space:Space;
		
		private var crushNumber:Number = 50;
		
		private var ground:Body;
		private var groundXOffset:int = 400;
		private var groundYOffest:int = 491;
		
		private var mParticleSystem:PDParticleSystem;
		
		private var psConfig:XML = XML(new Assets.SunConfig());
		private var psTexture:Texture = Texture.fromBitmap(new Assets.SunParticle());
		
		private var hanumanTail:Actor = new Actor("tail");
		
		private var debug:BitmapDebug;
		
		private var mouseDown:Boolean =  false;
		private var weapon:Actor;
		
		
		public function LevelLoader()
		{
			super();
			
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
			mParticleSystem = new PDParticleSystem(psConfig, psTexture);
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			
			space = new Space(new Vec2(0,2000));
			
			/*Add ground to the physics world*/
			ground = new Body(BodyType.STATIC);
			ground.shapes.add(new Polygon(Polygon.rect(0,groundYOffest,1700,20)));
			ground.space = space;
			
			/*Add our hero hanuman to the stage*/
			var hanuman:MovieClip =  new MovieClip(Assets.getAtlas().getTextures("hanuman_"),24);
			hanuman.x = 100;
			hanuman.y = 220;
			this.addChild(hanuman);
			hanuman.play();
			Starling.juggler.add(hanuman);
			
			/*Extract level related information*/
			extractActors();
			
			addCatapult();
			
			/*Add Actor Effects*/
			this.addChild(mParticleSystem);
			Starling.juggler.add(mParticleSystem);
			
			this.addEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
			//this.addEventListener(WeaponReleased.GET,onWeaponReleased);
			
			debug = new BitmapDebug(stage.stageWidth,stage.stageHeight,0x333333,true);
			Starling.current.nativeOverlay.addChild(debug.display);
			
			
		}
		
		/*private function onWeaponReleased(event:WeaponReleased):void
		{
			trace(event.xSpeed+ 'weapon relased');
		}		
		*/
		
		private function addCatapult():void {
			
			
			
			var material:Material = new Material(.8);
			material.density = 10;
			
			weapon = new Actor("stone_throw");
			weapon.x = 124+ int(weapon.image.width/2);
			weapon.y = 148 + int(weapon.image.height/2);
			weapon.addEventListener(starling.events.TouchEvent.TOUCH,onStoneTouch);
			this.addChild(weapon);
			
			/*var weaponRelease:Weapon = new Weapon("stone_throw");
			weaponRelease.x = 124+ 18;
			weaponRelease.y = 148 + 18;
			this.addChild(weaponRelease);*/
			
			hanumanTail.x = 94+ int(hanumanTail.image.width/2);
			hanumanTail.y = 143+ int(hanumanTail.image.height/2);
			hanumanTail.pivotX = 81;
			hanumanTail.pivotY = 120;
			this.addChild(hanumanTail);
			
		}
		
		public function moveWeapon(mouseX:int,mouseY:int):void {
			if (mouseDown == true){
				
			}
		}
		public function releaseWeapon():void {
			
		}
		private function onStoneTouch(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			
			var target:DisplayObject = event.target as DisplayObject;
			var mouseX:int;
			var mouseY:int;
			trace("Mouse interaceted");
			
			if(event.getTouch(target, TouchPhase.HOVER))
			{
				// mouse moving while up
				mouseX = event.getTouch(target, TouchPhase.HOVER).globalX;
				mouseY = event.getTouch(target, TouchPhase.HOVER).globalY;
				moveWeapon(mouseX,mouseY);
			}
			
			if(event.getTouch(target, TouchPhase.MOVED))
			{
				// mouse moving while down
				mouseX = event.getTouch(target, TouchPhase.MOVED).globalX;
				mouseY = event.getTouch(target, TouchPhase.MOVED).globalY;
				moveWeapon(mouseX,mouseY);
			}
			
			if(event.getTouch(target, TouchPhase.BEGAN)&&!mouseDown)
			{
				// mouse down
				mouseDown = true;
				mouseX = event.getTouch(target, TouchPhase.BEGAN).globalX;
				mouseY = event.getTouch(target, TouchPhase.BEGAN).globalY;
				moveWeapon(mouseX,mouseY);
				
			}
			else if(event.getTouch(target, TouchPhase.ENDED)&&mouseDown)
			{
				mouseDown = false;
				releaseWeapon();
			}
			
			
		}
		
		
		
		
		private function extractActors():void {
			/*function to extract level related information from a local xml*/
			var xml:XML = XML(new Assets.level1XML());
			for (var i:int = 0; i < xml.actor.length();i ++ ){
				var actor:Actor =  new Actor(xml.actor[i].name);
				actor.idString = xml.actor[i].id;
				actor.material = xml.actor[i].material;
				actor.xcord = xml.actor[i].xcord;
				actor.ycord = xml.actor[i].ycord;
				actor.flammable = (xml.actor[i].flammable == 1)? true: false;
				actor.x = groundXOffset + int(xml.actor[i].xcord)-int(Math.ceil(actor.image.width/2));
				actor.y = groundYOffest - int(xml.actor[i].ycord)-int(Math.ceil(actor.image.height/2));
				actor.crushable = (xml.actor[i].crushable == 1)? true: false;
				
				var material:Material = new Material();
				
				if (actor.material == "stone"){
					
					material = Material.steel();
				}
				else if (actor.material == "foundation"){
					
					material = Material.steel();
				}
				else if (actor.material == "wood"){
					
					material = Material.wood();
				}
				else if (actor.material == "gold"){
					
					material = Material.steel();
				}
				else {
					
					material = Material.steel();
				}
				
				
				
				var actorNape:Body =  new Body();
				actorNape.position.x = actor.x;
				actorNape.position.y = actor.y;
				actorNape.space = space;
				actorNape.graphic = actor ;
				actorNape = BodyFromGraphic.starlingToBody(actorNape,material);
				actorNape.graphicUpdate = updateGraphics;
				this.addChild(actorNape.graphic);
				
			}
		}
		
		private function updateGraphics(b:Body):void
		{
			// TODO Auto Generated method stub
			var actor:Actor = b.graphic as Actor;
			actor.x = b.position.x;
			actor.y = b.position.y;
			actor.rotation = b.rotation;
			if (actor.crushable == true){
				//trace (b.crushFactor());
				if (b.crushFactor() > crushNumber){
					b.graphic.crushed = true;
				}
				
			}
			
		}
		
		
		
		
		private function onEnterFrame(event:Event):void
		{
			// TODO Auto Generated method stub
			
			for (var i:int = 0; i < space.bodies.length; i++){
				var b:Body = space.bodies.at(i) as Body;
				
				if (b.space != null){
					if (b.isDynamic() == true){
						if (b.graphic is Actor){
							//trace("An actor identified");
							var actor:Actor =  b.graphic as Actor;
							if (actor.crushed == true){
								//trace(actor.imgSrc);
								mParticleSystem.emitterX = b.position.x;
								mParticleSystem.emitterY = b.position.y;
								mParticleSystem.start(.25);
								this.removeChild(actor);
								actor = null;
								space.bodies.remove(b);
								b.graphicUpdate = null;
								b.clear();
								
							}
						}
						
					}
				}
				
			}
			debug.clear();
			space.step(1/60);
			debug.draw(space);
			debug.flush();
		}
	}
}