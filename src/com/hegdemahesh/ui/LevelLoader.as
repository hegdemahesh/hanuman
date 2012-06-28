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
	
	import starling.display.Sprite;
	
	/**
	 * level related information stored in XML objects
	 */
	
	
	
	public class LevelLoader extends Sprite
	{
		
		public var xml1:XML = XML(new com.hegdemahesh.model.Assets.level1XML());
		public var xml2:XML = XML(new com.hegdemahesh.model.Assets.level2XML());
		
		public var levelDetails:XML = XML(new com.hegdemahesh.model.Assets.levelDetails());
		
		public function LevelLoader()
		{
			super();
			
			
		}
		
		public function currentLevel(levelId:int = 0):XML {
			if (levelId == 0){
				return xml1;
			}
			else {
				
				return currentLevelXML(levelId);
			}
		}
		
		private function currentLevelXML(levelId:int):XML
		{
			// TODO Auto Generated method stub
			if (this['xml'+levelId.toString()] != null){
				return this['xml'+levelId.toString()];
			}
			else {
				return xml1;
			}
			/*if (levelId == 'level1'){
				return xmllevel1;
			}
			else if (levelId == 'level2'){
				return xmllevel2;
			}
			else {
				return null;
			}*/
			
		}
		
		private function levelCleared(levelId:int = 0):XML {
			if (levelId > 0){
				if (levelDetails.level[levelId+1].cleared != "Yes"){
					levelDetails.level[levelId+1].cleared =  "Yes";
				}
				return currentLevel(levelId+1);
			}
			else {
				return xml1;	
			}
		}
	}
}