package com.hegdemahesh.ui
{
	import com.hegdemahesh.model.Assets;
	
	import starling.display.Sprite;
	
	/**
	 * level related information stored in XML objects
	 */
	
	
	
	public class LevelLoader extends Sprite
	{
		
		public var xmllevel1:XML = XML(new com.hegdemahesh.model.Assets.level1XML());
		public var xmllevel2:XML = XML(new com.hegdemahesh.model.Assets.level2XML());
		
		public var levelDetails:XML = XML(new com.hegdemahesh.model.Assets.levelDetails());
		
		public function LevelLoader()
		{
			super();
			
			
		}
		
		public function currentLevel(levelId:String = null):XML {
			if (levelId == null){
				return xmllevel1;
			}
			else {
				return currentLevelXML(levelId);
			}
		}
		
		private function currentLevelXML(levelId:String):XML
		{
			// TODO Auto Generated method stub
			return this['xml'+levelId];
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
		
	}
}