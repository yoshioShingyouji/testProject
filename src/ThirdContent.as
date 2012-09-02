package 
{
	import flash.events.Event;

	/**
	 * ...
	 * @author Yoshio_SHINGYOUJI
	 */
	[Frame(factoryClass="Preloader")]
	public class ThirdContent extends ContentBase 
	{

		public function ThirdContent():void 
		{
			
		}

		override public function initialize():void
		{	
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		override public function finalize():void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			
			var tweenSprite:TweenSprite = new TweenSprite();
			addChild(tweenSprite);
		}
		
	}

}