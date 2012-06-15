package com.hegdemahesh.ui
{
	
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
	
	public class Level1 extends Sprite
	{
		
		
		private var backgroundImage:Image;
		
		private var maxScreenWidth:int = 2000;
		private var maxScreenHeight:int = 600;
		
		private var space:Space;
		
		private var crushNumber:Number = 50;
		
		private var ground:Body;
		private var groundXOffset:int = 400;
		private var groundYOffest:int = 491;
		
		private var mParticleSystem:PDParticleSystem;
		
		private var psConfig:XML = XML(new Assets.SunConfig());
		private var psTexture:Texture = Texture.fromBitmap(new Assets.SunParticle());
		
		private var catapult:Body =  new Body(BodyType.DYNAMIC);
		private var hanumanTail:Actor = new Actor("tail");
		private var pivot:WeldJoint;
		
		private var debug:BitmapDebug;
		
		private var mouseDown:Boolean =  false;
		
		private var hand:PivotJoint ;
		
		
		
		private var weaponLoaded:Boolean = false;
		public function Level1()
		{
			super();
			
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
			mParticleSystem = new PDParticleSystem(psConfig, psTexture);
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			
			space = new Space(new Vec2(0,2000));
			
			ground = new Body(BodyType.STATIC);
			ground.shapes.add(new Polygon(Polygon.rect(0,groundYOffest,850,20)));
			ground.space = space;
			
			
			extractActors();
			addCatapult();
			
			
			this.addChild(mParticleSystem);
			Starling.juggler.add(mParticleSystem);
			
			this.addEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
			
			debug = new BitmapDebug(stage.stageWidth,stage.stageHeight,0x333333,true);
			Starling.current.nativeOverlay.addChild(debug.display);
			
			hand = new PivotJoint(space.world,null,new Vec2(),new Vec2());
			hand.active = false;
			hand.stiff = false;
			hand.space = space;
			
			this.addEventListener(starling.events.TouchEvent.TOUCH,onTouch);
		}
		
		
		
		private function addCatapult():void {
			
			var prevBody:Body;
			var currW:int = 50;
			var currX:Number = 140;
			var prevW:Number = currW;
			var prevX:Number;
			var rot:Number = 0;
			var rotFactor:Number = .1;

			
			var hanuman:MovieClip =  new MovieClip(Assets.getAtlas().getTextures("hanuman_"),24);
			hanuman.x = 100;
			hanuman.y = 220;
			this.addChild(hanuman);
			hanuman.play();
			Starling.juggler.add(hanuman);
			
			var material:Material = new Material(.8);
			material.density = 10;
			
			var stoneBody:Body = new Body(BodyType.DYNAMIC);
			stoneBody.position.x = 117;
			stoneBody.position.y = 148;
			stoneBody.space = space;
			stoneBody.graphic = new Actor("stone_throw");
			stoneBody = BodyFromGraphic.starlingToBody(stoneBody,material);
			stoneBody.graphicUpdate = updateGraphics;
			(stoneBody.graphic as Actor).addEventListener(starling.events.TouchEvent.TOUCH,onStoneTouch);
			this.addChild(stoneBody.graphic);
			
			/*var type:BodyType = BodyType.KINEMATIC;
			var stone1:Body = new Body(type);
			stone1.shapes.add(new Polygon(Polygon.rect(100, 200, 20, 50),material));*/
			
			for (var i:int =0; i < 3; i ++){
				var type:BodyType = BodyType.KINEMATIC;
				var b:Body = new Body(type);
				b.shapes.add(new Polygon(Polygon.rect(currX, 160, currW, 10),material));
				
				rot = rot+ rotFactor;
				currX += currW;
				b.rotation = rot;
				
				if(prevBody)
				{
					prevBody.type = BodyType.DYNAMIC;
					var a:AngleJoint = new AngleJoint(prevBody, b, 0, 0);
					a.stiff = false;
					a.space = space;
					a.frequency = 200;
					a.damping = 100;
					a.ignore = true;
					
					var j:PivotJoint = new PivotJoint(prevBody, b, new Vec2(10, 10), new Vec2(10, 10));
					j.breakUnderForce = false;
					j.ignore = true;
					j.stiff = false;
					j.space = space;
				}
				
				b.space = space;
				prevBody = b;
				prevW = currW;
				prevX = currX;
				
				
			}
			hanumanTail.x = 94+ int(hanumanTail.image.width/2);
			hanumanTail.y = 143+ int(hanumanTail.image.height/2);
			hanumanTail.pivotX = 81;
			hanumanTail.pivotY = 120;
			this.addChild(hanumanTail);
			
		}
		
		private function onStoneTouch(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			
			//pivot.active = false;
			weaponLoaded =false;
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
				//actor.allowRotation = true;
				actorNape.position.x = actor.x;
				actorNape.position.y = actor.y;
				actorNape.space = space;
				//actorNape.castBody;
				//actorNape.castShape;
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
				trace (b.crushFactor());
				if (b.crushFactor() > crushNumber){
					b.graphic.crushed = true;
				}
				
			}
		
		}
		
		
		private function onTouch(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			var target:DisplayObject = event.target as DisplayObject;
			var mouseX:int;
			var mouseY:int;
			//trace(target);
			if(event.getTouch(target, TouchPhase.HOVER))
			{
				// mouse moving while up
				mouseX = event.getTouch(target, TouchPhase.HOVER).globalX;
				mouseY = event.getTouch(target, TouchPhase.HOVER).globalY;
				hand.anchor1.setxy(mouseX,mouseY);
			}
			
			if(event.getTouch(target, TouchPhase.MOVED))
			{
				// mouse moving while down
				mouseX = event.getTouch(target, TouchPhase.MOVED).globalX;
				mouseY = event.getTouch(target, TouchPhase.MOVED).globalY;
				hand.anchor1.setxy(mouseX,mouseY);
			}
			
			if(event.getTouch(target, TouchPhase.BEGAN)&&!mouseDown)
			{
				// mouse down
				mouseDown = true;
				mouseX = event.getTouch(target, TouchPhase.BEGAN).globalX;
				mouseY = event.getTouch(target, TouchPhase.BEGAN).globalY;
				var mp:Vec2 = new Vec2(mouseX, mouseY);
				var b:Body = space.bodiesUnderPoint(mp).at(0);
				hand.body2 = b;
				hand.anchor2 = b.worldToLocal(mp);
				hand.active = true;
			}
			else if(event.getTouch(target, TouchPhase.ENDED)&&mouseDown)
			{
				// mouse up
				mouseDown = false;
				hand.active = false;
			}
			
			
		}
		
		private function onEnterFrame(event:Event):void
		{
			// TODO Auto Generated method stub
			if (weaponLoaded == true){
				catapult.angularVel = 0;
			}
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