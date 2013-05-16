package utils
{
	

	/**
	 * 对小数处理
	 * @author xumin.xu
	 */
	public class FloatHandler
	{
		/**
		 * 处理服务器端传来的浮点数
		 */
		private static function fourFormat(value:Number):Number
		{
			//保留小数点后四位 并且四舍五入
			var value1:int = value;
			var value2:Number = value - value1;
			value2 = int((value2 * 100000 + 5) / 10) / 10000;

			var newValue:Number = value1 + value2;
			return newValue;
		}

		/**
		 *保留小数点后两位 并且四舍五入
		 */
		public static function TwoFormat(value:Number):Number
		{
			var value1:int = value;
			var value2:Number = value - value1;
			value2 = int((value2 * 1000 + 5) / 10) / 100;

			var newValue:Number = value1 + value2;
			return newValue;
		}

		public static function TwoFormatToString(value:Number):String
		{
			var value1:Number = TwoFormat(value);
			return value1.toFixed(2);
		}
		
	}
}
