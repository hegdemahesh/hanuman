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
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	/**
	 * The Game class holds the main game play area and the UI for score and other stats
	 * This is the class that is passed to Starling for initialization.
	 * @author hegdemahesh website://www.hegdemahesh.com
	 *
	 */
	
	public class Game extends Sprite
	{
		private var levelScreen:LevelLoader;
		
		/**
		 * Background Class for the which implements parallax functionality
		 */
		
		private var bg:Background;
		
		/**
		 * world display is responsible for presentaing the playable game space
		 */
		private var world:World;
		
		
		/**
		 * level related information stored in XML objects
		 */
		
		private var xmlLevel1:XML = XML(new Assets.level1XML());
		
		/**
		 * creats a new Game instance
		 */
		
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		/**
		 * once game is added to the stage, background and the playable world are added
		 */
		private function onAddedToStage(event:Event):void
		{
			bg =  new Background();
			this.addChild(bg);
			world =  new World(xmlLevel1);
			this.addChild(world);
			//levelScreen = new LevelLoader();
			//this.addChild(levelScreen);
			this.addEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
			world.addEventListener(ChangeBackgroundOffset.GET,onOffestChange);
			//levelScreen.addEventListener(ChangeBackgroundOffset.GET,onOffestChange);
		}	
		/**
		 * Background offset is updated , when the game focus point changes..
		 */
		private function onOffestChange(event:ChangeBackgroundOffset):void
		{
			// TODO Auto Generated method stub
			bg.gameXOffset = event.globalXOffset;
		}
		/**
		 * this function is called once every frame
		 */
		private function onEnterFrame(event:Event):void
		{
			
			
		}
	}
}