package communication
{

	public final class ProtoFactory
	{
		private static var slotProto:SlotProto;

		public static function getSlotProto():SlotProto
		{
			if (slotProto == null)
			{
				slotProto=new SlotProto();
				slotProto.Init();
			}
			return slotProto;
		}
	}
}
