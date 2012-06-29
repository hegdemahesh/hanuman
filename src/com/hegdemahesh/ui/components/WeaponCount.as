package com.hegdemahesh.ui.components
{
	import com.hegdemahesh.model.Assets;
	
	import org.osmf.layout.HorizontalAlign;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class WeaponCount extends Sprite
	{
		private var img:Image = new Image(Assets.getAtlas().getTexture("stone_throw"));
		
		public var texture1:Texture =  Assets.getTexture('ShowCardGothicBitmap');
		
		public var xml1:XML = XML(new Assets.ShowCardGothicXML());
		private var _count:int = 0;
		
		public var headerText:TextField;
		
		public function WeaponCount(cnt:int = 0)
		{
			super();
			count = cnt;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		public function set count(c:int):void {
			_count = c;
			if (this.contains(headerText)){
				headerText.text = c.toString();
			}
		}
		public function get count():int {
			return _count;
		}
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			this.addChild(img);
			headerText = new TextField(30, 30, count.toString(), "Showcard Gothic", 50);
			headerText.fontSize = 30;
			headerText.color = Color.BLUE;
			headerText.hAlign =  HorizontalAlign.RIGHT;
			headerText.x = 33;
			headerText.y = 4;
			this.addChild(headerText);
		}
	}
}