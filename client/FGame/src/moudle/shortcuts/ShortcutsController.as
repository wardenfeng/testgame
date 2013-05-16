package moudle.shortcuts
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	import moudle.Controller;
	import moudle.scenemap.ScenemapEvent;


	/**
	 * 快捷键管理者
	 * @author 风之守望者 2012-7-2
	 */
	public class ShortcutsController extends Controller
	{
		public function ShortcutsController()
		{
			CommonData.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}

		private function onKeyUp(event : KeyboardEvent) : void
		{
			switch (event.keyCode)
			{
				//打开或关闭地图
				case Keyboard.M:
				{
					dispatcher.dispatchEvent(new ScenemapEvent(ScenemapEvent.SCENEMAP_SHOW_CLOSE));
					break;
				}

				default:
				{
					break;
				}
			}
		}

		// ----------------------------------------
		//
		//		单例模式
		//
		// ----------------------------------------
		private static var _instance : ShortcutsController;

		public static function start() : ShortcutsController
		{
			return instance;
		}

		public static function get instance() : ShortcutsController
		{
			if (_instance == null)
				_instance = new ShortcutsController();
			return _instance;
		}
	}
}
