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
	
	
	import com.hegdemahesh.events.ChangeBackgroundOffset;
	import com.hegdemahesh.events.LevelClearedEvent;
	import com.hegdemahesh.events.LevelFailedEvent;
	import com.hegdemahesh.events.ScoreEvent;
	import com.hegdemahesh.events.WeaponCountEvent;
	import com.hegdemahesh.events.WeaponReleased;
	import com.hegdemahesh.model.Assets;
	import com.hegdemahesh.model.Constants;
	import com.hegdemahesh.ui.components.ActionButton;
	import com.hegdemahesh.ui.components.Actor;
	import com.hegdemahesh.ui.components.ScoreComponent;
	import com.hegdemahesh.ui.components.Weapon;
	import com.hegdemahesh.ui.components.WeaponCount;
	import com.hegdemahesh.vos.Level;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	
	import mx.events.FlexEvent;
	
	import nape.geom.GeomPoly;
	import nape.geom.GeomPolyList;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	/**
	 * The World class holds the main game play area.
	 * This class is responsible for adding actors to the game   
	 * @author hegdemahesh website://www.hegdemahesh.com
	 *
	 */
	public class World extends Sprite
	{
		/**
		 * A space obect for nape physics for physics functionality
		 */
		private var space:Space;
		
		/**
		 * a crush number. Beyond which if a villain is crushed he is destroyed
		 */
		
		private var crushNumber:Number = 100;
		
		/**
		 * A rigid ground body to simulate ground for physics funationality
		 */
		private var ground:Body;
		/**
		 * groundXOffset is where the palace OR the destructable area starts
		 */		
		private var groundXOffset:int = 600;
		/**
		 * groundYOffset is the distance from top of the screen at which ground starts
		 */
		
		private var groundYOffest:int = 550;
		
		/**
		 * this Particle system is responsible for villain destruction effect
		 */
		
		private var mParticleSystem:PDParticleSystem;
		
		/**
		 * configuration file for particle system. (Built on a particle effects extenson for starling)
		 */
		
		private var psConfig:XML = XML(new com.hegdemahesh.model.Assets.SunConfig());
		
		
		/**
		 * texture for particle system. (Built on a particle effects extenson for starling)
		 */
		
		
		private var psTexture:Texture = Texture.fromBitmap(new com.hegdemahesh.model.Assets.SunParticle());
		
		/**
		 * An Offest for viewing rectangle. this will change the application virtual focus point. 
		 */
		
		public var viewFocusX:int = 0;
		
		/**
		 * A debug environament for nape physics. remove this for production 
		 */
		private var debug:BitmapDebug;
		
		/**
		 * Maximum number of weapons that can be used by the user in a level 
		 */
		private var _weaponCount:int;
		
		/**
		 * weapon component to be loaded 
		 */
		private var weaponRelease:Weapon;
		
		/**
		 * An XML containing actor information about the current level 
		 */
		
		private var levelXML:XML;
		
		/**
		 * An level object containing information about the current level 
		 */
		
		private var selectedLevel:Level;
		
		
		/**
		 * Number of frames to wait after all villains are destroyed
		 */
		private var actorFrameCouter:int = Constants.LEVEL_COMPLETE_DELAY;
		
		/**
		 * total of score of the level
		 */
		private var _levelScore:int = 0;
		
		/**
		 * background Sound Channel
		 */
		
		private var soundChannel:SoundChannel =  new SoundChannel();
		
		/**
		 * background Sound Object
		 */
		
		private var sound:Sound = Assets.getSound("background3");
		
		/**
		 * Creates a new World.
		 */
		
		public function World(levelXMLTemp:XML = null,level:Level = null)
		{
			super();
			if (levelXMLTemp != null){
				levelXML = new XML(levelXMLTemp);
			}
			if (level != null){
				selectedLevel = level;
			}
			mParticleSystem = new PDParticleSystem(psConfig, psTexture);
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
			
		}
		
		public function set levelScore(score:int):void {
			_levelScore = score;
			var e:ScoreEvent =  new ScoreEvent(ScoreEvent.GET);
			e.score = score;
			this.dispatchEvent(e);
		}
		public function get levelScore():int {
			return _levelScore;
		}
		
		public function set weaponCount(c:int):void {
			_weaponCount = c;
			var ev:WeaponCountEvent =  new WeaponCountEvent(WeaponCountEvent.GET);
			ev.count = c;
			this.dispatchEvent(ev);
		}
		public function get weaponCount():int {
			return _weaponCount;
		}
		
		private function onAddedToStage(event:starling.events.Event):void
		{
			// TODO Auto Generated method stub
			space = new Space(new Vec2(0,2000));
			space.gravity = new Vec2(0,1200);
			/*Add ground to the nape physics world*/
			ground = new Body(BodyType.STATIC);
			ground.shapes.add(new Polygon(Polygon.rect(0,groundYOffest,1700,20)));
			ground.space = space;
			
			/*Add our hero 'hanuman' to the stage*/
			var hanuman:MovieClip =  new MovieClip(Assets.getAtlas().getTextures("hanuman_"),24);
			hanuman.x = Constants.WEAPON_X - 42;
			hanuman.y = Constants.WEAPON_Y + 54;
			this.addChild(hanuman);
			hanuman.play();
			Starling.juggler.add(hanuman);
			
			/*Extract level related information*/
			//extractActors();
			if (levelXML != null){
				loadLevel(levelXML);
			}
			
			addCatapult();
			
			/*Add Actor destroy Effects*/
			this.addChild(mParticleSystem);
			Starling.juggler.add(mParticleSystem);
			
			
			
			this.addEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
			//this.addEventListener(WeaponReleased.GET,onWeaponReleased);
			
			soundChannel = sound.play(0,9999);
			
			//changeViewPort(1275);
			
			/*Debug view for nape physics.. remove this for deployment*/
			//debug = new BitmapDebug(stage.stageWidth,stage.stageHeight,0x333333,true);
			//Starling.current.nativeOverlay.addChild(debug.display);
			
		}
		
		
		
		
		/**
		 * Hanuman tail component initialised 
		 */
		
		private function addCatapult():void {
			var material:Material = new Material(.8);
			material.density = 10;
			
			
			weaponRelease = new Weapon(Constants.WEAPON_X,Constants.WEAPON_Y,"stone_throw");
			weaponRelease.addEventListener(WeaponReleased.GET,onWeaponReleased);
			this.addChild(weaponRelease);
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
			material.rollingFriction = Constants.WEAPON_ROLLING_FRICTION;
			
			var actor:Actor =  new Actor("stone_throw");
			actor.x =  Constants.WEAPON_X ;
			actor.y = Constants.WEAPON_Y ;
			actor.isWeapon = true;
			
			var actorNape:Body =  new Body();
			actorNape.position.x = actor.x;
			actorNape.position.y = actor.y;
			actorNape.space = space;
			actorNape.graphic = actor ;
			actorNape = shapesToBody(actorNape,material);
			//actorNape = BodyFromGraphic.starlingToBody(actorNape,material);
			actorNape.graphicUpdate = updateGraphics;
			//actorNape.shapes.clear();
			//actorNape.shapes.add(new Circle(20,null,material));
			actorNape.velocity = new Vec2(xdif * Constants.SPEED_FACTOR,ydif * Constants.SPEED_FACTOR);
			this.addChild(actorNape.graphic);
			
		}
		
		public override function dispose():void {
			
			soundChannel.stop();
			sound = null;
			
			super.dispose();
		}
		
		/**
		 *this function is executed once every frame
		 */
		
		private function onEnterFrame(event:starling.events.Event):void
		{
			// TODO Auto Generated method stub
			if (actorFrameCouter > 0){
				actorFrameCouter--;
				for (var i:int = 0; i < space.bodies.length; i++){
					var b:Body = space.bodies.at(i) as Body;
					
					if (b.space != null){
						if (b.isDynamic() == true){
							if (b.graphic is Actor){
								//trace("An actor identified");
								var actor:Actor =  b.graphic as Actor;
								if (actor.crushable == true){
									actorFrameCouter = Constants.LEVEL_COMPLETE_DELAY;
									if (b.crushFactor() > Constants.CRUSH_NUMBER){
										b.graphic.crushed = true;
									}
								}
								if (b.crushFactor() > (Constants.CRUSH_NUMBER * 4)){
									if(b.userData != true){
										levelScore = levelScore + 350 + int(Math.random()*30);
										b.userData = true;
										var crashSound:Sound;
										if(Math.random() > 0.5){
											crashSound= Assets.getSound("crash3");
										}
										else {
											crashSound= Assets.getSound("crash4");
										}
										
										crashSound.play().addEventListener(flash.events.Event.SOUND_COMPLETE,onSoundComplete);
										crashSound = null;
									}
									
								}
								
								if (actor.isWeapon == true){
									if (b.isSleeping == true || (b.position.x > 1700) || (b.position.x < 0)){
										this.removeChild(actor);
										actor = null;
										space.bodies.remove(b);
										b.graphicUpdate = null;
										b.clear();
										loadWeapon();
									}
									else {
										changeViewPort(b.position.x);
									}
								}
								if (actor != null){
									if (actor.crushed == true || (actor.x > 1700) ){
										//trace(actor.imgSrc);
										var sound:Sound;
										if(Math.random() > .66){
											sound = Assets.getSound("crash");
										}
										else if (Math.random() < .33){
											sound = Assets.getSound("crash2");
										}
										else {
											sound = Assets.getSound("crash2");
										}
										 
										sound.play();
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
					
				}
				updateViewport();
				//debug.clear();
				space.step(1/60);
				//debug.draw(space);
				//debug.flush();
			}
			else {
				levelComplete();
				//debug.clear();
			}
			
			
		}
		
		protected function onSoundComplete(event:flash.events.Event):void
		{
			// TODO Auto-generated method stub
			(event.target as SoundChannel).removeEventListener(flash.events.Event.SOUND_COMPLETE,onSoundComplete);
			
		}
		
		private function levelComplete():void
		{
			// TODO Auto Generated method stub
			//clearLevel();
			levelScore = levelScore + (Constants.WEAPON_SCORE_FACTOR * weaponCount);
			
			if (this.hasEventListener(starling.events.Event.ENTER_FRAME)){
				this.removeEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
			}
			
			var e:LevelClearedEvent =  new LevelClearedEvent(LevelClearedEvent.GET);
			e.level = selectedLevel;
			e.score = levelScore;
			this.dispatchEvent(e);
			
		}
		
		private function checkForActors():Boolean
		{
			// TODO Auto Generated method stub
			var actorPresnt:Boolean = false;
			for (var i:int = 0; i < space.bodies.length; i++){
				var b:Body = space.bodies.at(i) as Body;
				
				if (b.space != null){
					if (b.isDynamic() == true){
						if (b.graphic is Actor){
							//trace("An actor identified");
							var actor:Actor =  b.graphic as Actor;
							if (actor.crushable == true){
								actorPresnt = true;
							}
						}
					}
				}
			}
			return actorPresnt;
		}
		
		private function levelFailed():void
		{
			// TODO Auto Generated method stub
			//clearLevel();
			if (this.hasEventListener(starling.events.Event.ENTER_FRAME)){
				this.removeEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
			}
			if (checkForActors() == true){
				var e:LevelFailedEvent = new LevelFailedEvent(LevelFailedEvent.GET);
				e.level =  selectedLevel;
				this.dispatchEvent(e);
			}
			else {
				levelComplete();
			}
			
		}
		
		public function clearLevel():void
		{
			// TODO Auto Generated method stub
			
			if (this.hasEventListener(starling.events.Event.ENTER_FRAME)){
				this.removeEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
			}
			
			removeBodies();
			for (var i:int = 0; i < this.numChildren ; i++){
				//var displayObj:Sprite = this.getChildAt(i) as Sprite;
				if (this.getChildAt(i) is Actor){
					var actor:Actor = this.getChildAt(i) as Actor;
					this.removeChild(actor);
					actor = null;
					
				}
				if (this.getChildAt(i) is PDParticleSystem){
					var pdParticleSystem:PDParticleSystem = this.getChildAt(i) as PDParticleSystem;
					this.removeChild(pdParticleSystem);
					Starling.juggler.remove(pdParticleSystem);
					pdParticleSystem =  null;
				}
				
				if (this.getChildAt(i) is MovieClip){
					var movieClip:MovieClip = this.getChildAt(i) as MovieClip;
					this.removeChild(movieClip);
					Starling.juggler.remove(movieClip);
					movieClip = null;
					
				}
				if(this.getChildAt(i) is Weapon){
					var weapon:Weapon = this.getChildAt(i) as Weapon;
					weapon.removeEventListener(WeaponReleased.GET,onWeaponReleased);
					this.removeChild(weapon);
					weapon = null;
				}
			}
			this.dispose();
		}
		
		private function loadWeapon():void
		{
			// TODO Auto Generated method stub
			if (weaponCount > 1){
				weaponCount --;
				weaponRelease.loadWeapon();
				changeViewPort(0);
			}
			else {
				
				levelFailed();
			}
		}
		
		
		
		private function updateViewport():void
		{
			// TODO Auto Generated method stub
			//var oldX:int = this.x;
			var offsetRatio:Number = (this.x / viewFocusX);
			if (offsetRatio < 1.002 && offsetRatio > 0.998){
				this.x = int(viewFocusX);
				//debug.display.x = int(viewFocusX);
				
			}
			else {
				this.x = int((this.x * 8  + viewFocusX)/9);
				//debug.display.x = int((this.x * 8  + viewFocusX)/9);
			}
			//if(this.x != oldX){
				var e:ChangeBackgroundOffset =  new ChangeBackgroundOffset(ChangeBackgroundOffset.GET);
				e.globalXOffset = this.x;
				this.dispatchEvent(e);
			//}
			
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
				
			}
			
			
		}
		
		
		/**
		 *this function will remove level related bodies from nape space and from the starling display list.
		 */
		
		private function removeBodies():void
		{
			// TODO Auto Generated method stub
			//weaponCount = 0;
			for (var i:int = 0; i < space.bodies.length; i++){
				var b:Body = space.bodies.at(i) as Body;
				
				if (b.space != null){
					if (b.isDynamic() == true){
						if (b.graphic is Actor){
							//trace("An actor identified");
							var actor:Actor =  b.graphic as Actor;
							
							this.removeChild(actor);
							actor = null;
							
							
						}
					}
				}
				space.bodies.remove(b);
				b.graphicUpdate = null;
				b.clear();
				b = null;
			}
		}		
		
		
		/**
		 * loads different levels
		 */
		public function loadLevel(xml:XML):void {
			weaponCount = int(xml.weaponLimit);
			for (var i:int = 0; i < xml.actor.length();i ++ ){
				
				var actor:Actor =  new Actor(xml.actor[i].name);
				actor.idString = xml.actor[i].id;
				actor.material = xml.actor[i].material;
				actor.xcord = xml.actor[i].xcord;
				actor.ycord = xml.actor[i].ycord;
				actor.flammable = (xml.actor[i].flammable == 1)? true: false;
				actor.x = groundXOffset + int(xml.actor[i].xcord)/*-int(Math.ceil(actor.image.width/2))*/;
				actor.y = groundYOffest - int(xml.actor[i].ycord)/*-int(Math.ceil(actor.image.height/2))*/;
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
				
				actorNape = shapesToBody(actorNape,material);
				
				actorNape.graphicUpdate = updateGraphics;
				this.addChild(actorNape.graphic);
				
			}
		}
		
		public function shapesToBody(bodyTemp:Body,material:Material):Body {
			var body:Body = bodyTemp;
			var graphic:Actor = body.graphic as Actor;
			
			graphic.x = graphic.y = graphic.rotation = 0;
			var polys:GeomPolyList =  Assets.getShapes(graphic.imgSrc);
			
			polys.foreach(function (p:GeomPoly):void {
				var qolys:GeomPolyList = p.simplify(1).convex_decomposition();
				qolys.foreach(function (q:GeomPoly):void {
					body.shapes.add(new Polygon(q,material));
				});
			});
			
			var anchor:Vec2 = body.localCOM.mul(-1);
			//body.align();
			
			body.graphic = graphic;
			body.graphicOffset = anchor;
			
			return body;
		}
		
		
		/**
		 * position and other parameters of starling display sprites are modified in accordance with the nape physics objects
		 */
		
		private function updateGraphics(b:Body):void
		{
			// TODO Auto Generated method stub
			var actor:Actor = b.graphic as Actor;
			actor.x = int(b.position.x);
			actor.y = int(b.position.y);
			actor.rotation = b.rotation;
			
			
		}
	}
}