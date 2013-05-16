package
{
	import com.junkbyte.console.Cc;
	import com.junkbyte.console.addons.autoFocus.CommandLineAutoFocusAddon;
	import com.junkbyte.console.addons.displaymap.DisplayMapAddon;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import communication.ServerAddress;
	import communication.gobang.GobangSocketManager;
	
	import modules.GameDispatcher;
	import modules.login.Login;
	import modules.login.LoginEvent;
	
	import utils.Logger;

	[SWF(frameRate = "30", width = "1000", height = "650")]
	public class Game extends Sprite
	{
		public function Game()
		{
			Security.allowDomain("*");

			var menu0:ContextMenuItem = new ContextMenuItem("Gobang\t" + GlobalData.VERSION, true, true, true);
			var viewContextMenu:ContextMenu = new ContextMenu();
			viewContextMenu.customItems = [menu0];
			contextMenu = viewContextMenu;

			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}

		private function onAddToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);

			UIAllRefer.stage = this.stage;

			this.stage.addChild(UIAllRefer.backLayer);
			this.stage.addChild(UIAllRefer.contentLayer);
			this.stage.addChild(UIAllRefer.popLayer);
			this.stage.addChild(UIAllRefer.infoLayer);
			this.stage.addChild(UIAllRefer.tipLayer);

			initFlashConsole();

			Logger.debug("客户端版本：" + GlobalData.VERSION);

			initMoudles();

			//获取 登录服务器 配置信息
			GlobalData.loginServerArray = [];
			var loadXML:URLLoader = new URLLoader(new URLRequest(GlobalData.rootPath+"config.xml"));
			loadXML.addEventListener(Event.COMPLETE, function loadXMLHandler(event:Event):void
			{
				var config:XML = XML(loadXML.data);
				config.ignoreWhitespace = true;

				//初始化登录服务器列表
				var server:ServerAddress = new ServerAddress();
				server.host = config.server.host;
				server.port = config.server.port;
				server.policy = config.server.policy;

				GlobalData.policy = config.server.policy;

				GlobalData.loginServerArray.push(server);

				GameDispatcher.instance.dispatchEvent(new LoginEvent(LoginEvent.LOGIN_SHOW));

			});
		}

		/**
		 * 初始化模块
		 **/
		private function initMoudles():void
		{
			Login.init();

			GobangSocketManager.init();

		}

		/**
		 * 初始化控制台
		 **/
		public function initFlashConsole():void
		{
			//
			// SETUP - only required once
			//
			// you must modify the styles before starting console.
			Cc.config.style.big(); // BIGGER text. this modifies the config variables such as traceFontSize, menuFontSize
			Cc.config.style.whiteBase(); // Black on white. this modifies the config variables such as priority0, priority1, etc
			Cc.config.style.backgroundAlpha = 0.6; // makes it non-transparent background.

			Cc.startOnStage(this, "`"); // "`" - change for password. This will start hidden
			Cc.commandLine = true; // enable command line
			Cc.config.commandLineAllowed = true;

			Cc.width = stage.stageWidth;
			Cc.height = stage.stageHeight;

			DisplayMapAddon.registerCommand();
			DisplayMapAddon.addToMenu("DM"); // DisplayMapper. click on DM button at top menu to start.

			CommandLineAutoFocusAddon.registerToConsole(); // this addon auto focus to commandline when console becomes visible
		}

	}
}
