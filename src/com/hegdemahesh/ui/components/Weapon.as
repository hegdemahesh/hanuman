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
	import com.hegdemahesh.events.WeaponReleased;
	import com.hegdemahesh.model.Constants;
	
	
	import flashx.textLayout.elements.SpecialCharacterElement;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;

	public class Weapon extends Sprite
	{
		
		public var mouseDown:Boolean = false;
		public var actor:Actor;
		public var mouseX:int;
		public var mouseY:int;
		
		public var imgsrc:String;
		
		public var weaponX:int;
		public var weaponY:int;
		
		private var weaponStartX:int;
		private var weaponStartY:int;
		
		private var xSpeed:int;
		private var ySpeed:int;
		
		private var hanumanTail:Tail = new Tail("tail");
		
		public function loadWeapon():void {
			//actor = new Actor(src);
			if (actor == null){
				actor =  new Actor(imgsrc);
			}
			if (this.contains(actor) == false){
				this.addChild(actor);
			}
			actor.x = weaponStartX;
			actor.y = weaponStartY;
		}
		
		public function moveActor(moveX:int,moveY:int):void {
			
			var xdif:int = weaponStartX - moveX;
			var ydif:int = weaponStartY - moveY;
			
			if (xdif < 0){
				xdif = 0;
			}
			if (ydif > 0){
				ydif = 0;
			}
			if (xdif > Constants.WEAPON_EXTREME_X){
				xdif = Constants.WEAPON_EXTREME_X;
			}
			if (ydif < (-Constants.WEAPON_EXTREME_Y)){
				ydif = -Constants.WEAPON_EXTREME_Y;
			}
			actor.x = weaponStartX - xdif;
			actor.y = weaponStartY - ydif;
			
			moveTail(xdif,ydif);
			//this.width = moveX+39;
		
		}
		
		public function moveTail(xdif:int,ydif:int):void {
			
			//hanumanTail.rotation = deg2rad(-20);
			var yFact:Number = 120+ydif;
			var teta:Number = Number(Math.atan(xdif/yFact));
			var scaleFact:Number = Math.sqrt((xdif*xdif)+(yFact*yFact))/120;
			//trace(teta+'and'+ xdif+'and'+ ydif);
			hanumanTail.scaleX  = (scaleFact*2+1)/3;
			hanumanTail.scaleY = (scaleFact*2+1)/3;
			hanumanTail.rotation = -teta;
		}
		
		public function Weapon(wX:int,wY:int,src:String=null)
		{
			if (src != null){
				
				actor =  new Actor(src);
				//moveActor(wX,wY);
				actor.x = wX;
				actor.y = wY;
				hanumanTail.x = wX+ 33;
				hanumanTail.y = wY+ 98;
				weaponStartX = wX;
				weaponStartY = wY;
				imgsrc = src;
				this.addChild(hanumanTail);
				
			}
			
			//this.width = 220;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		
		public function onAddedToStage(event:Event):void {
			
			this.addChild(actor);
			actor.addEventListener(starling.events.TouchEvent.TOUCH,onStoneTouch);
			this.addEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			// TODO Auto Generated method stub
			if (mouseDown == false){
				var xdif:int = weaponStartX - actor.x ;
				var ydif:int = actor.y - weaponStartY ;
				
				if (xdif > 0){
					xdif = int(xdif/1.5);
				}
				if (ydif > 0){
					ydif = int(ydif/1.5);
				}
				actor.x = weaponStartX - xdif;
				actor.y = weaponStartY + ydif;
				
				if (hanumanTail.scaleX < 1.02){
					hanumanTail.scaleX = 1;
				}
				if (hanumanTail.scaleY < 1.02){
					hanumanTail.scaleY = 1;
				}
				if (hanumanTail.scaleX > 0.98){
					hanumanTail.scaleX = 1;
				}
				if (hanumanTail.scaleY > 0.98){
					hanumanTail.scaleY = 1;
				}
				if (hanumanTail.scaleX > 1){
					hanumanTail.scaleX = hanumanTail.scaleX / 1.5;
				}
				if (hanumanTail.scaleX < 1){
					hanumanTail.scaleX = hanumanTail.scaleX * 15;
				}
				if (hanumanTail.scaleY > 1){
					hanumanTail.scaleY = hanumanTail.scaleY / 1.5;
				}
				if (hanumanTail.scaleY < 1){
					hanumanTail.scaleY = hanumanTail.scaleY * 1.5;
				}
				if (hanumanTail.rotation > -0.005){
					hanumanTail.rotation = 0;
				}
				if (hanumanTail.rotation < 0){
					hanumanTail.rotation = deg2rad(rad2deg(hanumanTail.rotation ) / 1.5);
				}
			}
		}		
		
		
		
		public function moveWeapon(mouseX:int,mouseY:int):void {
			if (mouseDown == true){
				moveActor(mouseX,mouseY);
			}
		}
		private function releaseWeapon():void {
			var xdif:int = weaponStartX - actor.x;
			var ydif:int = weaponStartY - actor.y;
			
			this.removeChild(actor);
			
			var event1:WeaponReleased =  new WeaponReleased(WeaponReleased.GET);
			event1.xSpeed = xdif ;
			event1.ySpeed = ydif ;
			this.dispatchEvent(event1);
		}
		
		private function onStoneTouch(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			
			var target:DisplayObject = event.target as DisplayObject;
			
			//trace("Mouse interacted");
			
			
			if(event.getTouch(target, TouchPhase.HOVER))
			{
				// mouse moving while up
				/*mouseX = event.getTouch(target, TouchPhase.HOVER).globalX-weaponX;
				mouseY = event.getTouch(target, TouchPhase.HOVER).globalY-weaponY;
				moveWeapon(mouseX,mouseY);*/
			}
			
			if(event.getTouch(target, TouchPhase.MOVED))
			{
				// mouse moving while down
				mouseX = event.getTouch(target, TouchPhase.MOVED).globalX-weaponX;
				mouseY = event.getTouch(target, TouchPhase.MOVED).globalY-weaponY;
				moveWeapon(mouseX,mouseY);
			}
			
			if(event.getTouch(target, TouchPhase.BEGAN)&&!mouseDown)
			{
				// mouse down
				mouseDown = true;
				weaponX = event.getTouch(target, TouchPhase.BEGAN).getLocation(actor).x- int(actor.image.width/2);
				weaponY = event.getTouch(target, TouchPhase.BEGAN).getLocation(actor).y- int(actor.image.height/2);
				//trace(weaponX);
				mouseX = event.getTouch(target, TouchPhase.BEGAN).globalX-weaponX;
				mouseY = event.getTouch(target, TouchPhase.BEGAN).globalY-weaponY;
				//moveWeapon(mouseX,mouseY);
				
			}
			else if(event.getTouch(target, TouchPhase.ENDED)&&mouseDown)
			{
				mouseDown = false;
				releaseWeapon();
			}
			
			
		}
	}
}