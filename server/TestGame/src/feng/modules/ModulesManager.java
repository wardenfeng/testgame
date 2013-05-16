package feng.modules;

import feng.modules.login.LoginManager;

/**
 * 
 * @author 风之守望者 2011-11-24
 */
public class ModulesManager
{
	//客户编号
	private int clientId;

	//登录管理者
	private LoginManager loginManager;
	
	public ModulesManager(int clientId)
	{
		this.clientId = clientId;
	}

	/**
	 * 获取登录管理者
	 * @return
	 */
	public LoginManager getLoginManager()
	{
		if (loginManager == null)
		{
			loginManager = new LoginManager(clientId);
		}
		return loginManager;
	}
}
