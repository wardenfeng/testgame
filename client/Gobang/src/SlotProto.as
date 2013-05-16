package
{
	import flash.utils.Dictionary;
	import utils.Logger;
	import communication.gobang.*;
	import flash.utils.ByteArray;
	import protobuf.*;

	public class SlotProto
	{
		static public var SSID_LOGIN_REQ:uint=1;
		static public var SSID_LOGIN_ACK:uint=2;

		private function DecodeSSID_LOGIN_REQ(buf:ByteArray, proc:GobangMsgProcessor):void
		{
			
		}

		private function DecodeSSID_LOGIN_ACK(buf:ByteArray, proc:GobangMsgProcessor):void
		{
			try
			{
				var pkg:SSPKG_LOGIN_ACK=new SSPKG_LOGIN_ACK;
				pkg.mergeFrom(buf);
				proc.OnRecvLoginAck(pkg);
			}
			catch (error:Error)
			{
				Logger.debug("Error:");
				Logger.debug(error.message);
				Logger.debug(error.getStackTrace());
			}
		}

		private var DecodeFuncArray:Dictionary=new Dictionary();

		public function Init():void
		{
			DecodeFuncArray[SSID_LOGIN_REQ]=DecodeSSID_LOGIN_REQ;
			DecodeFuncArray[SSID_LOGIN_ACK]=DecodeSSID_LOGIN_ACK;
		}

		public function Decode(MsgID:uint, buf:ByteArray, proc:GobangMsgProcessor):void
		{
			var fun:Function=DecodeFuncArray[MsgID];
			if (fun != null)
				fun(buf, proc);
		}
	}
}
