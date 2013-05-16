package moudle.scene
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	import moudle.resource.Resource;

	/**
	 * 场景地图工厂
	 * @author 风之守望者 2012-6-17
	 */
	public class SceneFactory
	{
		public var maps : Dictionary; // 图片块缓存

		private var loadTotal : int = 0;

		private var loadedNum : int = 0;

		public function SceneFactory()
		{
			maps = new Dictionary();

			loadedNum = 0;
			loadTotal = 0;
			for (var i : int = 0; i < 22; i++)
			{
				for (var j : int = 0; j < 25; j++)
				{
					loadTotal++;

					var loader : Loader = new Loader();
					configureListeners(loader.contentLoaderInfo);
					var request : URLRequest = new URLRequest(Resource.getMapPath("1001", "" + i + "_" + j + ".jpg"));
					loader.load(request);
				}
			}
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
			var url : String = event.currentTarget.url;
			var mapName : String = url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf("."));
			maps[mapName] = event.currentTarget.content;

			//判断所有图片是否加载完毕
			loadedNum++;
			if (loadedNum == loadTotal)
			{
				CommonData.gameDispather.dispatchEvent(new Event("map_load_completed"));
			}
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
