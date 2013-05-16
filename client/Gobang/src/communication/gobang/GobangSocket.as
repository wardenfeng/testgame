package communication.gobang
{
	import com.netease.protobuf.Message;

	import flash.utils.ByteArray;

	import communication.ProtoFactory;
	import communication.SocketConnected;

	import modules.GameDispatcher;
	import modules.login.LoginEvent;

	import utils.Logger;

	public class GobangSocket extends SocketConnected
	{
		private static var _instance:GobangSocket;

		public static function init():void
		{
			if (_instance == null)
			{
				_instance=new GobangSocket(GlobalData.loginServerArray);
			}
		}


		public static function get instance():GobangSocket
		{
			return _instance;
		}

		private var msgProcesser:GobangMsgProcessor=GobangMsgProcessor.getInstance();

		public function GobangSocket(serverArray:Array)
		{
			super(serverArray);
		}

		private var _authRequest:Message=null;

		public function set authRequest(authRequest:Message):void
		{
			_authRequest=authRequest;
		}

		override protected function connectionComplete():void
		{
			Logger.debug("Login Socket connection Complete..");
			if (_authRequest != null)
			{
				send(SlotProto.SSID_LOGIN_REQ, _authRequest);
				_authRequest=null;
			}
		}

		override protected function connectFailed():void
		{
			super.connectFailed();

			GameDispatcher.instance.dispatchEvent(new LoginEvent(LoginEvent.LOGIN_FAIL));

			Logger.debug("登录服务器连接失败");
		}

		override protected function dispatchMessage(messageId:uint, data:ByteArray):void
		{
			super.dispatchMessage(messageId, data)
			ProtoFactory.getSlotProto().Decode(messageId, data, msgProcesser);
		}

	}
}
