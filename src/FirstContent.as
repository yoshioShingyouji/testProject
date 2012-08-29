package 
{
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author Yoshio_SHINGYOUJI
	 */
	[Frame(factoryClass="Preloader")]
	public class FirstContent extends ContentBase 
	{

		public function FirstContent():void 
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
			
			var randomCircle:Sprite = drawRandomCircle();
			randomCircle.x=Math.random() * 300;
			randomCircle.y=Math.random() * 300;
			addChild(randomCircle);
		}
		
		private function drawRandomCircle():Sprite {
			
			var circle:Sprite = new Sprite();
			circle.graphics.beginFill(Math.floor(Math.random() * 0xffffff), Math.random());
			circle.graphics.drawCircle(0, 0, Math.random() * 40);
			circle.graphics.endFill();
			circle.x = Math.random() * 300;
			circle.y = Math.random() * 300;
			
			return circle;
			
		}
		
	}

}