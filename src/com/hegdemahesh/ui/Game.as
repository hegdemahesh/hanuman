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
	import com.hegdemahesh.events.DeveloperScreenChanged;
	import com.hegdemahesh.events.LevelClearedEvent;
	import com.hegdemahesh.events.LevelFailedEvent;
	import com.hegdemahesh.events.LoadLevelEvent;
	import com.hegdemahesh.events.SponsorScreenChanged;
	import com.hegdemahesh.events.StartScreenChanged;
	import com.hegdemahesh.model.Assets;
	import com.hegdemahesh.ui.components.LevelClearedMenu;
	import com.hegdemahesh.vos.Level;
	
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
		/**
		 * Sponsor screen
		 */
		private var sponsorScreen:SponsorScreen;
		/**
		 * Developer screen
		 */
		private var developerScreen:DeveloperScreen;
		
		/**
		 * Start screen
		 */
		private var startScreen:StartScreen;
		
		/**
		 * Level Screen
		 */
		private var levelScreen:MainMenu;
		
		
		
		/**
		 * Background Class for the which implements parallax functionality
		 */
		
		private var bg:Background;
		
		/**
		 * world display is responsible for presentaing the playable game space
		 */
		private var world:World;
		
		/**
		 * utility class to load different levels
		 */
		
		private var levelLoader:LevelLoader =  new LevelLoader();
		
		
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
			//this.addChild(bg);
			
			//this.addChild(world);
			//levelScreen = new LevelLoader();
			//this.addChild(levelScreen);
			sponsorScreen =  new SponsorScreen();
			this.addChild(sponsorScreen);
			sponsorScreen.addEventListener(SponsorScreenChanged.GET,onSponsorScreenChanged);
				
			this.addEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
			this.addEventListener(LevelClearedEvent.GET,onLevelCleared);
			this.addEventListener(LevelFailedEvent.GET,onLevelFailed);
			//levelScreen.addEventListener(ChangeBackgroundOffset.GET,onOffestChange);
		}	
		private function onLevelCleared(e:LevelClearedEvent):void
		{
			// TODO Auto Generated method stub
			var clearedLevel:Level = e.level;
			var levelClearedMenu:LevelClearedMenu = new LevelClearedMenu(clearedLevel);
			levelClearedMenu.x =  (stage.stageWidth-levelClearedMenu.bg.width)/2;
			levelClearedMenu.y = (stage.stageHeight-levelClearedMenu.bg.height)/2;
			this.addChild(levelClearedMenu);
			
		}
		private function onLevelFailed(event:LevelFailedEvent):void
		{
			// TODO Auto Generated method stub
			var failedLevel:Level =  event.level;
		}
		
		private function onSponsorScreenChanged(event:SponsorScreenChanged):void
		{
			// TODO Auto Generated method stub
			this.removeChild(sponsorScreen);
			sponsorScreen =  null;
			developerScreen = new DeveloperScreen();
			this.addChild(developerScreen);
			developerScreen.addEventListener(DeveloperScreenChanged.GET,onDeveloperScreenChanged)
		}
		
		private function onDeveloperScreenChanged(event:DeveloperScreenChanged):void
		{
			// TODO Auto Generated method stub
			this.removeChild(developerScreen);
			developerScreen =  null;
			addStartScreen();
		}
		
		private function addStartScreen():void
		{
			// TODO Auto Generated method stub
			startScreen =  new StartScreen();
			this.addChild(startScreen);
			startScreen.addEventListener(StartScreenChanged.GET,onStartScreenChanged);
		}
		
		private function onStartScreenChanged():void
		{
			// TODO Auto Generated method stub
			this.removeChild(startScreen);
			startScreen =  null;
			//addGameWorld();
			addMenu();
		}
		
		private function addMenu():void
		{
			// TODO Aremouto Generated method stub
			removeLevelScreen();
			levelScreen =  new MainMenu(levelLoader.levelDetails);
			this.addChild(bg);
			this.addChild(levelScreen);
			this.addEventListener(LoadLevelEvent.GET,onLoadLevel);
		}
		
		private function removeLevelScreen():void {
			if (levelScreen != null){
				if (this.contains(levelScreen)){
					removeChild(levelScreen);
					
				}
				levelScreen =  null;
			}
		}
		private function onLoadLevel(event:LoadLevelEvent):void
		{
			// TODO Auto Generated method stub
			removeLevelScreen();
			var level:Level = event.level;
			addGameWorld(level);
			
		}
		
		private function addGameWorld(level:Level):void {
			
			removeWorld();
			world =  new World(levelLoader.currentLevel(level.levelName),level);
			world.addEventListener(ChangeBackgroundOffset.GET,onOffestChange);
			this.addChild(world);
		}
		
		private function removeWorld():void
		{
			// TODO Auto Generated method stub
			if (world != null){
				if (this.contains(world)){
					removeChild(world);
					if(world.hasEventListener(ChangeBackgroundOffset.GET) == true){
						world.removeEventListener(ChangeBackgroundOffset.GET,onOffestChange);
					}
				}
				world =  null;
			}
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