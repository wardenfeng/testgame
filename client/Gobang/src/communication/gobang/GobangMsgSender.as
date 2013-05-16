package communication.gobang
{
	import com.netease.protobuf.Message;

	import modules.GameDispatcher;

	import utils.Logger;

	/**
	 * 发送对麻将服务器的请求
	 * @author xumin.xu
	 */
	public class GobangMsgSender
	{
		private static var _instance:GobangMsgSender;

		private var slotSocket:GobangSocket;

		public static function get instance():GobangMsgSender
		{
			return _instance;
		}

		public static function init(slotSocket:GobangSocket):void
		{
			if (_instance == null)
			{
				Logger.debug("初始化麻将消息发送者");
				_instance=new GobangMsgSender(slotSocket);
			}
		}

		public function GobangMsgSender(slotSocket:GobangSocket)
		{
			addListeners();
			this.slotSocket=slotSocket;
		}

		private function get dispatcher():GameDispatcher
		{
			return GameDispatcher.instance;
		}

		private function send(msgId:uint, message:Message):void
		{
			slotSocket.send(msgId, message);
		}

		private function addListeners():void
		{

		}



	}
}
