package modules.login
{
	import flash.events.Event;

	/**
	 * 登录事件
	 * @author xumin.xu
	 *
	 */
	public class LoginEvent extends Event
	{
		/** 显示登录界面 */
		public static const LOGIN_SHOW:String = "loginShow";

		/** 登录 */
		public static const LOGIN:String = "login";

		/** 登录成功 */
		public static const LOGIN_SUCCEED:String = "loginSucceed";

		/** 登录失败 */
		public static const LOGIN_FAIL:String = "loginFail";

		public var data:*;

		public function LoginEvent(type:String, data:* = null)
		{
			super(type);
			this.data = data;
		}

	}
}
