package communication
{
	import com.netease.protobuf.Message;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import utils.Logger;

	public class SocketConnected
	{

		private var socket:Socket;

		protected var _serverArray:Array = null;

		protected var currentServerIndex:int = 0;

		private var reconnecting:Boolean = false;

		private static const HEADER_LENGTH:uint = 4;

		private static const MESSAGE_ID_LENGTH:uint = 4;

		private static const MAGIC_NUMBER_LENGTH:uint = 4;

		private static const DESCRIPTION_LENGTH:uint = HEADER_LENGTH + MESSAGE_ID_LENGTH + MAGIC_NUMBER_LENGTH;

		private static const MAGIC_NUMBER:uint = 0x98765432;

		private var bytesRecieved:ByteArray = new ByteArray();

		public function SocketConnected(serverArray:Array):void
		{
			_serverArray = serverArray;
			socket = new Socket();
			configureListeners(socket);
		}

		private function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.CLOSE, closeHandler);
			dispatcher.addEventListener(Event.CONNECT, connectedHandler);
			dispatcher.addEventListener(ProgressEvent.SOCKET_DATA, onRecieveData);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}

		public function connect():void
		{
			if (socket.connected)
			{
				Logger.error("try connect but connected already.");
				return;
			}
			if (!_serverArray || _serverArray.length == 0)
			{
				Logger.error("try connect but server address is empty.");
				return;
			}
			loadPolicyAndConnect();
		}

		private function loadPolicyAndConnect():void
		{
			if (currentServerIndex < _serverArray.length)
			{
				var server:ServerAddress = _serverArray[currentServerIndex++];
				
				currentServerIndex = currentServerIndex%_serverArray.length;
				
				var host:String = server.host;
				var port:uint = server.port;
				var policy:uint = server.policy;
				if (policy != 0)
				{
					var policyAddress:String = "xmlsocket://" + host + ":" + policy;
					Logger.debug("load policy from: " + policyAddress);
					Security.loadPolicyFile(policyAddress);
				}
				Logger.debug("connect with : " + host + ":" + port);
				socket.connect(host, port);
			}
			else
			{
				connectFailed();
			}
		}

		private function onRecieveData(data:ProgressEvent):void
		{
			while (socket.bytesAvailable)
			{
				socket.readBytes(bytesRecieved, bytesRecieved.length);
			}
			analyzeBytesRecieved();
		}

		private function analyzeBytesRecieved():void
		{
			bytesRecieved.position = 0;
			var messageLength:int = bytesRecieved.length;
			if (messageLength < HEADER_LENGTH)
			{
				if(messageLength > 0 )
				{
					Logger.debug("not enough message header, messageLength: " + messageLength);
				}
				return;
			}
			var lengthInHeader:int = bytesRecieved.readInt();
			if (messageLength < lengthInHeader)
			{
				Logger.debug("not enough message length, messageLength: " + messageLength + " -- lengthInHeader: " + lengthInHeader);
				return;
			}

			var data:ByteArray = new ByteArray();
			bytesRecieved.readBytes(data, 0, lengthInHeader - HEADER_LENGTH);
			decode(data);
			var restBytes:ByteArray = new ByteArray();
			bytesRecieved.readBytes(restBytes);
			bytesRecieved = restBytes;
			analyzeBytesRecieved();
		}

		private function decode(data:ByteArray):void
		{
			var magicNum:uint = data.readUnsignedInt();
			//compare mageic number;
			var msgId:int = data.readInt();
			
			Logger.debug("接收到协议："+msgId);
			
			dispatchMessage(msgId, data);
		}

		private function ioErrorHandler(event:IOErrorEvent):void
		{
			Logger.debug("IO error.");
			if (socket.connected)
			{
				socket.close();
			}
			socket = new Socket();
			configureListeners(socket);
			loadPolicyAndConnect();
		}

		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			Logger.error("security error... ");
			loadPolicyAndConnect();
		}

		public function send(msgId:uint, message:Message):void
		{
			var byteArr:ByteArray = getMessageBytes(message, msgId);
			if (!socket.connected)
			{
				Logger.error("send But connection closed");
			}
			else
			{
				if (message != null)
				{
					Logger.debug("send data,msgId:"+msgId+", length: " + byteArr.length);
					byteArr.position = 0;
					socket.writeBytes(byteArr, 0, byteArr.length);
					socket.flush(); //发送数据  
				}
				else
				{
					Logger.error("Message is null.");
				}
			}
		}

		private function getMessageBytes(message:Message, messageId:uint):ByteArray
		{
			var byteArr:ByteArray = new ByteArray();
			byteArr.endian = Endian.BIG_ENDIAN;
			message.writeTo(byteArr);
			var messageBytes:ByteArray = new ByteArray();
			messageBytes.endian = Endian.BIG_ENDIAN;
			messageBytes.writeUnsignedInt(byteArr.length + DESCRIPTION_LENGTH);
			messageBytes.writeUnsignedInt(MAGIC_NUMBER);
			messageBytes.writeUnsignedInt(messageId);
			messageBytes.writeBytes(byteArr);
			return messageBytes;
		}

		public function hasConnected():Boolean
		{
			return socket != null && socket.connected;
		}

		public function close():void
		{
			if (socket)
			{
				if (socket.connected)
				{
					socket.close();
				}
			}
		}

		private function autoReconnect():void
		{
			reconnecting = true;
			showReconnectInfo();
		}

		private function connectedHandler(event:Event):void
		{
			currentServerIndex = 0;
			if (reconnecting)
			{
				reconnecting = false;
				reconnectSuccess();
			}
			else
			{
				connectionComplete();
			}
		}

		/**
		 * Override to implement different socket reconnectSuccess function
		 */
		protected function reconnectSuccess():void
		{
			Logger.debug("reconnect success..");
		}

		/**
		 * Override to implement different socket connectionComplete function
		 */
		protected function connectionComplete():void
		{
			Logger.debug("connection complete..");
		}

		/**
		 * Override to implement different socket close function
		 */
		protected function closeHandler(event:Event):void
		{
			Logger.debug("connection closed.");
			close();
			autoReconnect();
		}

		/**
		 * Override to implement different socket reconnect info function
		 */
		protected function showReconnectInfo():void
		{
			Logger.debug("reconnecting...");
		}

		/**
		 * Override to implement different socket reconnect info function
		 */
		protected function connectFailed():void
		{
			currentServerIndex = 0;
		}

		/**
		 * Override to implement different socket dispatchMessage function
		 */
		protected function dispatchMessage(messageId:uint, data:ByteArray):void
		{
			Logger.debug("dispatch message: " + messageId);
		}
	}
}
