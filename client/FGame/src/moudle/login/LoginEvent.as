package moudle.login
{
	import flash.events.Event;


	/**
	 * 登录事件
	 * @author 风之守望者 2012-7-1
	 */
	public class LoginEvent extends Event
	{
		/**
		 *  登录成功
		 */
		public static const LOGIN_SUCCEED : String = "loginSucceed";

		/**
		 *  登录失败
		 */
		public static const LOGIN_FAIL : String = "loginFail";

		/**
		 * 附加数据
		 */
		public var data : Object;

		/**
		 * 登录事件
		 * @param type 事件类型
		 * @param data 附加数据
		 */
		public function LoginEvent(type : String, data : Object = null)
		{
			super(type);
			this.data = data;
		}
	}
}
