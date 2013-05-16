package moudle.scene
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import moudle.resource.Resource;

	/**
	 *
	 * @author 风之守望者 2012-6-17
	 */
	public class SceneConfig
	{
		/** 地图名称 */
		public static var mapName : String;

		/** 地图格子类型  1、矩形 */
		public static var tileType : int;

		/** 地图宽度 */
		public static var mapWidth : int;

		/** 地图高度 */
		public static var mapHeight : int;

		/** 格子宽度 */
		public static var TILE_WIDTH : int;

		/** 格子高度 */
		public static var TILE_HEIGHT : int;

		/** 列数 */
		public static var Row : int;

		/** 行数 */
		public static var Col : int;

		/** 地图掩码数据 */
		public static var mapData : Array;

		public function SceneConfig()
		{
			var loader : Loader = new Loader();
			configureListeners(loader.contentLoaderInfo);
			var request : URLRequest = new URLRequest(Resource.getMapPath("1001","config.swf"));
			loader.load(request);
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
			//trace("completeHandler: " + event);
			var configContent : * = event.currentTarget.content;

			SceneConfig.mapName = configContent["mapName"];
			SceneConfig.tileType = 1;
			SceneConfig.mapWidth = configContent["mapWidth"];
			SceneConfig.mapHeight = configContent["mapHeight"];
			SceneConfig.TILE_WIDTH = configContent["TILE_WIDTH"];
			SceneConfig.TILE_HEIGHT = configContent["TILE_HEIGHT"];
			SceneConfig.Row = configContent["Row"];
			SceneConfig.Col = configContent["Col"];
			SceneConfig.mapData = configContent["mapData"];

			CommonData.gameDispather.dispatchEvent(new Event("config_load_completed"));
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
	}
}
