package moudle.login
{
	import moudle.Controller;

	public class LoginController extends Controller
	{
		private var loginModel : LoginModel = null;

		private var loginView : LoginView = null;

		public function LoginController()
		{
			loginModel = new LoginModel();
			loginView = new LoginView();
			
			//loginView.show();
			
			dispatcher.dispatchEvent(new LoginEvent(LoginEvent.LOGIN_SUCCEED));
		}
		
		// ----------------------------------------
		//
		//		单例模式
		//
		// ----------------------------------------
		private static var _instance : LoginController;
		
		public static function start() : LoginController
		{
			return instance;
		}

		public static function get instance() : LoginController
		{
			if (_instance == null)
				_instance = new LoginController();
			return _instance;
		}

	}
}
