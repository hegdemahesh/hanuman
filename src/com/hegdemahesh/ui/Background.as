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
	import com.hegdemahesh.ui.components.ParallaxSprite;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	public class Background extends Sprite
	{
		
		private var _gameXOffset:int;
		public function Background()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			var image:Image =  new Image(Assets.getTexture("bg"));
			//var parallax1:ParallaxSprite =  new ParallaxSprite("tail",100,2);
			var hills:ParallaxSprite = new ParallaxSprite("hills",450,12);
			var buildings:ParallaxSprite =  new ParallaxSprite("buildings2",435,8);
			var trees:ParallaxSprite = new ParallaxSprite("trees",465,4);
			var tileGround:ParallaxSprite =  new ParallaxSprite("tileGround",485,1);
			
			
			image.x = 0;
			image.y = 0;
			//addParallaxImage("tail",100);
			
			this.addChild(image);
			this.addChild(hills);
			this.addChild(buildings);
			this.addChild(trees);
			this.addChild(tileGround);
			//this.addChild(parallax1);
		}
		
		public function set gameXOffset(gameX:int):void {
			for (var i:int = 0; i < this.numChildren ; i++){
				if (this.getChildAt(i) is ParallaxSprite){
					(this.getChildAt(i) as ParallaxSprite).gameXOffset = gameX;
				}
				 
			}
			_gameXOffset = gameX;
			
		}
		public function get gameXOffset():int {
			return _gameXOffset;
		}
	}
}