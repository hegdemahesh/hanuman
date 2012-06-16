package com.hegdemahesh.ui
{
	import com.hegdemahesh.events.WeaponReleased;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class Weapon extends Sprite
	{
		
		public var mouseDown:Boolean = false;
		public var actor:Actor;
		public var mouseX:int;
		public var mouseY:int;
		
		public var weaponX:int;
		public var weaponY:int;
		
		public function moveActor(moveX:int,moveY:int):void {
			
			actor.x = moveX;
			actor.y = moveY;
			//this.width = moveX+39;
		
		}
		
		public function Weapon(weaponX:int,weaponY:int,src:String=null)
		{
			if (src != null){
				
				actor =  new Actor(src);
				moveActor(weaponX,weaponY);
				
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
			
		}		
		
		/*private function onTouch(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			var event1:WeaponReleased =  new WeaponReleased(WeaponReleased.GET);
			event1.xSpeed = 100;
			event1.ySpeed = 100;
			this.dispatchEvent(event1);
		}*/
		
		public function moveWeapon(mouseX:int,mouseY:int):void {
			if (mouseDown == true){
				moveActor(mouseX,mouseY);
			}
		}
		private function releaseWeapon(xSpeed:int,ySpeed:int):void {
			var event1:WeaponReleased =  new WeaponReleased(WeaponReleased.GET);
			event1.xSpeed = xSpeed;
			event1.ySpeed = ySpeed;
			this.dispatchEvent(event1);
		}
		
		private function onStoneTouch(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			
			var target:DisplayObject = event.target as DisplayObject;
			
			trace("Mouse interacted");
			
			
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
				trace(weaponX);
				mouseX = event.getTouch(target, TouchPhase.BEGAN).globalX-weaponX;
				mouseY = event.getTouch(target, TouchPhase.BEGAN).globalY-weaponY;
				//moveWeapon(mouseX,mouseY);
				
			}
			else if(event.getTouch(target, TouchPhase.ENDED)&&mouseDown)
			{
				mouseDown = false;
				releaseWeapon(mouseX,mouseY);
			}
			
			
		}
	}
}