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
	import com.hegdemahesh.model.Constants;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class FireBackground extends Sprite
	{
		public var _contentWidth:int = 850;
		public function FireBackground(contentWidth:int = 0)
		{
			super();
			this._contentWidth = contentWidth;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			for (var i:int = 0; i < _contentWidth; i=i + Constants.FIRE_PIC_WIDTH ){
				var movieClip:MovieClip = new MovieClip(Assets.getAtlas().getTextures("fire"));
				movieClip.x = i;
				movieClip.y = 0;
				movieClip.currentFrame = int(Math.random() * 35);
				movieClip.fps = 25;
				this.addChild(movieClip);
				movieClip.play();
				Starling.juggler.add(movieClip);
				
				
			}
		}
	}
}