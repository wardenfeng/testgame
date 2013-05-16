package modules.login
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import communication.ServerAddress;
	
	import fla.view.login.LoginView;
	
	import modules.GameDispatcher;
	
	import utils.Logger;
	import utils.MCToButton;

	public class LoginViewManager
	{
		private var mainView:MovieClip;
		
		private var dispatcher:GameDispatcher = GameDispatcher.instance;
		
		public function LoginViewManager()
		{
			dispatcher.addEventListener(LoginEvent.LOGIN_SHOW, function(event:LoginEvent):void
			{
				show();
			});
			
			dispatcher.addEventListener(LoginEvent.LOGIN_SUCCEED, function(event:LoginEvent):void
			{
				close();
				Login.logining=false;
			});
			
			dispatcher.addEventListener(LoginEvent.LOGIN_FAIL, function(event:LoginEvent):void
			{
				Logger.debug("登录失败");
			});
		}
		
		public function init():void
		{
			mainView = new LoginView();
			
			MCToButton.make(mainView.login_btn);
			
			show();
		}
		
		public function show():void
		{
			if(mainView == null)
			{
				init();
				return;
			}
			
			UIAllRefer.contentLayer.addChild(mainView);
			
			addListeners();
		}
		
		public function close():void
		{
			removeListeners();
			
			UIAllRefer.contentLayer.removeChild(mainView);
		}
		
		private function addListeners():void
		{
			mainView.login_btn.addEventListener(MouseEvent.CLICK,onLoginBtnClick);
		}
		
		private function removeListeners():void
		{
			mainView.login_btn.removeEventListener(MouseEvent.CLICK,onLoginBtnClick);
			
		}
		
		private function onLoginBtnClick(event:MouseEvent):void
		{
			switch(event.currentTarget)
			{
				case mainView.login_btn:
					onLogin(mainView.username_txt.text,mainView.password_txt.text);
					break;
			}
		}
		
		private function onLogin(userName:String,password:String):void
		{
			if (Login.logining)
			{
				return;
			}
			if (userName == "")
			{
				Logger.debug("user name can not be null.");
				return;
			}
			
			if (password == "")
			{
				Logger.debug("password can not be null.");
				return;
			}
			Login.logining = true;
			Logger.debug("login. please wait...");
			
			//修改登录服务器的host
			var server:ServerAddress = GlobalData.loginServerArray[0];
			
			GlobalData.username = userName;
			
			//登录
			dispatcher.dispatchEvent(new LoginEvent(LoginEvent.LOGIN, {username: userName, password: password}));
			
		}
	}
}