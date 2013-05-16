package
{
	import flash.display.Sprite;

	public class GlobalData
	{
		/**
		 * 版本号
		 **/
		public static const VERSION:String = "2013.2.1 11:35";
		
		public static const rootPath:String = "";
		
		public static const uiLayer:Sprite = new Sprite();
		
		/** 登录服务器列表 */
		public static var loginServerArray:Array;
		
		/** 默认策略端口 */
		public static var policy:uint;
		
		/** 用户名 */
		[Bindable]
		public static var username:String = "";
		
	}
}
