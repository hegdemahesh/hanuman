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
	
	import com.hegdemahesh.events.ActionButtonEvent;
	import com.hegdemahesh.events.ChangeBackgroundOffset;
	import com.hegdemahesh.events.DeveloperScreenChanged;
	import com.hegdemahesh.events.LevelClearedEvent;
	import com.hegdemahesh.events.LevelFailedEvent;
	import com.hegdemahesh.events.LoadLevelEvent;
	import com.hegdemahesh.events.SponsorScreenChanged;
	import com.hegdemahesh.events.StartScreenChanged;
	import com.hegdemahesh.model.Assets;
	import com.hegdemahesh.ui.components.ActionButton;
	import com.hegdemahesh.ui.components.LevelClearedMenu;
	import com.hegdemahesh.ui.components.LevelFailedMenu;
	import com.hegdemahesh.ui.components.ScoreComponent;
	import com.hegdemahesh.ui.components.WeaponCount;
	import com.hegdemahesh.vos.Level;
	
	import starling.display.DisplayObject;
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
		
		private var levelManager:LevelManager =  new LevelManager();
		
		/**
		 * A dispaly component to show current score 
		 */
		
		private var scoreComponent:ScoreComponent;
		
		
		/**
		 * A button to show menu screen 
		 */
		private var menuButton:ActionButton;
		
		/**
		 * A button to restart the current level 
		 */
		
		private var replayButton:ActionButton;
		
		/**
		 * A component to show current weapon Count 
		 */
		
		private var weaponCountComp:WeaponCount;
		
		
		
		
		/**
		 * creats a new Game instance
		 */
		
		
		
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		/**
		 * once game is added to the stage, background and the playable world are added to the game
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
			this.addEventListener(ActionButtonEvent.GET,onActionButtonEvent);
			
			
			
			//levelScreen.addEventListener(ChangeBackgroundOffset.GET,onOffestChange);
		}	
		
		private function addWeaponCount():void
		{
			// TODO Auto Generated method stub
			weaponCountComp =  new WeaponCount(world.weaponCount);
			weaponCountComp.x = 779;
			weaponCountComp.y = 55;
			this.addChild(weaponCountComp);
		}
		
		private function addScoreComponents(level:Level):void
		{
			// TODO Auto Generated method stub
			scoreComponent =  new ScoreComponent(level);
			scoreComponent.x = 600;
			scoreComponent.y = 0;
			this.addChild(scoreComponent);
		}
		
		private function addMenuComp(level:Level):void
		{
			// TODO Auto Generated method stub
			menuButton =  new ActionButton("menu");
			menuButton.x = 5;
			menuButton.y = 0;
			menuButton.addEventListener(ActionButtonEvent.GET,onActionButtonEvent);
			this.addChild(menuButton);
			
			replayButton =  new ActionButton("replay");
			replayButton.x =75;
			replayButton.y = 0;
			replayButton.level =  level;
			replayButton.addEventListener(ActionButtonEvent.GET,onActionButtonEvent);
			this.addChild(replayButton);
			
			
		}
		
		
		private function removeWeaponCount():void
		{
			// TODO Auto Generated method stub
			if (this.contains(weaponCountComp)){
				weaponCountComp.removeFromParent(true);
			}
		}
		
		private function removeScoreComp():void
		{
			// TODO Auto Generated method stub
			if(this.contains(scoreComponent)){
				this.removeChild(scoreComponent);
			}
		}
		
		private function removeMenuComp():void
		{
			// TODO Auto Generated method stub
			if (this.contains(menuButton)){
				menuButton.removeFromParent(true);
			}
			if (this.contains(replayButton)){
				replayButton.removeFromParent(true);
			}
		}	
		
		
		private function onActionButtonEvent(event:ActionButtonEvent):void
		{
			// TODO Auto Generated method stub
			var actionString:String = event.actionString;
			var actionLevel:Level =  event.level;
			var displayObject:DisplayObject = event.target as DisplayObject;
			displayObject.removeFromParent(true);
			
			if (actionString == "replay"){
				/*if (world != null){
					world.clearLevel();
					world.removeFromParent(true);
					this.removeChild(world);
					world = null;
				}*/
				addGameWorld(actionLevel);
			}
			if (actionString == "next"){
				/*if (world != null){
					world.clearLevel();
					world.removeFromParent(true);
					this.removeChild(world);
					world = null;
				}*/
				addGameWorld(levelManager.nextLevel(actionLevel));
			}
			if (actionString == "menu"){
				/*if (world != null){
					world.clearLevel();
					world.removeFromParent(true);
					this.removeChild(world);
					world = null;
				}*/
				removeWorld();
				resetLevelMenu();
			}
		}
		private function onLevelCleared(e:LevelClearedEvent):void
		{
			// TODO Auto Generated method stub
			
			var clearedLevel:Level = e.level;
			var levelValidate:Boolean = levelManager.validateLevel(clearedLevel);
			var levelClearedMenu:LevelClearedMenu = new LevelClearedMenu(clearedLevel,levelValidate);
			levelClearedMenu.x =  (stage.stageWidth-levelClearedMenu.bg.width)/2;
			levelClearedMenu.y = (stage.stageHeight-levelClearedMenu.bg.height)/2;
			levelClearedMenu.addEventListener(ActionButtonEvent.GET,onActionButtonEvent);
			this.addChild(levelClearedMenu);
		}
		private function onLevelFailed(event:LevelFailedEvent):void
		{
			// TODO Auto Generated method stub
			var failedLevel:Level =  event.level;
			var levelFailedMenu:LevelFailedMenu =  new LevelFailedMenu(failedLevel);
			levelFailedMenu.x =  (stage.stageWidth-levelFailedMenu.bg.width)/2;
			levelFailedMenu.y = (stage.stageHeight-levelFailedMenu.bg.height)/2;
			levelFailedMenu.addEventListener(ActionButtonEvent.GET,onActionButtonEvent);
			this.addChild(levelFailedMenu);
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
			
			this.addChild(bg);
			resetLevelMenu();
			this.addEventListener(LoadLevelEvent.GET,onLoadLevel);
		}
		
		private function resetLevelMenu():void {
			removeLevelScreen();
			levelScreen =  new MainMenu(levelManager.levelDetails);
			this.addChild(levelScreen);
		}
		
		private function removeLevelScreen():void {
			if (levelScreen != null){
				if (this.contains(levelScreen)){
					levelScreen.removeFromParent(true);
					this.removeChild(levelScreen);
					
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
			world =  new World(levelManager.setCurrentLevel(level),level);
			world.addEventListener(ChangeBackgroundOffset.GET,onOffestChange);
			this.addChild(world);
			
			addMenuComp(level);
			addScoreComponents(level);
			addWeaponCount();
		}
		
		private function removeWorld():void
		{
			// TODO Auto Generated method stub
			if (world != null){
				world.clearLevel();
				if (this.contains(world)){
					world.removeFromParent(true);
					this.removeChild(world);
					if(world.hasEventListener(ChangeBackgroundOffset.GET) == true){
						world.removeEventListener(ChangeBackgroundOffset.GET,onOffestChange);
					}
				}
				world =  null;
			}
			removeMenuComp();
			removeScoreComp();
			removeWeaponCount();
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