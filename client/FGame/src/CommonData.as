package
{
	import animation.Animal;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;

	import moudle.GameDispatcher;

	/**
	 * 游戏全局数据
	 * @author 风之守望者 2012-6-29
	 */
	public class CommonData
	{
		/** 场景宽度 */
		public static var stageWidth : Number;

		/** 场景高度 */
		public static var stageHeight : Number;

		/** 游戏实体 */
		public static var game : FGame;

		/** 舞台 */
		public static var stage : Stage;

		/** 场景层 */
		public static var sceneLayer : Sprite;

		/** 界面层 */
		public static var viewLayer : Sprite;

		/** 主角 */
		public static var hero : Animal;

		/** 事件适配器 */
		public static var gameDispather : GameDispatcher = GameDispatcher.getInstance();

		// ----------------------------------------
		//
		//		调试配置
		//
		// ----------------------------------------

		/** 是否显示 */
		public static var isShowGird : Boolean = false;

	}
}
