package moudle
{
	import moudle.findpath.FindpathController;
	import moudle.login.LoginController;
	import moudle.login.LoginEvent;
	import moudle.moveaction.MoveActionController;
	import moudle.scene.SceneController;
	import moudle.scene.SceneEvent;
	import moudle.scenemap.ScenemapController;
	import moudle.shortcuts.ShortcutsController;

	/**
	 * 控制游戏总流程
	 * @author 风之守望者 2012-7-1
	 */
	public class GameController extends Controller
	{
		public function GameController()
		{
			//开启登录模块
			dispatcher.addEventListener(LoginEvent.LOGIN_SUCCEED, onLoginSucceed);
			LoginController.start();
		}

		/**
		 * 处理登录成功事件
		 * @param event
		 */
		private function onLoginSucceed(event : LoginEvent) : void
		{
			dispatcher.removeEventListener(LoginEvent.LOGIN_SUCCEED, onLoginSucceed);

			//开启寻路模块
			FindpathController.start();
			
			//开启场景模块
			dispatcher.addEventListener(SceneEvent.SCENE_COMPLETED, onSceneCompleted);
			SceneController.start();
		}

		/**
		 * 场景初始化完成事件
		 * @param event
		 */
		private function onSceneCompleted(event : SceneEvent) : void
		{
			dispatcher.removeEventListener(SceneEvent.SCENE_COMPLETED, onSceneCompleted);

			//添加主角
			
			//注册快捷键
			ShortcutsController.start();
			
			//开启场景地图界面
			ScenemapController.start();
			
			//开启移动模块
			MoveActionController.start();
		}

		// ----------------------------------------
		//
		//		单例模式
		//
		// ----------------------------------------
		private static var _instance : GameController;
		
		public static function start() : GameController
		{
			return instance;
		}

		public static function get instance() : GameController
		{
			if (_instance == null)
				_instance = new GameController();
			return _instance;
		}

	}
}
