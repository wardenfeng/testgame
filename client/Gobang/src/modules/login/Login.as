package modules.login
{
	public class Login
	{
		public static var viewPath:String="view/login.swf";

		private static var loginViewManager:LoginViewManager;

		/** 登录中 */
		public static var logining:Boolean=false;

		public static function init():void
		{
			loginViewManager=new LoginViewManager();
		}
	}
}