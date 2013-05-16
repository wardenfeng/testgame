import org.junit.Test;

import com.google.protobuf.Message;
import com.googlecode.protobuf.format.HtmlFormat;
import com.googlecode.protobuf.format.JsonFormat;
import com.googlecode.protobuf.format.XmlFormat;
import com.googlecode.protobuf.format.XmlFormat.ParseException;

import protobuf.SlotProto.LINE_INFO;
import protobuf.SlotProto.SSPKG_LOGIN_ACK;
import protobuf.SlotProto.WIN_INFO;

public class MyTest {

	@Test
	public void test()
			throws com.googlecode.protobuf.format.JsonFormat.ParseException,
			ParseException {
		SSPKG_LOGIN_ACK sspkg_login_ack = SSPKG_LOGIN_ACK.newBuilder()
				.setSuccess(true).setBalance(0).build();
		String xmlFormat = XmlFormat.printToString(sspkg_login_ack);
		System.out.println(xmlFormat);

		Message.Builder builder = SSPKG_LOGIN_ACK.newBuilder();
		XmlFormat.merge(xmlFormat, builder);

		String jsonFormat = JsonFormat.printToString(sspkg_login_ack);
		System.out.println(jsonFormat);

		JsonFormat.merge(jsonFormat, builder);

		String htmlFormat = HtmlFormat.printToString(sspkg_login_ack);
		System.out.println(htmlFormat);

		LINE_INFO line_info = LINE_INFO.newBuilder().setIndex(0).setBonus(0)
				.build();
		WIN_INFO win_info = WIN_INFO.newBuilder().setTotalReward(0)
				.setJackspotLine(0).setFreeSpin(0).setLuckyTimes(0)
				.setLuckyJackpotCash(0).addWinLines(line_info)
				.addWinLines(line_info).build();

		String htmlFormat1 = HtmlFormat.printToString(win_info);
		System.out.println(htmlFormat1);
	}

}
