package moudle.resource
{
	import moudle.Controller;

	/**
	 * 
	 * @author 风之守望者 2012-7-4
	 */
	public class ResourceController extends Controller
	{
		public function ResourceController()
		{
			super();
		}

		// ----------------------------------------
		//
		//		单例模式
		//
		// ----------------------------------------
		private static var _instance : ResourceController;

		public static function start() : ResourceController
		{
			return instance;
		}

		public static function get instance() : ResourceController
		{
			if (_instance == null)
				_instance = new ResourceController();
			return _instance;
		}
	}
}
