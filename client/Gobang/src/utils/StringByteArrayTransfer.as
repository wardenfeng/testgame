package utils
{
	import flash.utils.ByteArray;

	public class StringByteArrayTransfer
	{
		/**
		 *  UTF-8 字符串转换成字节流
		 **/
		public static function convertStringToByteArray(string:String):ByteArray {
			var bytes:ByteArray;
			if (string) {
				bytes=new ByteArray();
				bytes.writeUTFBytes(string); // writeUTFBytes(value:String) 将 UTF-8 字符串写入字节流;
			}
			return bytes;
		}
		
		/**
		 * 字节流转换为 UTF-8 字符串
		 **/
		public static function convertByteArrayToString(byteArray:ByteArray):String
		{
			if(byteArray == null) return "";
			byteArray.position = 0;
			return byteArray.readUTFBytes(byteArray.length);
		}
	}
}