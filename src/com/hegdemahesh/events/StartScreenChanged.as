package com.hegdemahesh.events
{
	import starling.events.Event;
	
	public class StartScreenChanged extends Event
	{
		public static const GET:String = "OnStartScreenChanged";
		public function StartScreenChanged(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}