package moudle.findpath
{
	import flash.events.Event;

	import moudle.Controller;
	import moudle.scene.SceneConfig;


	/**
	 * 处理寻路逻辑
	 * @author 风之守望者 2012-7-3
	 */
	public class FindpathController extends Controller
	{
		/** A*算法类 */
		private var astar : AStar;

		public function FindpathController()
		{
			dispatcher.addEventListener("config_load_completed", configLoadCompleted);
			dispatcher.addEventListener(FindpathEvent.FIND_PATH, onFindPath);
		}

		/**
		 * 初始化A*类
		 */
		private function configLoadCompleted(event : Event) : void
		{
			trace("初始化A*算法类");
			var mapTileModel : MapTileModel = new MapTileModel();
			mapTileModel.mapData = SceneConfig.mapData;
			astar = new AStar(mapTileModel);
		}

		/**
		 * 处理寻找路径事件
		 */
		private function onFindPath(event : FindpathEvent) : void
		{
			event.path = astar.Find(event.startX, event.startY, event.endX, event.endY);
		}

		// ----------------------------------------
		//
		//		单例模式
		//
		// ----------------------------------------
		private static var _instance : FindpathController;

		public static function start() : FindpathController
		{
			return instance;
		}

		public static function get instance() : FindpathController
		{
			if (_instance == null)
				_instance = new FindpathController();
			return _instance;
		}
	}
}
