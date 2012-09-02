package  
{
	import away3d.cameras.Camera3D;
	import away3d.cameras.lenses.LensBase;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.partition.LightNode;
	import away3d.entities.Mesh;
	import away3d.lights.DirectionalLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.EnvMapMethod;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	import away3d.textures.SpecularBitmapTexture;
	import away3d.utils.Cast;
	import fl.motion.easing.Bounce;
	import fl.motion.easing.Exponential;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.events.Event;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Yoshio_SHINGYOUJI
	 */
	public class SixthContent extends ContentBase
	{
		
		[Embed(source="/../embeds/cube_diffuse.jpg")]
    	public static var CubeDiffuse:Class;
		[Embed(source="/../embeds/cube_specular.jpg")]
    	public static var CubeSpecular:Class;
		[Embed(source="/../embeds/cube_nomal.jpg")]
    	public static var CubeNomal:Class;
		
		// Environment map.
		[Embed(source="../embeds/sky_posX.jpg")]
		private var EnvPosX:Class;
		[Embed(source="../embeds/sky_posY.jpg")]
		private var EnvPosY:Class;
		[Embed(source="../embeds/sky_posZ.jpg")]
		private var EnvPosZ:Class;
		[Embed(source="../embeds/sky_negX.jpg")]
		private var EnvNegX:Class;
		[Embed(source="../embeds/sky_negY.jpg")]
		private var EnvNegY:Class;
		[Embed(source="../embeds/sky_negZ.jpg")]
		private var EnvNegZ:Class;
		
		
		private var view		:View3D;
		private var camera		:Camera3D;
		private var light1		:DirectionalLight;
		private var light2		:DirectionalLight;
		private var lightPicker	:StaticLightPicker;
		private var skyBox		:SkyBox;
		private var material	:TextureMaterial;
		private var objectList	:Array = [];
		private var degree:		int = 0;
		private var tweenList	:Array = [];
		
		public function SixthContent() 
		{
			
		}
		
		override public function  initialize():void
		{
			
			var scene:Scene3D = new Scene3D();
			camera = new Camera3D();
			camera.x = 500;
			camera.y = -800;
			camera.z = -1500;
			
			light1 = new DirectionalLight();
			light1.direction = new Vector3D(0, -1, 0);
			//light.color = 0xff0000;
			light1.ambient = 0.3;
			light1.diffuse = 0.7;
			scene.addChild(light1);
			
			light2 = new DirectionalLight();
			light2.direction = new Vector3D(0, -0.2, 0.5);
			light2.color = 0xffffff;
			light2.ambient = 0.1;
			light2.diffuse = 0.7;
			scene.addChild(light2);
			
			lightPicker = new StaticLightPicker([light1, light2]);
			
			view = new View3D(scene, camera);
			view.antiAlias = 4;
			//view.width = 300;
			//view.height = 300;
			this.addChild(view);
			
			
			//setup the cube texture
			var skyBoxTexture:BitmapCubeTexture = new BitmapCubeTexture(Cast.bitmapData(EnvPosX), Cast.bitmapData(EnvNegX), Cast.bitmapData(EnvPosY), Cast.bitmapData(EnvNegY), Cast.bitmapData(EnvPosZ), Cast.bitmapData(EnvNegZ));

			skyBox = new SkyBox(skyBoxTexture);
			view.scene.addChild(skyBox);
			
			material = new TextureMaterial(Cast.bitmapTexture(new CubeDiffuse()));
			material.specularMap = Cast.bitmapTexture(new CubeSpecular());
			material.normalMap = Cast.bitmapTexture(new CubeNomal());
			material.lightPicker = lightPicker;
			material.mipmap = false;
			material.addMethod(new EnvMapMethod(skyBoxTexture, 1));
			
			for (var i:int = -500; i <= 500; i+=300){
				for (var j:int = -500; j <= 500; j+=300){
					for (var k:int = -500; k <= 500; k+=300){
						var cube:Mesh = new Mesh(new CubeGeometry(100, 100, 100, 1, 1, 1, false), material);
						cube.x = k;
						cube.y = j;
						cube.z = i;
						
						var nextScale:Number = Math.random() * 1.9;
						var scaleXTween:Tween = new Tween(cube, "scaleX", Bounce.easeInOut, cube.scaleX, nextScale, 1, true);
						var scaleYTween:Tween = new Tween(cube, "scaleY", Bounce.easeInOut, cube.scaleX, nextScale, 1, true);
						var scaleZTween:Tween = new Tween(cube, "scaleZ", Bounce.easeInOut, cube.scaleX, nextScale, 1, true);
						scaleXTween.addEventListener(TweenEvent.MOTION_FINISH, motionFinishHandler);
						scaleYTween.addEventListener(TweenEvent.MOTION_FINISH, motionFinishHandler);
						scaleZTween.addEventListener(TweenEvent.MOTION_FINISH, motionFinishHandler);
						tweenList.push(scaleXTween);
						tweenList.push(scaleYTween);
						tweenList.push(scaleZTween);
						
						
						objectList.push(cube);
						scene.addChild(cube);
						
					}
				}
			}
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			
		}
		
		override public function finalize():void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			view.dispose();
		}
		
		private function motionFinishHandler(e:TweenEvent):void 
		{
			
			var target:Tween = e.target as Tween;
			target.removeEventListener(TweenEvent.MOTION_FINISH, motionFinishHandler);
			tweenList.splice(tweenList.indexOf(target), 1);
			
			if (target.prop == "scaleX") {
				
				var nextScale:Number = Math.random() * 1.9;
				
				var scaleXTween:Tween = new Tween(target.obj, "scaleX", target.func, target.obj[target.prop], nextScale, 1, true);
				scaleXTween.addEventListener(TweenEvent.MOTION_FINISH, motionFinishHandler);
				tweenList.push(scaleXTween);
				
				var scaleYTween:Tween = new Tween(target.obj, "scaleY", target.func, target.obj[target.prop], nextScale, 1, true);
				scaleYTween.addEventListener(TweenEvent.MOTION_FINISH, motionFinishHandler);
				tweenList.push(scaleYTween);
				
				var scaleZTween:Tween = new Tween(target.obj, "scaleZ", target.func, target.obj[target.prop], nextScale, 1, true);
				scaleZTween.addEventListener(TweenEvent.MOTION_FINISH, motionFinishHandler);
				tweenList.push(scaleZTween);
			}
			//obj:Object, prop:String, func:Function, begin:Number, finish:Number, duration:Number, useSeconds:Boolean=false
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			
			degree+=2;
			if (degree >= 360){
				degree = 0;
			}
			
			camera.x = Math.sin(Math.PI / 180 * degree) * -1500;
			camera.z = Math.cos(Math.PI / 180 * degree) * -1500;
			camera.lookAt(new Vector3D());
			view.render();
		}
		
	}

}