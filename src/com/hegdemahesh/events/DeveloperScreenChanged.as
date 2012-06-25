package com.hegdemahesh.events
{
	import starling.events.Event;
	
	public class DeveloperScreenChanged extends Event
	{
		public static const GET:String = "developerScreenChanged";
		public function DeveloperScreenChanged(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}