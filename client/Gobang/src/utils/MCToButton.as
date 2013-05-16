package utils
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;

	/**
	 * 把MovieClip作为Button使用
	 * @author xumin.xu 2013-1-11
	 */

	public class MCToButton
	{
		/**
		 * 存储按钮的选中状态
		 **/
		private static var selectedDic:Dictionary = new Dictionary();

		/**
		 * 存储按钮的可用状态
		 **/
		private static var enableDic:Dictionary = new Dictionary();

		/**
		 * 存储按钮最后的鼠标事件
		 **/
		private static var eventDic:Dictionary = new Dictionary();

		private static const up_frame:int = 1;

		private static const over_frame:int = 2;

		private static const down_frame:int = 3;

		private static const selected_up_frame:int = 4;

		private static const selected_over_frame:int = 5;

		private static const selected_down_frame:int = 6;

		private static const unEnabled_frame:int = 4;

		public static function make(btnMc:MovieClip):void
		{
			btnMc.gotoAndStop(1);
			btnMc.buttonMode = true;

			btnMc.addEventListener(MouseEvent.MOUSE_UP, onMouseEvent);
			btnMc.addEventListener(MouseEvent.MOUSE_OVER, onMouseEvent);
			btnMc.addEventListener(MouseEvent.MOUSE_DOWN, onMouseEvent);
			btnMc.addEventListener(MouseEvent.MOUSE_OUT, onMouseEvent);
		}

		public static function setSelected(btnMc:MovieClip, selected:Boolean = true):void
		{
			selectedDic[btnMc] = selected;
			doEvent(btnMc, eventDic[btnMc]);
		}

		public static function isSelected(btnMc:MovieClip):Boolean
		{
			return selectedDic[btnMc] ? true : false;
		}

		public static function setEnabled(btnMc:MovieClip, enable:Boolean):void
		{
			btnMc.mouseEnabled = enable;
			enableDic[btnMc] = enable;
			doEvent(btnMc, eventDic[btnMc]);
		}

		public static function isEnabled(btnMc:MovieClip):Boolean
		{
			return selectedDic[btnMc] == null ? true : selectedDic[btnMc];
		}

		private static function onMouseEvent(event:MouseEvent):void
		{
			var btnMc:MovieClip = event.currentTarget as MovieClip;
			eventDic[btnMc] = event.type;
			doEvent(btnMc, event.type);
		}

		private static function doEvent(btnMc:MovieClip, eventName:String = null):void
		{
			var selected:Boolean = selectedDic[btnMc] ? true : false;
			eventName = eventName ? eventName : MouseEvent.MOUSE_OUT;
			if (selected)
			{
				switch (eventName)
				{
					case MouseEvent.MOUSE_UP:
						btnMc.gotoAndStop(selected_over_frame);
						break;
					case MouseEvent.MOUSE_OVER:
						btnMc.gotoAndStop(selected_over_frame);
						break;
					case MouseEvent.MOUSE_DOWN:
						btnMc.gotoAndStop(selected_down_frame);
						break;
					case MouseEvent.MOUSE_OUT:
						btnMc.gotoAndStop(selected_up_frame);
						break;
				}
			}
			else
			{
				switch (eventName)
				{
					case MouseEvent.MOUSE_UP:
						btnMc.gotoAndStop(over_frame);
						break;
					case MouseEvent.MOUSE_OVER:
						btnMc.gotoAndStop(over_frame);
						break;
					case MouseEvent.MOUSE_DOWN:
						btnMc.gotoAndStop(down_frame);
						break;
					case MouseEvent.MOUSE_OUT:
						btnMc.gotoAndStop(up_frame);
						break;
				}
			}

			if (enableDic[btnMc] == false)
			{
				btnMc.gotoAndStop(unEnabled_frame);
			}
		}
	}
}
