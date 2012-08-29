package 
{
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author Yoshio_SHINGYOUJI
	 */
	public class MovingSprite extends Sprite 
	{

		public function MovingSprite():void 
		{
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			this.x += Math.floor(Math.random() * 10)-5;
			this.y += Math.floor(Math.random() * 10)-5;
		}
		
	}

}