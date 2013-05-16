package moudle.scene
{
	import animation.Animal;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import moudle.Controller;
	import moudle.findpath.AStar;
	import moudle.findpath.FindpathEvent;
	import moudle.findpath.MapTileModel;
	import moudle.moveaction.MoveActionEvent;

	/**
	 * 操作真实地图
	 * @author 风之守望者 2012-7-1
	 */
	public class SceneController extends Controller
	{
		/** 场景地图配置 */
		private var sceneMapConfig : SceneConfig;

		/** 场景地图工厂 */
		private var sceneMapFactory : SceneFactory;

		/** 地图层 */
		private var gameSceneBackground : SceneBackground;

		/** 路径层 */
		private var pathlayer : Shape = new Shape();

		/** 动物层 */
		private var playerLayer : Sprite;

		public function get hero() : Animal
		{
			return CommonData.hero;
		}

		private function get sceneLayer() : Sprite
		{
			return CommonData.sceneLayer;
		}

		public function SceneController()
		{
			CommonData.gameDispather.addEventListener("config_load_completed", configLoadCompleted);
			CommonData.gameDispather.addEventListener("map_load_completed", mapLoadCompleted);
			CommonData.gameDispather.addEventListener("map_show_completed", mapShowCompleted);

			playerLayer = new Sprite();
			sceneLayer.addChild(playerLayer);
			playerLayer.mouseEnabled = false;
			//加载地图配置
			sceneMapConfig = new SceneConfig();
		}

		private function configLoadCompleted(event : Event) : void
		{
			trace("地图配置加载完成");

			//加载地图
			sceneMapFactory = new SceneFactory();
		}

		private function mapLoadCompleted(event : Event) : void
		{
			trace("地图加载完成");

			CommonData.gameDispather.removeEventListener("map_load_completed", mapLoadCompleted);

			//初始化地图
			gameSceneBackground = new SceneBackground();
			gameSceneBackground.maps = sceneMapFactory.maps;
			sceneLayer.addChildAt(gameSceneBackground, 0);

			gameSceneBackground.showMap();

			sceneLayer.addChildAt(pathlayer, 1);
		}

		private function mapShowCompleted(event : Event) : void
		{
			trace("地图显示完成");
			CommonData.gameDispather.removeEventListener("map_show_completed", mapShowCompleted);

			var animals : Vector.<Animal> = new Vector.<Animal>();
			//加载人物皮肤
			for (var i : int = 0; i < 2; i++)
			{
				var animal : Animal = new Animal();
				playerLayer.addChild(animal);
				animal.x = 60 * SceneConfig.TILE_WIDTH;
				animal.y = 75 * SceneConfig.TILE_HEIGHT;
				animals.push(animal);
			}

			CommonData.hero = animals[0];
			hero.mouseEnabled = false;
			hero.mouseChildren = false;

			//处理深度叠换
			animals.sort(function(a : Animal, b : Animal) : int
			{
				if (a.y > b.y || (a.y > b.y && a.x < b.x))
				{
					return 1;
				}
				return -1;
			});
			for (i = 0; i < animals.length; i++)
			{
				playerLayer.addChildAt(animals[i], i);
			}

			sceneLayer.addEventListener(MouseEvent.CLICK, onSceneClick);

			CommonData.stage.addEventListener(Event.ENTER_FRAME, setHeroCenter);
			trace("添加人物完成");

			dispatcher.dispatchEvent(new SceneEvent(SceneEvent.SCENE_COMPLETED));
		}

		/**
		 * 点击场景
		 */
		private function onSceneClick(event : MouseEvent) : void
		{
			if (event.target != sceneLayer)
				return;
			//计算玩家所在的格子坐标
			var startPoint : Point = MapTileModel.girdCoordinate(hero.x, hero.y);
			//计算点击位置的格子坐标
			var endPoint : Point = MapTileModel.girdCoordinate(event.localX, event.localY);
			//trace("起点", startPoint, "	终点", endPoint);

			var findpathEvent : FindpathEvent = new FindpathEvent(FindpathEvent.FIND_PATH, startPoint.x, startPoint.y, endPoint.x, endPoint.y);
			//抛出事件获取路径
			dispatcher.dispatchEvent(findpathEvent);
			var path : Array = findpathEvent.path;
			//trace("A*路径", path);

			if (path)
			{
				//drawPath(path);
				
				dispatcher.dispatchEvent(new MoveActionEvent(MoveActionEvent.HERO_START_MOVE,path));
			}
			else
			{
				trace("无法找到路径");
			}
		}

		/**
		 * 绘制路径
		 * @param path 路径数据
		 */
		private function drawPath(path : Array) : void
		{
			pathlayer.graphics.clear();
			if (path == null)
				return;
			pathlayer.graphics.beginFill(0xff0000);
			for (var i : int = 0; i < path.length; i++)
			{
				var realPoint : Point = MapTileModel.realCoordinate(path[i][0], path[i][1]);
				pathlayer.graphics.drawCircle(realPoint.x, realPoint.y, SceneConfig.TILE_HEIGHT / 2);
			}
			pathlayer.graphics.endFill();
		}

		/**
		 * 设置英雄为中心(地图卷动)
		 */
		private function setHeroCenter(event : Event) : void
		{
			//移动场景
			sceneLayer.x = int(CommonData.stage.stageWidth / 2 - hero.x);
			sceneLayer.y = int(CommonData.stage.stageHeight / 2 - hero.y);
			//设置场景移动边界(避免看到黑边)
			if (sceneLayer.x > 0)
			{
				sceneLayer.x = 0;
			}
			if (sceneLayer.y > 0)
			{
				sceneLayer.y = 0;
			}
		}

		// ----------------------------------------
		//
		//		单例模式
		//
		// ----------------------------------------
		private static var _instance : SceneController;

		public static function start() : SceneController
		{
			return instance;
		}

		public static function get instance() : SceneController
		{
			if (_instance == null)
				_instance = new SceneController();
			return _instance;
		}
	}
}
