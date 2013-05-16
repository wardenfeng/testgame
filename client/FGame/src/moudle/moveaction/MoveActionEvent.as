package moudle.moveaction
{
	import flash.events.Event;


	/**
	 * 移动动作事件
	 * @author 风之守望者 2012-7-3
	 */
	public class MoveActionEvent extends Event
	{
		/**
		 * 主角开始移动
		 */
		public static const HERO_START_MOVE : String = "heroStartMove";

		/**
		 * 主角单步行走完成
		 */
		public static const HERO_STEP_COMPLETED : String = "heroStepCompleted";
		
		/**
		 * 主角到达目的地移动结束
		 */
		public static const HERO_END_MOVE : String = "heroEndMove";
		
		/**
		 * 附加数据
		 */
		public var data : Object;

		/**
		 * 移动动作事件
		 * @param type 事件类型
		 * @param data 附加数据
		 */
		public function MoveActionEvent(type : String, data : Object = null)
		{
			super(type);
			this.data = data;
		}
	}
}
