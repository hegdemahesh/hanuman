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
		public function validateLevel(level:Level):void {
			levelDetails.level[level.levelId-1].cleared = "Yes";
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