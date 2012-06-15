package com.hegdemahesh.ui
{
	import com.hegdemahesh.events.WeaponReleased;
	
	import starling.events.Event;
	import starling.events.TouchEvent;

	public class Weapon extends Actor
	{
		public function Weapon(src:String=null)
		{
			super(src);
			
		}
		public override function onAddedToStage(event:Event):void {
			this.addChild(image);
			pivotX = width >> 1;
			pivotY = height >> 1;
			this.addEventListener(starling.events.TouchEvent.TOUCH,onTouch);
			
		}
		
		
		
		private function onTouch(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			var event1:WeaponReleased =  new WeaponReleased(WeaponReleased.GET);
			event1.xSpeed = 100;
			event1.ySpeed = 100;
			this.dispatchEvent(event1);
		}
	}
}