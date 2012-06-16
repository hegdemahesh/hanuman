package com.hegdemahesh.ui
{
	import com.hegdemahesh.events.WeaponReleased;
	import com.hegdemahesh.model.Constants;
	
	import de.polygonal.ds.NullIterator;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.deg2rad;

	public class Weapon extends Sprite
	{
		
		public var mouseDown:Boolean = false;
		public var actor:Actor;
		public var mouseX:int;
		public var mouseY:int;
		
		public var weaponX:int;
		public var weaponY:int;
		
		private var weaponStartX:int;
		private var weaponStartY:int;
		
		private var hanumanTail:Tail = new Tail("tail");
		
		public function moveActor(moveX:int,moveY:int):void {
			
			var xdif:int = weaponStartX - moveX;
			var ydif:int = weaponStartY - moveY;
			
			if (xdif < 0){
				xdif = 0;
			}
			if (ydif > 0){
				ydif = 0;
			}
			if (xdif > Constants.weaponExtermeX){
				xdif = Constants.weaponExtermeX;
			}
			if (ydif < (-Constants.weaponExtremeY)){
				ydif = -Constants.weaponExtremeY;
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
			hanumanTail.scaleX  = scaleFact;
			hanumanTail.scaleY = scaleFact;
			hanumanTail.rotation = -teta;
		}
		
		public function Weapon(wX:int,wY:int,src:String=null)
		{
			if (src != null){
				
				actor =  new Actor(src);
				//moveActor(wX,wY);
				actor.x = wX;
				actor.y = wY;
				hanumanTail.x = wX+ 81-48;
				hanumanTail.y = wY+ 120-22;
				weaponStartX = wX;
				weaponStartY = wY;
				//hanumanTail.pivotX = 81;
				//hanumanTail.pivotY = 120;
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
			
		}		
		
		
		
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
				releaseWeapon(mouseX,mouseY);
			}
			
			
		}
	}
}