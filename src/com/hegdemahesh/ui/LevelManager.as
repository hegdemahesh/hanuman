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
	import com.hegdemahesh.model.Assets;
	import com.hegdemahesh.vos.Level;
	
	public class LevelManager
	{
		public var xml1:XML = XML(new com.hegdemahesh.model.Assets.level1XML());
		public var xml2:XML = XML(new com.hegdemahesh.model.Assets.level2XML());
		public var xml3:XML = XML(new com.hegdemahesh.model.Assets.level3XML());
		public var xml4:XML = XML(new com.hegdemahesh.model.Assets.level4XML());
		public var xml5:XML = XML(new com.hegdemahesh.model.Assets.level5XML());
		public var xml6:XML = XML(new com.hegdemahesh.model.Assets.level6XML());
		public var xml7:XML = XML(new com.hegdemahesh.model.Assets.level7XML());
		public var xml8:XML = XML(new com.hegdemahesh.model.Assets.level8XML());
		public var xml9:XML = XML(new com.hegdemahesh.model.Assets.level9XML());
		public var xml10:XML = XML(new com.hegdemahesh.model.Assets.level10XML());
		public var xml11:XML = XML(new com.hegdemahesh.model.Assets.level11XML());
		public var xml12:XML = XML(new com.hegdemahesh.model.Assets.level12XML());
		public var xml13:XML = XML(new com.hegdemahesh.model.Assets.level13XML());
		public var xml14:XML = XML(new com.hegdemahesh.model.Assets.level14XML());
		public var xml15:XML = XML(new com.hegdemahesh.model.Assets.level15XML());
		public var xml16:XML = XML(new com.hegdemahesh.model.Assets.level16XML());
		public var xml17:XML = XML(new com.hegdemahesh.model.Assets.level17XML());
		public var xml18:XML = XML(new com.hegdemahesh.model.Assets.level18XML());
		
		public var levelDetails:XML = XML(new com.hegdemahesh.model.Assets.levelDetails());
		
		public var runningLevel:Level;
		
		public function LevelManager()
		{
			resetCurrentLevel();
		}
		public function resetCurrentLevel():void {
			runningLevel =  new Level();
			runningLevel.levelId = levelDetails.level[0].id;
			runningLevel.levelName = levelDetails.level[0].name;
		}
		public function currentLevel():Level {
			return runningLevel;
		}
		public function nextLevel(cLevel:Level= null):Level {
			var level:Level = new Level();
			if (cLevel == null){
				level.levelId = levelDetails.level[runningLevel.levelId].id;
				level.levelName = levelDetails.level[runningLevel.levelId].name;
			}
			
			else {
				level.levelId = levelDetails.level[cLevel.levelId].id;
				level.levelName = levelDetails.level[cLevel.levelId].name;
			}
			//levelDetails.level[runningLevel.levelId].cleared = "Yes";
			return level;
		}
		public function validateLevel(level:Level):Boolean {
			if (levelDetails.level[level.levelId] != undefined){
				levelDetails.level[level.levelId].cleared = "Yes";
				return true;
			}
			else {
				return false;
			}
			
		}
		public function setCurrentLevel(level:Level=null):XML {
			if (level == null){
				resetCurrentLevel();
				return xml1;
			}
			else {
				if (levelDetails.level[level.levelId-1].cleared == "Yes"){
					if (this['xml'+level.levelId.toString()] != null){
						runningLevel = level;
						return (this['xml'+level.levelId.toString()] as XML);
					}
					else {
						resetCurrentLevel();
						return xml1;
						trace("Level Not Available");
					}
				}
				else {
					resetCurrentLevel();
					return xml1;
					trace("Level Not authenticated");
				}
			}
		}
	}
}