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
	
	import nape.phys.Body;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Actor extends Sprite
	{
		public var image:Image ;
		public var body:Body;
		public var imgSrc:String;
		
		public var idString:String;
		public var xcord:int;
		public var ycord:int;
		public var material:String;
		public var flammable:Boolean;
		public var isWeapon:Boolean = false;
		public var crushable:Boolean = false;
		public var crushed:Boolean = false;
		
		public var damage:Number = 0;
		
		public function Actor(src:String=null)
		{
			
			if (src!= null){
				imgSrc = src;
				image =  new Image(Assets.getAtlas().getTexture(src));
				this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
			}
			
			super();
			
		}
		
		public function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			this.addChild(image);
			pivotX = width >> 1;
			pivotY = height >> 1;
		}
	}
}