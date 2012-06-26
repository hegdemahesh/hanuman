package com.hegdemahesh.events
{
	import com.hegdemahesh.vos.Level;
	
	import starling.events.Event;
	
	public class LoadLevelEvent extends Event
	{
		public static const GET:String =  "loadLevelEvent";
		public var level:Level;
		public function LoadLevelEvent(type:String, bubbles:Boolean=true, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}