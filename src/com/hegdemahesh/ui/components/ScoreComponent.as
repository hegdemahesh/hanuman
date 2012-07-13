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
	import com.hegdemahesh.model.Assets;
	import com.hegdemahesh.vos.Level;
	
	import org.osmf.layout.HorizontalAlign;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class ScoreComponent extends Sprite
	{
		public var _score:int = 0;
		
		public var texture1:starling.textures.Texture =  Assets.getTexture('ShowCardGothicBitmap');
		
		public var xml1:XML = XML(new Assets.ShowCardGothicXML());
		
		public var scoreText:TextField;
		
		public var levelText:TextField;
		
		public var level:Level;
		
		public var headerText:TextField;
		
		public function ScoreComponent(levelC:Level= null)
		{
			super();
			if (levelC != null){
				level =  levelC;
				this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
			}
			else {
				level = new Level();
				level.levelName = "";
				level.levelId = 0;
			}
		}
		
		public function set score(sc:int):void {
			_score = sc;
			headerText.text = "Score - " + sc.toString();
		}
		public function get score():int {
			return _score;
		}
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			TextField.registerBitmapFont(new BitmapFont(texture1,xml1));
			headerText = new TextField(160, 30, "Score - "+ _score, "Showcard Gothic", 50);
			headerText.fontSize = 30;
			headerText.x = 82;
			headerText.hAlign = HorizontalAlign.RIGHT;
			headerText.color = Color.WHITE;
			this.addChild(headerText);
			
			/*scoreText = new TextField(120,30,_score.toString(),"Showcard Gothic",24);
			this.addChild(scoreText);
			scoreText.x = 122;
			scoreText.hAlign = HorizontalAlign.RIGHT;*/
			
			levelText =  new TextField(120,30,"Level - "+level.levelId.toString(),"Showcard Gothic",24);
			levelText.x = 120;
			levelText.y = 25;
			levelText.hAlign = HorizontalAlign.RIGHT;
			levelText.color = Color.PURPLE;
			this.addChild(levelText);
			
			
		}
		
	}
}