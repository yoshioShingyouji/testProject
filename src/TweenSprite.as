package 
{
	import fl.motion.easing.Bounce;
	import fl.motion.easing.Elastic;
	import fl.transitions.Tween;
	import flash.display.Sprite;
	import flash.events.Event;

	/**S
	 * ...
	 * @author Yoshio_SHINGYOUJI
	 */
	public class TweenSprite extends Sprite 
	{

		public function TweenSprite():void 
		{
			
			this.graphics.beginFill(0x22cc00, Math.random()*0.5);
			this.graphics.drawCircle(0, 0, 10);
			this.graphics.endFill();
			
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			
			var xTween:Tween = new Tween(this, "x", Bounce.easeInOut, Math.random() * 300, Math.random() * 300, 2, true);
			var yTween:Tween = new Tween(this, "y", Elastic.easeInOut, Math.random() * 300, Math.random() * 300, 2, true);
			xTween.start();
			yTween.start();
		}
		
	}

}