package feng;

import protobuf.GobangProto.SSPKG_LOGIN_REQ;
import feng.modules.login.LoginManager;

/**
 * 处理接收到的协议
 * 
 * @author 风之守望者 2013-2-20
 */
public class MsgProcessor {

	private int clientId;

	public MsgProcessor(int clientId) {
		// TODO Auto-generated constructor stub
		this.clientId = clientId;
	}

	public void OnRecvLoginReq(SSPKG_LOGIN_REQ pkg) {
		// TODO Auto-generated method stub

		try {
			String username = pkg.getAccount();
			String password = pkg.getPassword();

			System.out.println("用户名：" + username + ",密码:" + password);

			// 获取登录管理者
			LoginManager loginManager = AllReference.getLoginManager(clientId);
			loginManager.login(username, password);
		} catch (Exception e) {
			System.out.println("登录协议发生异常");
			e.printStackTrace();
			// TODO: handle exception
		}

	}

}