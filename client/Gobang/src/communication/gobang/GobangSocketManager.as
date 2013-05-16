package communication.gobang
{
	import com.netease.protobuf.Message;
	
	import modules.GameDispatcher;
	import modules.login.LoginEvent;
	
	import protobuf.SSPKG_LOGIN_REQ;
	
	import utils.Logger;

	public class GobangSocketManager
	{
		private static var instance:GobangSocketManager;

		public static function init():void
		{
			Logger.debug("登录socket模块初始化");
			if (instance == null)
			{
				instance = new GobangSocketManager();
			}
		}

		private var gobangSocket:GobangSocket;

		private var dispatcher:GameDispatcher = GameDispatcher.instance;

		public function GobangSocketManager()
		{
			addListeners();
		}

		private function addListeners():void
		{
			dispatcher.addEventListener(LoginEvent.LOGIN, onLogin);

			dispatcher.addEventListener(LoginEvent.LOGIN_SUCCEED, onLoginSucceed);
		}

		/**
		 * 初始化登录socket
		 */
		private function initLoginSocket():void
		{
			GobangSocket.init();
			gobangSocket = GobangSocket.instance;
		}

		/** 处理登录 */
		public function onLogin(event:LoginEvent):void
		{
			initLoginSocket();

			var userName:String = event.data.username;
			var password:String = event.data.password;

			var loginReq:SSPKG_LOGIN_REQ = new SSPKG_LOGIN_REQ();
			loginReq.account = userName;
			loginReq.password = password;

			doLogin(loginReq);
		}

		/** 登录 */
		private function doLogin(authRequest:Message):void
		{
			if (gobangSocket == null)
			{
				Logger.error("try login but server info is null.");
				return;
			}
			if (gobangSocket.hasConnected())
			{
				gobangSocket.send(SlotProto.SSID_LOGIN_REQ, authRequest);
			}
			else
			{
				gobangSocket.authRequest = authRequest;
				gobangSocket.connect();
			}
		}

		/**
		 * 处理登录成功
		 * @param event
		 */
		private function onLoginSucceed(event:LoginEvent):void
		{
			GobangMsgSender.init(gobangSocket);
		}
	}
}
