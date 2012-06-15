package com.hegdemahesh.events
{
	import starling.events.Event;
	
	public class WeaponReleased extends Event
	{
		public static const GET:String = "weaponReleasedEvent";
		public var xSpeed:int;
		public var ySpeed:int;
		public function WeaponReleased(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}