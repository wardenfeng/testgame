package utils
{
	import com.junkbyte.console.Cc;

	public final class Logger
	{

		public static var isDebug:Boolean = true;

		public static function debug(logStr:String):void
		{
			if (isDebug)
			{
				Cc.debug(new Date().toLocaleTimeString() +" "+ logStr);
			}
		}

		public static function info(logStr:String):void
		{
			Cc.info(new Date().toLocaleTimeString() +" "+ logStr);
		}

		public static function error(logStr:String):void
		{
			Cc.error(new Date().toLocaleTimeString() +" "+ logStr);
		}

	}
}
