package feng.modules.login;

import protobuf.GobangProto.SSPKG_LOGIN_ACK;
import feng.AllReference;
import feng.MsgSender;
import feng.network.Protocol;
import feng.sql.dao.PlayerDao;
import feng.sql.model.Player;

/**
 * 
 * @author 风之守望者 2011-11-22
 */
public class LoginManager {
	private int clientId;

	public LoginManager(int clientId) {
		this.clientId = clientId;
	}

	public void login(String username, String password) {

		Boolean result = checkLogin(username, password);

		SSPKG_LOGIN_ACK sspkg_login_ack = SSPKG_LOGIN_ACK.newBuilder()
				.setSuccess(result).build();

		MsgSender msgSender = AllReference.getMsgSender(clientId);
		msgSender.send(Protocol.SSID_LOGIN_ACK, sspkg_login_ack);
	}

	public Boolean checkLogin(String username, String password) {
		PlayerDao playerDao = AllReference.getPlayerDao(clientId);
		if (playerDao == null)
			return false;
		Player player = playerDao.getByName(username);
		if (player == null) {
			System.out.println(username + "未注册");
			return false;
		}
		if (!player.getPassword().equals(password)) {
			System.out.println(username + "使用错误密码（" + password + "）登陆");
			return false;
		}

		return true;
	}

}