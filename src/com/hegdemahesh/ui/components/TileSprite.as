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