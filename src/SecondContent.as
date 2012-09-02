package 
{
	import flash.events.Event;

	/**
	 * ...
	 * @author Yoshio_SHINGYOUJI
	 */
	[Frame(factoryClass="Preloader")]
	public class SecondContent extends ContentBase 
	{

		public function SecondContent():void 
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
			
			var randomCircle:MovingSprite = drawRandomCircle();
			randomCircle.x=Math.random() * 300;
			randomCircle.y=Math.random() * 300;
			addChild(randomCircle);
		}
		
		private function drawRandomCircle():MovingSprite {
			
			var circle:MovingSprite = new MovingSprite();
			circle.graphics.beginFill(0xff0000, Math.random());
			circle.graphics.drawCircle(0, 0, 4);
			circle.graphics.endFill();
			circle.x = Math.random() * 300;
			circle.y = Math.random() * 300;
			
			return circle;
			
		}
		
	}

}