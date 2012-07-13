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
	import com.hegdemahesh.events.SponsorScreenChanged;
	import com.hegdemahesh.model.Assets;
	
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.utils.deg2rad;
	
	public class SponsorScreen extends Sprite
	{
		private var img:Image = new Image(Assets.getAtlas().getTexture('innoBrik'));
		private var developerImage:Image =  new Image(Assets.getAtlas().getTexture('developedBy'));
		
		public function SponsorScreen()
		{
			
			super();
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			developerImage.x = int((stage.stageWidth-img.width)/2)+ 80;
			developerImage.y = 0;
			this.addChild(developerImage);
			
			img.x = int((stage.stageWidth-img.width)/2);
			img.y = int((stage.stageHeight-img.height)/2);
			img.alpha = 0;
			this.addChild(img);
			
			addEffects();
			
		}
		
		
		
		public override function dispose():void {
			//sound = null;
			super.dispose();
		}
		private function onImgAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			animateLogo();
		}
		
		private function onDeveloperImageAddedToStage(event:Event):void
		{
			// TODO Auto Generated method stub
			animateText();
		}
		
		private function animateLogo():void {
			var tween:Tween = new Tween(img, 3.0, Transitions.EASE_IN_OUT);
			tween.animate("alpha", 1);
			//tween.animate("rotation", deg2rad(45));
			//tween.fadeTo(0);    // equivalent to 'animate("alpha", 0)'
			Starling.juggler.add(tween);
			
		}
		private function animateText():void {
			var tween:Tween = new Tween(developerImage, 3.0, Transitions.EASE_IN_OUT);
			tween.animate("y", 250);
			Starling.juggler.add(tween);
			tween.onComplete = onTweenComplete;
		}
		
		private function onTweenComplete():void
		{
			// TODO Auto Generated method stub
			//return null;
			var event:SponsorScreenChanged =  new SponsorScreenChanged(SponsorScreenChanged.GET);
			this.dispatchEvent(event);
			this.removeChild(img);
			this.removeChild(developerImage);
			img = null;
			developerImage = null;
			
		}
		
		private function addEffects():void
		{
			// TODO Auto Generated method stub
			animateLogo();
			animateText();
		}
	}
}