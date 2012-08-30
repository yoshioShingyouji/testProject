package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	import ContentBase;
	import FirstContent;
	import SecondContent;
	
	/**
	 * ...
	 * @author Yoshio_SHINGYOUJI
	 */
	public class Preloader extends MovieClip 
	{
		
		private var index				:int = 0;
		private var contentNameList		:Array;
		private var displaingContent	:ContentBase;
		private var nextContent			:ContentBase;
		
		private var first:Class=FirstContent;
		private var second:Class = SecondContent;
		private var third:Class = ThirdContent;
		private var fourth:Class = FourthContent;
		
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			contentNameList = ["FirstContent","SecondContent","ThirdContent","FourthContent"];
			
			// TODO show loader
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// TODO update loader
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
			startup();
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			startup();
		}
		
		private function startup():void 
		{
			
			var nextContentName:String = contentNameList[index];
			index++;
			if (index == contentNameList.length)
			index = 0;
			
			var mainClass:Class = getDefinitionByName(nextContentName) as Class;
			nextContent = new mainClass() as ContentBase;
			this.addChild(nextContent);
			
			if (displaingContent) {
				this.removeChild(displaingContent);
				displaingContent.finalize();
			}
			displaingContent = nextContent;
			displaingContent.initialize();
			nextContent = null;

			
		}
		
	}
	
}