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
	import com.hegdemahesh.events.ActionButtonEvent;
	import com.hegdemahesh.model.Assets;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ActionButton extends Sprite
	{
		public var img:Button =  new Button(Assets.getAtlas().getTexture('buttonBg'));
		private var iconImg:Image ;
		private var iconURL:String;
		public function ActionButton(iconImgURL:String =  "")
		{
			super();
			if (iconImgURL!= ""){
				this.iconImg =  new Image(Assets.getAtlas().getTexture(iconImgURL));
				this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
				this.iconURL = iconImgURL;
			}
			
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			this.addChild(img);
			this.addChild(iconImg);
			iconImg.touchable = false;
			iconImg.x = (img.width-iconImg.width)/2;
			iconImg.y = (img.height-iconImg.height)/2;
			this.addEventListener(starling.events.TouchEvent.TOUCH,onTouch);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			var target:DisplayObject = event.target as DisplayObject;
			
			
			if(event.getTouch(target, TouchPhase.ENDED))
			{
				var ev:ActionButtonEvent =  new ActionButtonEvent(ActionButtonEvent.GET);
				ev.actionString = iconURL;
				this.dispatchEvent(ev);
				//this.removeFromParent(true);
				
			}
		}
	}
}