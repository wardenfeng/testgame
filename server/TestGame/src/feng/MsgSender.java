package feng;

import java.io.DataOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;

import com.google.protobuf.Message;

import feng.network.SocketManager;

/**
 * 
 * @author 风之守望者 2013-2-24
 */
public class MsgSender {
	private int clientId;

	public MsgSender(int clientId) {
		// TODO Auto-generated constructor stub
		this.clientId = clientId;
	}

	public void OnRecvLoginAck()
	{
		
	}
	
	public void send(int msgId, Message message)
	{
		byte[] data = message.toByteArray();
		
		ByteBuffer byteBuffer = ByteBuffer.allocate(1024);;
		byteBuffer.putInt(data.length + SocketManager.DESCRIPTION_LENGTH);
		//MAGIC_NUMBER
		byteBuffer.putInt(502);
		byteBuffer.putInt(msgId);
		byteBuffer.put(data);
		
		DataOutputStream writer = AllReference.getWriter(clientId);

		try
		{
			writer.write(byteBuffer.array(), 0, byteBuffer.position());
		} catch (IOException e)
		{
			// TODO Auto-generated catch block
			System.out.println("登录协议回复失败，用户编号：" + clientId);
			e.printStackTrace();
		}
	}
}
