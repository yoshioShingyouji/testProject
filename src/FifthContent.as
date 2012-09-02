package 
{
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.PlaneGeometry;
	import away3d.utils.Cast;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	
	/**
	 * ...
	 * @author Yoshio_SHINGYOUJI
	 */
	[Frame(factoryClass="Preloader")]
	public class FifthContent extends ContentBase 
	{
		[Embed(source = "/../embeds/grass.jpg")]
		public static var FloorDiffuse:Class;
		
		private var view:View3D;
		private var plane:Mesh;
		
		private var xTweenList:Array = [];
		private var yTweenList:Array = [];
		
		public function FifthContent():void 
		{
			
		}

		override public function initialize():void
		{	
			
			// create a viewport
			view = new View3D();
			view.width	= 300;
			view.height	= 300;
			this.addChild(view);
			
			view.camera.z = -600;
			view.camera.y = 500;
			view.camera.lookAt(new Vector3D());
			
			plane = new Mesh(new PlaneGeometry(700,700), new TextureMaterial(Cast.bitmapTexture(FloorDiffuse)));
			view.scene.addChild(plane);
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		override public function finalize():void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			this.removeChild(view);
			view.dispose();
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			
			plane.rotationY += 1;
			
			view.render();
			
		}
		
	}

}