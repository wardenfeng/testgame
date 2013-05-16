package animation
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.ui.Keyboard;

	import moudle.findpath.MapTileModel;
	import moudle.resource.Resource;

	import utils.Draw;

	/**
	 * 动物
	 * @author 风之守望者 2012-6-17
	 */
	public class Animal extends Sprite
	{
		//定义方向
		public static const DIR_DOWN_LEFT:int=1;

		public static const DIR_DOWN:int=2;

		public static const DIR_DOWN_RIGHT:int=3;

		public static const DIR_LEFT:int=4;

		public static const DIR_NULL:int=5;

		public static const DIR_RIGHT:int=6;

		public static const DIR_UP_LEFT:int=7;

		public static const DIR_UP:int=8;

		public static const DIR_UP_RIGHT:int=9;

		public static const ACTION_STAND:int=1;

		public static const ACTION_WALK:int=2;

		//资源
		private var bitmapdatas:Array=[];

		//偏移量
		private var geometry:Array;

		private var config:Array;

		private var direction:int=Animal.DIR_DOWN;

		private var action:int=Animal.ACTION_STAND;

		//用来控制帧播放频率
		private var shownum:int=1;

		/**起始帧*/
		private var startFrame:int=1;

		/** 结束帧*/
		private var endFrame:int=6;

		/** 是否翻转 */
		private var turned:Boolean=false;

		/** 值与方向 */
		private var valueDirection:Array;

		/** 动作与速度 */
		private var actionSpeed:Array;

		/** 当前帧 */
		private var currentFrame:int=1;

		/** 当前显示的图片数据 */
		private var currentBitmapdata:BitmapData;

		/** 当前显示的图片是否被翻转 */
		private var currentTurned:Boolean=false;

		/** 当前现身的图片内容 */
		private var currentBitmap:Bitmap=new Bitmap();

		private var _destination:Point;

		/** 步长 */
		private var stepLength:Number;

		/** 方向单位向量 */
		private var dirVector:Point=new Point();

		/** 格子坐标 */
		private var girdPoint:Point=new Point();

		public function Animal()
		{
			addListeners();
			initConfig();
		}

		private function initConfig():void
		{
			config=[];
			//站立
			config[Animal.ACTION_STAND * 100 + Animal.DIR_DOWN]={startFrame: 1, endFrame: 6, turned: false};
			config[Animal.ACTION_STAND * 100 + Animal.DIR_DOWN_RIGHT]={startFrame: 7, endFrame: 12, turned: false};
			config[Animal.ACTION_STAND * 100 + Animal.DIR_RIGHT]={startFrame: 13, endFrame: 18, turned: false};
			config[Animal.ACTION_STAND * 100 + Animal.DIR_UP_RIGHT]={startFrame: 19, endFrame: 24, turned: false};
			config[Animal.ACTION_STAND * 100 + Animal.DIR_UP]={startFrame: 25, endFrame: 30, turned: false};
			config[Animal.ACTION_STAND * 100 + Animal.DIR_UP_LEFT]={startFrame: 19, endFrame: 24, turned: true};
			config[Animal.ACTION_STAND * 100 + Animal.DIR_LEFT]={startFrame: 13, endFrame: 18, turned: true};
			config[Animal.ACTION_STAND * 100 + Animal.DIR_DOWN_LEFT]={startFrame: 7, endFrame: 12, turned: true};

			//行走
			config[Animal.ACTION_WALK * 100 + Animal.DIR_DOWN]={startFrame: 91, endFrame: 96, turned: false};
			config[Animal.ACTION_WALK * 100 + Animal.DIR_DOWN_RIGHT]={startFrame: 97, endFrame: 102, turned: false};
			config[Animal.ACTION_WALK * 100 + Animal.DIR_RIGHT]={startFrame: 103, endFrame: 108, turned: false};
			config[Animal.ACTION_WALK * 100 + Animal.DIR_UP_RIGHT]={startFrame: 109, endFrame: 114, turned: false};
			config[Animal.ACTION_WALK * 100 + Animal.DIR_UP]={startFrame: 115, endFrame: 120, turned: false};
			config[Animal.ACTION_WALK * 100 + Animal.DIR_UP_LEFT]={startFrame: 109, endFrame: 114, turned: true};
			config[Animal.ACTION_WALK * 100 + Animal.DIR_LEFT]={startFrame: 103, endFrame: 108, turned: true};
			config[Animal.ACTION_WALK * 100 + Animal.DIR_DOWN_LEFT]={startFrame: 97, endFrame: 102, turned: true};

			//定义动作速度大小
			actionSpeed=[];
			actionSpeed[Animal.ACTION_STAND]=0;
			actionSpeed[Animal.ACTION_WALK]=4;

			//定义值与方向
			valueDirection= //
				[[Animal.DIR_UP_LEFT, Animal.DIR_UP, Animal.DIR_UP_RIGHT], //
				[Animal.DIR_LEFT, Animal.DIR_NULL, Animal.DIR_RIGHT], //
				[Animal.DIR_DOWN_LEFT, Animal.DIR_DOWN, Animal.DIR_DOWN_RIGHT]];

			//初始化方向与动作
			setDirection(Animal.DIR_DOWN);
			setAction(Animal.ACTION_STAND);
		}

		private function setDirection(value:int):void
		{
			direction=value;
			var configObject:Object=config[action * 100 + direction];
			if (configObject)
			{
				startFrame=configObject.startFrame;
				endFrame=configObject.endFrame;
				turned=configObject.turned;
				stepLength=actionSpeed[action];
			}
			if (direction == 5)
			{
				setAction(Animal.ACTION_STAND);
			}
		}

		private function setAction(value:int):void
		{
			action=value;
			var configObject:Object=config[action * 100 + direction];
			if (configObject)
			{
				startFrame=configObject.startFrame;
				endFrame=configObject.endFrame;
				turned=configObject.turned;
				stepLength=actionSpeed[action];
			}
		}

		private function addListeners():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}

		private function addedHandler(event:Event):void
		{
			var loader:Loader=new Loader();
			configureListeners(loader.contentLoaderInfo);
			var request:URLRequest=new URLRequest(Resource.getPath(Resource.TYPE_PLAYER, "2.swf"));
			loader.load(request);
		}

		private function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(Event.INIT, initHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
		}

		private function completeHandler(event:Event):void
		{
			var loaderInfo:LoaderInfo=event.currentTarget as LoaderInfo;

			geometry=loaderInfo.content["geometry"];

			var length:int=geometry.length / 2;
			var applicationDomain:ApplicationDomain=loaderInfo.applicationDomain;
			for (var i:int=1; i < length; i++)
			{
				bitmapdatas[i]=new (applicationDomain.getDefinition("F" + i))();
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}

		private function onEnterFrame(event:Event):void
		{
			//moveTo();
			//判断是否到达目的
			if (destination && new Point(destination.x - x, destination.y - y).length < stepLength)
			{
				//抛出到达目的事件
				CommonData.gameDispather.dispatchEvent(new Event("animal_move_over"));
			}

			if (shownum == 0)
			{
				currentFrame++;
				if (currentFrame < startFrame || currentFrame > endFrame)
				{
					currentFrame=startFrame;
				}
			}

			var bitmapdata:BitmapData=bitmapdatas[currentFrame];
			if (currentBitmapdata != bitmapdata || currentTurned != turned)
			{
				var drawBitmapdata:BitmapData=bitmapdata;
				if (turned)
				{
					drawBitmapdata=Draw.HorizontalTurn(bitmapdata);
				}
				currentBitmap.bitmapData=drawBitmapdata;
				addChild(currentBitmap);
				currentBitmap.x=geometry[currentFrame * 2 - 2];
				currentBitmap.y=geometry[currentFrame * 2 - 1];
				if (turned)
				{
					currentBitmap.x=-drawBitmapdata.width - geometry[currentFrame * 2 - 2];
				}

				currentBitmapdata=bitmapdata;
			}

			//向目标移动
			x+=actionSpeed[action] * dirVector.x;
			y+=actionSpeed[action] * dirVector.y;

			shownum=(shownum + 1) % 4;
		}

		private function httpStatusHandler(event:HTTPStatusEvent):void
		{
			//trace("httpStatusHandler: " + event);
		}

		private function initHandler(event:Event):void
		{
			//trace("initHandler: " + event);
		}

		private function ioErrorHandler(event:IOErrorEvent):void
		{
			//trace("ioErrorHandler: " + event);
		}

		private function openHandler(event:Event):void
		{
			//trace("openHandler: " + event);
		}

		private function progressHandler(event:ProgressEvent):void
		{
			//trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
		}

		private function unLoadHandler(event:Event):void
		{
			//trace("unLoadHandler: " + event);
		}

		private function onKeyDown(event:KeyboardEvent):void
		{
			switch (event.keyCode)
			{
				//改变方向
				case Keyboard.NUMPAD_1:
					setDirection(Animal.DIR_DOWN_LEFT);
					break;
				case Keyboard.NUMPAD_2:
					setDirection(Animal.DIR_DOWN);
					break;
				case Keyboard.NUMPAD_3:
					setDirection(Animal.DIR_DOWN_RIGHT);
					break;
				case Keyboard.NUMPAD_4:
					setDirection(Animal.DIR_LEFT);
					break;
				case Keyboard.NUMPAD_6:
					setDirection(Animal.DIR_RIGHT);
					break;
				case Keyboard.NUMPAD_7:
					setDirection(Animal.DIR_UP_LEFT);
					break;
				case Keyboard.NUMPAD_8:
					setDirection(Animal.DIR_UP);
					break;
				case Keyboard.NUMPAD_9:
					setDirection(Animal.DIR_UP_RIGHT);
					break;

				//改变动作
				case "S".charCodeAt(0):
					setAction(Animal.ACTION_STAND);
					break;
				case "W".charCodeAt(0):
					setAction(Animal.ACTION_WALK);
					break;
				//+
				case 187:
					actionSpeed[action]++;
					break;
				//-
				case 189:
					actionSpeed[action]=actionSpeed[action] - 1;
					if (actionSpeed[action] < 1)
					{
						actionSpeed[action]=1;
					}
					break;
			}
		}

		/** 目的地 */
		public function get destination():Point
		{
			return _destination;
		}

		/**
		 * @private
		 */
		public function set destination(value:Point):void
		{
			//目的地为null时，设置为站立
			if (value == null)
			{
				_destination=null;
				setAction(Animal.ACTION_STAND);
				return;
			}
			_destination=MapTileModel.realCoordinate(value.x, value.y);

			//当前所在格子坐标
			var currentGirdPoint:Point=MapTileModel.girdCoordinate(x, y);
			//x距离
			var xDistance:Number=value.x - currentGirdPoint.x;
			//y距离
			var yDistance:Number=value.y - currentGirdPoint.y;

			//计算移动方向
			var xDir:int=xDistance ? (xDistance < 0 ? 0 : 2) : 1;
			var yDir:int=yDistance ? (yDistance < 0 ? 0 : 2) : 1;
			var moveDirection:int=valueDirection[yDir][xDir];
			//设置角色移动方式与朝向
			setAction(Animal.ACTION_WALK);
			setDirection(moveDirection);

			//初始化方向上的单位速度
			//斜边
			var xRealDistance:Number=_destination.x - x;
			var yRealDistance:Number=_destination.y - y;
			var hypotenuse:Number=Math.sqrt(yRealDistance * yRealDistance + xRealDistance * xRealDistance);
			//设置移动方向单位向量
			var sin:Number=yRealDistance / hypotenuse;
			var cos:Number=xRealDistance / hypotenuse;
			dirVector.x=cos;
			dirVector.y=sin;
		}
	}
}
