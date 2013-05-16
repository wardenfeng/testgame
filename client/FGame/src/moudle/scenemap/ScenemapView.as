package moudle.scenemap
{
	import animation.Animal;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	import moudle.findpath.MapTileModel;
	import moudle.moveaction.MoveActionEvent;
	import moudle.resource.Resource;
	import moudle.scene.SceneConfig;

	/**
	 * 场景地图
	 * @author 风之守望者 2012-6-25
	 */
	public class ScenemapView extends Sprite
	{
		/** 背景图片 */
		public var backmap : Bitmap;

		/** 路径层 */
		public var pathLayer : Shape;

		/** 玩家层 */
		public var playerLayer : Sprite;

		/** 玩家字典 */
		public var playerDic : Dictionary = new Dictionary();

		/** 场景地图与实际地图比例X */
		public var mapScaleX : Number = 0;

		/** 场景地图与实际地图比例Y */
		public var mapScaleY : Number = 0;

		/** 主角 */
		public function get hero() : Animal
		{
			return CommonData.hero;
		}

		/** 场景层 */
		private function get sceneLayer() : Sprite
		{
			return CommonData.sceneLayer;
		}

		/** 界面层 */
		private function get viewLayer() : Sprite
		{
			return CommonData.viewLayer;
		}

		public function ScenemapView()
		{
			//加载场景地图
			var loader : Loader = new Loader();
			configureListeners(loader.contentLoaderInfo);
			var request : URLRequest = new URLRequest(Resource.getMapPath("1001", "small.jpg"));
			loader.load(request);

			this.addEventListener(Event.ADDED_TO_STAGE, addedView);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedView);

			CommonData.gameDispather.addEventListener(MoveActionEvent.HERO_STEP_COMPLETED, onHeroStepCompleted);
		}

		private function configureListeners(dispatcher : IEventDispatcher) : void
		{
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(Event.INIT, initHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
		}

		private function completeHandler(event : Event) : void
		{
			//初始化背景地图
			backmap = event.currentTarget.content;
			this.addChild(backmap);

			//计算缩放比例
			mapScaleX = backmap.width / SceneConfig.mapWidth;
			mapScaleY = backmap.height / SceneConfig.mapHeight;

			//初始化路径层
			pathLayer = new Shape();
			this.addChild(pathLayer);

			//初始化玩家层
			playerLayer = new Sprite();
			playerLayer.mouseChildren = false;
			playerLayer.mouseEnabled = false;
			this.addChild(playerLayer);

			resize();
		}

		private function httpStatusHandler(event : HTTPStatusEvent) : void
		{
			//trace("httpStatusHandler: " + event);
		}

		private function initHandler(event : Event) : void
		{
			//trace("initHandler: " + event);
		}

		private function ioErrorHandler(event : IOErrorEvent) : void
		{
			trace("ioErrorHandler: " + event);
		}

		private function openHandler(event : Event) : void
		{
			//trace("openHandler: " + event);
		}

		private function progressHandler(event : ProgressEvent) : void
		{
			//trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}

		private function unLoadHandler(event : Event) : void
		{
			//trace("unLoadHandler: " + event);
		}

		public function show() : void
		{
			viewLayer.addChild(this);
			resize();
			Scenemap.isShow = true;
		}

		public function close() : void
		{
			viewLayer.removeChild(this);
			Scenemap.isShow = false;
		}

		/**
		 * 界面居中
		 */
		public function resize() : void
		{
			if (this.stage)
			{
				this.x = (this.stage.stageWidth - this.width) / 2;
				this.y = (this.stage.stageHeight - this.height) / 2;
			}
		}

		public function addedView(event : Event) : void
		{
			this.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.addEventListener(MouseEvent.CLICK, onClick);
		}

		public function removedView(event : Event) : void
		{
			this.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.removeEventListener(MouseEvent.CLICK, onClick);
		}

		public function onEnterFrame(event : Event) : void
		{
			//添加主角
			if (playerLayer && hero != null && playerDic[0] == null)
			{
				var shape : Shape = new Shape();
				shape.graphics.beginFill(0xff0000);
				shape.graphics.drawCircle(0, 0, 3);
				shape.graphics.endFill();
				playerLayer.addChild(shape);
				playerDic[0] = shape;
			}
			//调整主角位置
			if (playerDic[0])
			{
				playerDic[0].x = mapScaleX * hero.x;
				playerDic[0].y = mapScaleY * hero.y;
			}
		}

		/**
		 * 点击地图
		 */
		public function onClick(event : MouseEvent) : void
		{
			sceneLayer.dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, false, event.localX / mapScaleX, event.localY / mapScaleY));
		}

		/**
		 * 绘制路径
		 */
		private function onHeroStepCompleted(event : MoveActionEvent) : void
		{
			var path : Array = event.data.findPathArr;
			var currentStep : int = event.data.currentStep;
			pathLayer.graphics.clear();
			if (path == null)
				return;
			pathLayer.graphics.beginFill(0x00ff00);
			for (var i : int = currentStep + 1; i < path.length; i++)
			{
				var realPoint : Point = MapTileModel.realCoordinate(path[i][0], path[i][1]);
				pathLayer.graphics.drawCircle(realPoint.x * mapScaleX, realPoint.y * mapScaleY, 1);
			}
			pathLayer.graphics.endFill();
		}
	}
}
