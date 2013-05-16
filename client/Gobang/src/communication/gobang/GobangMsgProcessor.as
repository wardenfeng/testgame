package communication.gobang
{
	import communication.MsgProcesser;

	import modules.login.LoginEvent;

	import protobuf.SSPKG_LOGIN_ACK;

	import utils.Logger;

	public final class GobangMsgProcessor extends MsgProcesser
	{


		private static var _instance:GobangMsgProcessor;

		public static function getInstance():GobangMsgProcessor
		{
			if (_instance == null)
			{
				_instance=new GobangMsgProcessor();
			}
			return _instance;
		}

		public function OnRecvLoginAck(pkg:SSPKG_LOGIN_ACK):void
		{
			if (pkg.success)
			{
				Logger.debug("登录成功.");
				dispatcher.dispatchEvent(new LoginEvent(LoginEvent.LOGIN_SUCCEED, pkg));

			}
			else
			{
				Logger.debug("登录失败");
				dispatcher.dispatchEvent(new LoginEvent(LoginEvent.LOGIN_FAIL, pkg));
			}
		}

	}
}
