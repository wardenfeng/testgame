package feng.network;

import java.nio.ByteBuffer;

import protobuf.GobangProto.SSPKG_LOGIN_REQ;

import com.google.protobuf.InvalidProtocolBufferException;
import com.googlecode.protobuf.format.JsonFormat;

import feng.MsgProcessor;

/**
 * 
 * @author 风之守望者 2013-2-20
 */
public class Protocol {
	/**
	 * 登录请求
	 */
	static public final int SSID_LOGIN_REQ = 1;
	/**
	 * 登录响应
	 **/
	static public final int SSID_LOGIN_ACK = 2;

	public static void Decode(int MsgID, ByteBuffer byteBuffer,MsgProcessor proc)
			throws InvalidProtocolBufferException {
		switch (MsgID) {
		case SSID_LOGIN_REQ:
			SSPKG_LOGIN_REQ pkg;
			pkg = SSPKG_LOGIN_REQ.parseFrom(byteBuffer.array());

			System.out.println(JsonFormat.printToString(pkg));

			proc.OnRecvLoginReq(pkg);
			break;
		default:
			System.out.println("收到陌生协议号：" + MsgID);
			break;
		}
	}
}
