package
{
	import flash.display.Sprite;
	import flash.display.Stage;

	/**
	 * 
	 * @author xumin.xu 2013-1-15
	 */
	
	public class UIAllRefer
	{
		public static var stage:Stage;
		
		/**
		 * 提示框层 
		 */		
		public static const tipLayer:Sprite = new Sprite();
		
		/**
		 * 提示信息层 
		 */		
		public static const infoLayer:Sprite = new Sprite();
		
		/**
		 * 弹窗层 
		 */		
		public static const popLayer:Sprite = new Sprite();
		
		/**
		 * 内容层 
		 */		
		public static const contentLayer:Sprite = new Sprite();
		
		/**
		 * 背景层
		 **/
		public static const backLayer:Sprite = new Sprite();
	}
}