package moudle.resource
{

	/**
	 *
	 * @author 风之守望者 2012-7-4
	 */
	public class Resource
	{
		/** 资源根地址 */
//		public static var rootPath : String = "http://localhost:8080/testrpg/";
		public static var rootPath : String = "http://tmst-cdnres.me4399.com/s1_4399/";

		// ----------------------------------------
		//
		//		资源类型
		//
		// ----------------------------------------
		/** 地图类型 */
		public static const TYPE_MAP : int = 1;

		/** 玩家皮肤类型 */
		public static const TYPE_PLAYER : int = 2;

		/** 界面类型 */
		public static const TYPE_VIEW : int = 3;

		/**
		 * 获取普通资源路径
		 * @param type 资源类型
		 * @param name 资源名称
		 * @return  资源路径
		 */
		public static function getPath(type : int, name : String) : String
		{
			switch (type)
			{
				case TYPE_PLAYER:
				{
//					return rootPath + "player/clothing/" + name;
					return rootPath + "resources/player/clothing/10004.swf";
					break;
				}
				case TYPE_VIEW:
				{
					return rootPath + "view/" + name;
					break;
				}
			}
			return rootPath;
		}

		/**
		 * 获取地图资源路径
		 * @param mapName 地图名称
		 * @param name 资源名称
		 * @return 资源路径
		 */
		public static function getMapPath(mapName : String, name : String) : String
		{
			return rootPath + "scene/" + mapName + "/" + name;
		}

	}
}
