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