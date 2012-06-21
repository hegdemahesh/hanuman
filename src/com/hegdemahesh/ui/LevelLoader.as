package com.hegdemahesh.ui
{
	import com.hegdemahesh.model.Assets;
	
	import starling.display.Sprite;
	
	/**
	 * level related information stored in XML objects
	 */
	
	
	
	public class LevelLoader extends Sprite
	{
		
		public var xmlLevel1:XML = XML(new com.hegdemahesh.model.Assets.level1XML());
		public var xmlLevel2:XML = XML(new com.hegdemahesh.model.Assets.level2XML());
		
		public function LevelLoader()
		{
			super();
			
			
		}
		
		public function currentLevel(levelId:String = null):XML {
			if (levelId == null){
				return xmlLevel1;
			}
			else {
				return currentLevelXML(levelId);
			}
		}
		
		private function currentLevelXML(levelId:String):XML
		{
			// TODO Auto Generated method stub
			if (levelId == 'level1'){
				return xmlLevel1;
			}
			else if (levelId == 'level2'){
				return xmlLevel2;
			}
			else {
				return null;
			}
			
		}
		
	}
}