package feng;

import java.io.DataOutputStream;

import feng.client.Client;
import feng.modules.ModulesManager;
import feng.modules.login.LoginManager;
import feng.network.SocketManager;
import feng.sql.SQLManager;
import feng.sql.dao.PlayerDao;

/**
 * 
 * @author 风之守望者 2012-1-4
 */
public class AllReference
{
	/**
	 * 根据客户编号返回客户实例
	 * @param clientId 客户编号
	 * @return 客户实例
	 */
	public static Client getClient(int clientId)
	{
		return CommonData.connectedClientMap.get(clientId);
	}

	/**
	 * 根据客户编号返回模块管理者
	 * @param clientId 客户编号
	 * @return 模块管理者
	 */
	public static ModulesManager getModulesManager(int clientId)
	{
		Client client = getClient(clientId);
		if (client == null)
			return null;
		return client.getModulesManager();
	}
	
	/**
	 * 根据客户编号返回登录管理者
	 * @param clientId 客户编号
	 * @return 登录管理者
	 */
	public static LoginManager getLoginManager(int clientId)
	{
		ModulesManager modulesManager = getModulesManager(clientId);
		if (modulesManager == null)
			return null;
		return modulesManager.getLoginManager();
	}
	
	/**
	 * 根据客户编号返回数据库管理者
	 * @param clientId 客户编号
	 * @return 数据库管理者
	 */
	public static SQLManager getSQLManager(int clientId)
	{
		Client client = getClient(clientId);
		if(client == null)
			return null;
		return client.getSqlManager();
	}
	
	/**
	 * 根据客户编号返回玩家信息数据处理者
	 * @param clientId 客户编号
	 * @return 玩家信息数据处理者
	 */
	public static PlayerDao getPlayerDao(int clientId)
	{
		SQLManager sqlManager = getSQLManager(clientId);
		if(sqlManager == null)
			return null;
		return sqlManager.getPlayerDao();
	}
	
	/**
	 * 根据客户编号获取socket管理者
	 * @param clientId 客户编号
	 * @return socket管理者
	 */
	public static SocketManager getSocketManager(int clientId)
	{
		Client client = getClient(clientId);
		if(client == null)
			return null;
		return client.getSocketManager();
	}

	/**
	 * 获取协议编写者
	 * @param clientId 客户编号
	 * @return 协议编写者
	 */
	public static DataOutputStream getWriter(int clientId)
	{
		SocketManager socketManager = getSocketManager(clientId);
		if(socketManager == null)
			return null;
		return socketManager.getWriter();
	}
	
	/**
	 * 获取协议发送者
	 * @param clientId 客户编号
	 * @return 协议发送者
	 */
	public static MsgSender getMsgSender(int clientId)
	{
		Client client = getClient(clientId);
		if(client == null)
			return null;
		return client.getMsgSender();
	}
	
	/**
	 * 获取协议处理者
	 * @param clientId 客户编号
	 * @return 协议处理者
	 */
	public static MsgProcessor getMsgProcessor(int clientId)
	{
		Client client = getClient(clientId);
		if(client == null)
			return null;
		return client.getMsgProcessor();
	}
}
