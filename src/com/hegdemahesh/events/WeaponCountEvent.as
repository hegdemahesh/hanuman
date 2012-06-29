package com.hegdemahesh.events
{
	import starling.events.Event;
	
	public class WeaponCountEvent extends Event
	{
		public static const GET:String = "weaponCountEvent";
		public var count:int;
		public function WeaponCountEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}