package feng.dao.impl;


import org.junit.Test;

import feng.sql.dao.PlayerDao;
import feng.sql.dao.impl.PlayerDaoImpl;
import feng.sql.model.Player;


/**
 * 
 * @author 风之守望者 2011-11-11
 */
public class PlayerDaoImplTest
{

	@Test
	public void testGetById()
	{
		PlayerDao playerDao = new PlayerDaoImpl();
		Player player = (Player) playerDao.getById(0);
		if (player != null)
			System.out.println(player.getId() + "," + player.getUsername()
					+ "," + player.getPassword());
		else
			System.out.println("null");
	}

	@Test
	public void testGetByName()
	{
		PlayerDao playerDao = new PlayerDaoImpl();
		Player player = (Player) playerDao.getByName("风中人");
		if (player != null)
			System.out.println(player.getId() + "," + player.getUsername()
					+ "," + player.getPassword());
		else
			System.out.println("null");
	}
	
	@Test
	public void testSave()
	{
		Player player = new Player();
		player.setUsername("风中人");
		player.setPassword("123");
		
		PlayerDao playerDao = new PlayerDaoImpl();
		playerDao.save(player);
	}
}
