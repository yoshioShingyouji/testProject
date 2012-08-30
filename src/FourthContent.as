package 
{
	import fl.motion.easing.Bounce;
	import fl.motion.easing.Elastic;
	import fl.transitions.Tween;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author Yoshio_SHINGYOUJI
	 */
	[Frame(factoryClass="Preloader")]
	public class FourthContent extends ContentBase 
	{
		
		private var xTweenList:Array = [];
		private var yTweenList:Array = [];
		
		public function FourthContent():void 
		{
			
		}

		override public function initialize():void
		{	
			
			const HEIGHT:int = 300;
			const WIDTH	:int = 300;
			for (var i:int = 0; i < HEIGHT; i += 10) {
				for (var j:int = 0; j < WIDTH; j += 10) {
					var circle:Sprite = createCircle();
					this.addChild(circle);
					circle.x = Math.random() * HEIGHT;
					circle.y = Math.random() * WIDTH;
					var xTween:Tween = new Tween(circle, "x", Bounce.easeInOut, circle.x, j, 1, true);
					var yTween:Tween = new Tween(circle, "y", Elastic.easeInOut, circle.y, i, 1, true);
					xTweenList.push(xTween);
					yTweenList.push(yTween);
				}
			}
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		override public function finalize():void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			
			if (xTweenList.length != 0)
			{
				var xTween:Tween = xTweenList.shift();
				xTween.start();
				//xTween.yoyo();
			}
			if (yTweenList.length != 0)
			{
				var yTween:Tween = yTweenList.shift();
				yTween.start();
				//yTween.yoyo();
			}else {
				this.stop();
			}
			
		}
		
		private function createCircle():Sprite {
			
			var circle:Sprite = new Sprite();
			circle.graphics.beginFill(0x999900, Math.random());
			circle.graphics.drawCircle(0, 0, 5);
			circle.graphics.endFill();
			
			return circle;
			
		}
		
	}

}