package moudle
{

	public class Controller
	{
		public var dispatcher : GameDispatcher;

		public function Controller()
		{
			dispatcher = GameDispatcher.getInstance();
		}

	}
}
