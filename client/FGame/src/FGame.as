package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import moudle.GameController;
	
	import utils.debug.Stats;

	[SWF(width = "1000", height = "580", frameRate = "24", backgroundColor = "0x000000")]
	/**
	 *
	 * @author 风之守望者 2012-6-17
	 */
	public class FGame extends Sprite
	{
		/** 场景层 */
		public var sceneLayer : Sprite;

		/** 界面层 */
		public var viewLayer : Sprite;

		public function FGame()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);

		}

		private function addedHandler(event : Event) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;

			//初始化各种层
			sceneLayer = new Sprite();
			addChild(sceneLayer);

			viewLayer = new Sprite();
			addChild(viewLayer);

			CommonData.game = this;
			CommonData.stage = this.stage;
			CommonData.sceneLayer = sceneLayer;
			CommonData.viewLayer = viewLayer;
			CommonData.stageWidth = this.stage.stageWidth;
			CommonData.stageHeight = this.stage.stageHeight;

			//添加测试器
			addChild(new Stats());

			//开启游戏模块
			GameController.start();

			//this.stage.addEventListener(MouseEvent.CLICK, onClick);
			
		}

		/**
		 * 测试函数
		 */
		private function onClick(event : MouseEvent) : void
		{
			var disO:DisplayObject = event.target as DisplayObject;
			
			var traceStr:String = "○->";
			while(disO.parent)
			{
				traceStr+=disO.toString()+"->";
				disO = disO.parent;
			}
			trace(traceStr+"※");
		}
	}
}
