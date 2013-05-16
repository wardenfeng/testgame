package moudle.login
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.MouseEvent;
	
	import moudle.login.Login;
	import moudle.resource.Resource;

	/**
	 * 登陆界面
	 * @author warden_feng
	 * <br/>2011-9-25
	 */
	public class LoginView extends Sprite
	{
		private var mainView : MovieClip;

		private var bulkLoader : BulkLoader;

		private var isloading : Boolean = false;

		/** 界面层 */
		private function get viewLayer() : Sprite
		{
			return CommonData.viewLayer;
		}

		private function init() : void
		{
			var path : String = Resource.getPath(Resource.TYPE_VIEW,Login.resourcePath);
			if (!Login.isload)
			{
				bulkLoader = BulkLoader.getLoader(Login.resourcePath);
				if (!bulkLoader)
				{
					bulkLoader = new BulkLoader(Login.resourcePath);
				}
				bulkLoader.add(path, {"id": Login.resourcePath});
				addLoaderListeners();
				bulkLoader.start();
				return;
			}
			var obj : Object = bulkLoader.contents[path];
			var imageItem : ImageItem = bulkLoader.get(Login.resourcePath) as ImageItem;
			var cla : Class = imageItem.getDefinitionByName("LoginView") as Class;
			mainView = new cla();
			Login.isinit = true;
			show();
		}

		public function show() : void
		{
			if (!Login.isinit)
			{
				init();
				return;
			}
			viewLayer.addChild(mainView);
			Login.isshow = true;
			addListeners();
		}

		public function close() : void
		{
			Login.isshow = false;
			removeListeners()
		}

		private function addListeners() : void
		{
			mainView.login_btn.addEventListener(MouseEvent.CLICK, onClick);
		}

		private function removeListeners() : void
		{
		}

		private function addLoaderListeners() : void
		{
			isloading = true;
			bulkLoader.addEventListener(BulkLoader.COMPLETE, completeHandlerSpecialEvent);
			bulkLoader.addEventListener(BulkLoader.ERROR, onError);
		}

		private function removeLoaderListeners() : void
		{
			isloading = false;
			bulkLoader.removeEventListener(BulkLoader.COMPLETE, completeHandlerSpecialEvent);
			bulkLoader.removeEventListener(BulkLoader.ERROR, onError);
		}

		private function onClick(event : MouseEvent) : void
		{
			//LoginRequest.loginSend(deleteSpace(mainView.username_txt.text), deleteSpace(mainView.password_txt.text));
		}

		/**
		 * 去除字符串前后空格
		 */
		private function deleteSpace(src : String) : String
		{
			return src.replace(/^\s*/g, "").replace(/\s*$/g, "");
		}

		protected function completeHandlerSpecialEvent(event : BulkProgressEvent = null) : void
		{
			removeLoaderListeners()
			Login.isload = true;
			init();
		}

		protected function onError(event : ErrorEvent = null) : void
		{
			trace("加载失败");
			removeLoaderListeners()
		}
	}
}
