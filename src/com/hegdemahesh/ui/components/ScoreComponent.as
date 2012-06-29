package com.hegdemahesh.ui.components
{
	import com.hegdemahesh.model.Assets;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class ScoreComponent extends Sprite
	{
		public var _score:int = 10000;
		
		public var texture1:starling.textures.Texture =  Assets.getTexture('ShowCardGothicBitmap');
		
		public var xml1:XML = XML(new Assets.ShowCardGothicXML());
		
		public var scoreText:TextField;
		
		public function ScoreComponent()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			TextField.registerBitmapFont(new BitmapFont(texture1,xml1));
			var headerText:TextField = new TextField(250, 30, "Score-", "Showcard Gothic", 50);
			headerText.fontSize = 24;
			headerText.color = Color.GREEN;
			this.addChild(headerText);
			
			scoreText = new TextField(120,30,_score.toString(),"Showcard Gothic",24);
			this.addChild(scoreText);
			scoreText.x = 120;
			
			
		}
		public function set score(sc:int):void {
			_score = sc;
			updateScore();
		}
		
		private function updateScore():void
		{
			// TODO Auto Generated method stub
			
		}
		public function get score():int {
			return _score;
		}
	}
}