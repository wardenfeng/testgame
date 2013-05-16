import protobuf.SlotProto.SSPKG_LOGIN_REQ;
import protobuf.SlotProto.SSPKG_SPIN_REQ;

import com.google.protobuf.InvalidProtocolBufferException;
import com.googlecode.protobuf.format.JsonFormat;

public class SlotProto {
	/**
	 * 登录请求
	 */
	static public final int SSID_LOGIN_REQ = 1;
	/**
	 * 登录响应
	 **/
	
	static public final int SSID_LOGIN_ACK = 2;
	static public final int SSID_SPIN_REQ = 3;
	static public final int SSID_SPIN_ACK = 4;
	static public final int SSID_BALANCE_NTF = 5;

	public static void Decode(int MsgID, byte[] buf, SlotMsgProcessor proc)
			throws InvalidProtocolBufferException {
		switch (MsgID) {
		case SSID_LOGIN_REQ:
			SSPKG_LOGIN_REQ sspkg_login_req = SSPKG_LOGIN_REQ.parseFrom(buf);

			System.out.println(JsonFormat.printToString(sspkg_login_req));

			break;
		case SSID_SPIN_REQ:
			SSPKG_SPIN_REQ sspkg_spin_req = SSPKG_SPIN_REQ.parseFrom(buf);

			System.out.println(JsonFormat.printToString(sspkg_spin_req));

			break;
		default:

			System.out.println("接受到陌生协议");

			break;
		}
	}

}
