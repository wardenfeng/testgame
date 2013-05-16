package moudle.scene
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;

	/**
	 *
	 * @author 风之守望者 2012-6-17
	 */
	public class SceneBackground extends Shape
	{
		public var maps : Dictionary;

		public function SceneBackground()
		{

		}

		public function showMap() : void
		{
			var bitmap : Bitmap;
			for (var key : String in maps)
			{
				bitmap = maps[key];
				var keyarr : Array = key.split("_");
				var i : int = int(keyarr[0]);
				var j : int = int(keyarr[1]);

				this.graphics.beginBitmapFill(bitmap.bitmapData);
				this.graphics.drawRect(i * ConfigData.MapTileWidth, j * ConfigData.MapTileHeight, ConfigData.MapTileWidth, ConfigData.MapTileHeight);
				this.graphics.endFill();
			}

			if (CommonData.isShowGird)
				drawGird();
			CommonData.gameDispather.dispatchEvent(new Event("map_show_completed"));
		}

		/**
		 * 绘制网格
		 */
		private function drawGird() : void
		{
			var startx : Number = -SceneConfig.TILE_WIDTH / 2;
			var starty : Number = -SceneConfig.TILE_HEIGHT / 2;
			graphics.lineStyle(2, 0x00ff00);
			while (startx < SceneConfig.mapWidth + SceneConfig.TILE_WIDTH / 2)
			{
				graphics.moveTo(startx, -SceneConfig.TILE_HEIGHT / 2);
				graphics.lineTo(startx, SceneConfig.mapHeight + SceneConfig.TILE_HEIGHT / 2);
				startx += SceneConfig.TILE_WIDTH;
			}
			while (starty < SceneConfig.mapHeight + SceneConfig.TILE_HEIGHT / 2)
			{
				graphics.moveTo(-SceneConfig.TILE_WIDTH / 2, starty);
				graphics.lineTo(SceneConfig.mapWidth + SceneConfig.TILE_WIDTH / 2, starty);
				starty += SceneConfig.TILE_HEIGHT;
			}
		}
	}
}
