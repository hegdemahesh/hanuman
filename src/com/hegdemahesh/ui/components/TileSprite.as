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
package com.hegdemahesh.ui.components
{
	import com.hegdemahesh.vos.Level;
	
	import starling.display.Sprite;
	
	public class TileSprite extends Sprite
	{
		public var contentHeight:int;
		public var contentWidth:int;
		public function TileSprite(levelXml:XML=null,conWidth:int=400,conHeight:int=400)
		{
			super();
			this.contentHeight = conHeight;
			this.contentWidth = conWidth;
			if (levelXml != null){
				extractLevels(levelXml);
			}
			
		}
		
		private function extractLevels(levelXML:XML):void
		{
			// TODO Auto Generated method stub
			var xSpace:int = 0;
			var ySpace:int = 0;
			for (var i:int = 0; i < levelXML.level.length(); i ++){
				var level:Level =  new Level();
				level.levelId = levelXML.level[i].id;
				level.levelName =  levelXML.level[i].name;
				
				if(levelXML.level[i].cleared == 'Yes'){
					level.locked = false;
					var openLevel:OpenLevel =  new OpenLevel(level);
					openLevel.x = xSpace;
					openLevel.y = ySpace;
					this.addChild(openLevel);
				}
				else {
					level.locked = true;
					var lockedLevel:LockedLevel =  new LockedLevel(level);
					lockedLevel.x = xSpace;
					lockedLevel.y = ySpace;
					this.addChild(lockedLevel);
				}
				
				xSpace = xSpace+ 110;
				//ySpace = ySpace+ 110;
				if (xSpace > contentWidth){
					xSpace = 0;
					ySpace = ySpace + 110;
				}
			}
		}
	}
}