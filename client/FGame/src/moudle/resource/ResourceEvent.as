package moudle.resource
{
	import flash.events.Event;
	
	/**
	 * 
	 * @author 风之守望者 2012-8-1
	 */	
	public class ResourceEvent extends Event
	{
		public var url:String;
		
		public var data:Object;
		
		public function ResourceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}