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
	
	
	import com.hegdemahesh.ui.components.Actor;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
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
		private var groundXOffset:int = 1000;
		/**
		 * groundYOffset is the distance from top of the screen at which ground starts
		 */
		
		private var groundYOffest:int = 491;
		
		/**
		 * this Particle system is responsible for villain destruction effect
		 */
		
		private var mParticleSystem:PDParticleSystem;
		
		/**
		 * configuration file for particle system. (Built on a particle effects extenson for starling)
		 */
		
		private var psConfig:XML = XML(new Assets.SunConfig());
		
		
		/**
		 * texture for particle system. (Built on a particle effects extenson for starling)
		 */
		
		private var psTexture:Texture = Texture.fromBitmap(new Assets.SunParticle());
		
		/**
		 * An Offest for viewing rectangle. this will change the application virtual focus point. 
		 */
		
		public var viewFocusX:int = 0;
		
		/**
		 * A debug environament for nape physics. remove this for production 
		 */
		private var debug:BitmapDebug;
		
		
		/**
		 * Creates a new World.
		 */
		
		public function World()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			space = new Space(new Vec2(0,2000));
			
			/*Add ground to the physics world*/
			ground = new Body(BodyType.STATIC);
			ground.shapes.add(new Polygon(Polygon.rect(0,groundYOffest,1700,20)));
			ground.space = space;
			
			/*Add our hero 'hanuman' to the stage*/
			var hanuman:MovieClip =  new MovieClip(Assets.getAtlas().getTextures("hanuman_"),24);
			hanuman.x = 100;
			hanuman.y = 220;
			this.addChild(hanuman);
			hanuman.play();
			Starling.juggler.add(hanuman);
			
			/*Extract level related information*/
			//extractActors();
			loadLevel("level1");
			
			addCatapult();
			
			/*Add Actor destroy Effects*/
			this.addChild(mParticleSystem);
			Starling.juggler.add(mParticleSystem);
			
			this.addEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
			//this.addEventListener(WeaponReleased.GET,onWeaponReleased);
			
			
			/*Debug view for nape physics.. remove this for deployment*/
			debug = new BitmapDebug(stage.stageWidth,stage.stageHeight,0x333333,true);
			Starling.current.nativeOverlay.addChild(debug.display);
			
		}
		
		private function addCatapult():void {
			
		}
		
		/**
		 *this function is executed once every frame
		 */
		private function onEnterFrame(event:Event):void
		{
			// TODO Auto Generated method stub
			
		}
		
		/**
		 *reset the level back to the initial stage
		 */
		public function resetLevel():void {
			
		}
		
		/**
		 * loads different levels
		 */
		public function loadLevel(levelName:String):void {
			
		}
		
	}
}