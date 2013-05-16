package moudle.scene
{
	import flash.events.Event;


	/**
	 * 场景事件
	 * @author 风之守望者 2012-7-1
	 */
	public class SceneEvent extends Event
	{
		/**
		 * 场景初始化完成
		 */
		public static const SCENE_COMPLETED : String = "sceneCompleted";

		/**
		 * 附加数据
		 */
		public var data : Object;

		/**
		 * 场景事件
		 * @param type 事件类型
		 * @param data 附加数据
		 */
		public function SceneEvent(type : String, data : Object = null)
		{
			super(type);
			this.data = data;
		}
	}
}
