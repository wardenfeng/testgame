package communication.gobang
{
	import flash.events.Event;

	/**
	 * 老虎机协议事件
	 * @author xumin.xu
	 */
	public class GobangMsgEvent extends Event
	{
		
		
		public var data:*;

		public function GobangMsgEvent(type:String, data:* = null)
		{
			super(type);
			this.data = data;
		}

	}
}
