package moudle.scenemap
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	import moudle.Controller;


	/**
	 * 管理M键呼出场景地图
	 * @author 风之守望者 2012-7-2
	 */
	public class ScenemapController extends Controller
	{
		/** 场景地图 */
		private var scenemapview : ScenemapView;

		public function ScenemapController()
		{
			scenemapview = new ScenemapView();
			dispatcher.addEventListener(ScenemapEvent.SCENEMAP_SHOW, onScenemapShowClose);
			dispatcher.addEventListener(ScenemapEvent.SCENEMAP_CLOSE, onScenemapShowClose);
			dispatcher.addEventListener(ScenemapEvent.SCENEMAP_SHOW_CLOSE, onScenemapShowClose);
		}

		private function onScenemapShowClose(event : ScenemapEvent) : void
		{
			Scenemap.isShow ? scenemapview.close() : scenemapview.show();
		}

		private function onScenemapShow(event : ScenemapEvent) : void
		{
			scenemapview.show();
		}

		private function onScenemapClose(event : ScenemapEvent) : void
		{
			scenemapview.close();
		}

		// ----------------------------------------
		//
		//		单例模式
		//
		// ----------------------------------------
		private static var _instance : ScenemapController;

		public static function start() : ScenemapController
		{
			return instance;
		}

		public static function get instance() : ScenemapController
		{
			if (_instance == null)
				_instance = new ScenemapController();
			return _instance;
		}

	}
}
