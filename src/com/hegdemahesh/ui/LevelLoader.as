package com.hegdemahesh.ui
{
	
	import com.hegdemahesh.events.ChangeBackgroundOffset;
	import com.hegdemahesh.events.WeaponReleased;
	import com.hegdemahesh.model.Constants;
	import com.hegdemahesh.ui.components.Actor;
	import com.hegdemahesh.ui.components.Weapon;
	
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
		private var groundXOffset:int = 800;
		private var groundYOffest:int = 491;
		
		private var mParticleSystem:PDParticleSystem;
		
		private var psConfig:XML = XML(new Assets.SunConfig());
		private var psTexture:Texture = Texture.fromBitmap(new Assets.SunParticle());
		
		public var viewFocusX:int = 0;
		
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
		
		private function onWeaponReleased(event:WeaponReleased):void
		{
			var xSpeed:int = event.xSpeed;
			var ySpeed:int = event.ySpeed;
			//trace(event.xSpeed+ 'weapon relased');
			addWeapon(xSpeed,ySpeed);
		}		
		
		private function addWeapon(xdif:int,ydif:int):void {
			
			var material:Material =  new Material(.6);
			material.density = Constants.WEAPON_MATERIAL_DENSITY;
			
			var actor:Actor =  new Actor("stone_throw");
			actor.x =  Constants.WEAPON_X - xdif - 19;
			actor.y = Constants.WEAPON_Y - ydif - 19;
			actor.isWeapon = true;
			
			var actorNape:Body =  new Body();
			actorNape.position.x = actor.x;
			actorNape.position.y = actor.y;
			actorNape.space = space;
			actorNape.graphic = actor ;
			actorNape = BodyFromGraphic.starlingToBody(actorNape,material);
			actorNape.graphicUpdate = updateGraphics;
			actorNape.velocity = new Vec2(xdif * Constants.SPEED_FACTOR,ydif * Constants.SPEED_FACTOR);
			this.addChild(actorNape.graphic);
			
		}
		private function addCatapult():void {
			
			
			
			var material:Material = new Material(.8);
			material.density = 10;
			
			
			var weaponRelease:Weapon = new Weapon(Constants.WEAPON_X,Constants.WEAPON_Y,"stone_throw");
			weaponRelease.addEventListener(WeaponReleased.GET,onWeaponReleased);
			this.addChild(weaponRelease);
			
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
							if (actor.isWeapon == true){
								if (b.isSleeping == true){
									this.removeChild(actor);
									actor = null;
									space.bodies.remove(b);
									b.graphicUpdate = null;
									b.clear();
								}
								else {
									changeViewPort(b.position.x);
								}
							}
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
			upadateViewport();
			debug.clear();
			space.step(1/60);
			debug.draw(space);
			debug.flush();
		}
		
		private function upadateViewport():void
		{
			// TODO Auto Generated method stub
			var offsetRatio:Number = (this.x / viewFocusX);
			if (offsetRatio < 1.002 && offsetRatio > 0.998){
				this.x = int(viewFocusX);
			}
			else {
				this.x = int((this.x  + viewFocusX)/2);
			}
		}
		
		private function changeViewPort(xVal:Number):void
		{
			// TODO Auto Generated method stub
			if (xVal < 425){
				xVal = 425;
			}
			if (xVal > 1275){
				xVal = 1275;
			}
			if ( viewFocusX != (425-xVal)){
				viewFocusX = 425 - xVal;
				var e:ChangeBackgroundOffset =  new ChangeBackgroundOffset(ChangeBackgroundOffset.GET);
				e.globalXOffset = viewFocusX;
				this.dispatchEvent(e);
			}
			
		}
	}
}