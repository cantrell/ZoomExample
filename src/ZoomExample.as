package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.TransformGestureEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	[SWF(width=460, height=320, frameRate=24, backgroundColor=0x000000)]
	public class ZoomExample extends Sprite
	{
		[Embed(source="seiko_gmt.jpg")]
		public var WatchImage:Class;
		public var scaleDebug:TextField;
		public var rotateDebug:TextField;
		public var positionDebug:TextField;

		private const APP_WIDTH:uint = 460;
		private const APP_HEIGHT:uint = 320;
		
		private const IMG_WIDTH:uint = 1024;
		private const IMG_HEIGHT:uint = 768;
		
		public function ZoomExample()
		{
			// Debug
			var tf:TextFormat = new TextFormat();
			tf.color = 0xffffff;
			tf.font = "Helvetica";
			tf.size = 11;

			this.scaleDebug = new TextField();
			this.scaleDebug.mouseEnabled = false;
			this.scaleDebug.width = 310;
			this.scaleDebug.defaultTextFormat = tf;
			this.scaleDebug.x = 2;
			this.scaleDebug.y = 2;
			this.scaleDebug.selectable = false;
			this.scaleDebug.text = "0, 0";
			this.stage.addChild(this.scaleDebug);

			this.rotateDebug = new TextField();
			this.rotateDebug.mouseEnabled = false;
			this.rotateDebug.width = 310;
			this.rotateDebug.defaultTextFormat = tf;
			this.rotateDebug.x = 2;
			this.rotateDebug.y = 15;
			this.rotateDebug.selectable = false;
			this.rotateDebug.text = "0";
			this.stage.addChild(this.rotateDebug);

			this.positionDebug = new TextField();
			this.positionDebug.mouseEnabled = false;
			this.positionDebug.width = 310;
			this.positionDebug.defaultTextFormat = tf;
			this.positionDebug.x = 2;
			this.positionDebug.y = 28;
			this.positionDebug.selectable = false;
			this.positionDebug.text = "0, 0";
			this.stage.addChild(this.positionDebug);

			var watchBitmap:Bitmap = new WatchImage();
			watchBitmap.smoothing = true;
			var watch:Sprite = new Sprite();
			
			watch.addChild(watchBitmap);

			var scaleFactor:Number = APP_WIDTH / IMG_WIDTH;
			
			watch.scaleX = scaleFactor;
			watch.scaleY = scaleFactor;
			
			watch.x = APP_WIDTH / 2;
			watch.y = APP_HEIGHT / 2;
			
			watchBitmap.x = (IMG_WIDTH - (IMG_WIDTH / 2)) * -1;
			watchBitmap.y = (IMG_HEIGHT - (IMG_HEIGHT / 2)) *-1;
			
			this.addChild(watch);

			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			watch.addEventListener(TransformGestureEvent.GESTURE_ZOOM, onZoom);
			watch.addEventListener(TransformGestureEvent.GESTURE_ROTATE, onRotate);
			watch.addEventListener(TransformGestureEvent.GESTURE_PAN, onPan);
		}
		
		private function onZoom(e:TransformGestureEvent):void
		{
			this.scaleDebug.text = (e.scaleX + ", " + e.scaleY);
			var watch:Sprite = e.target as Sprite;
			watch.scaleX *= e.scaleX;
			watch.scaleY *= e.scaleY;
		}
		
		private function onRotate(e:TransformGestureEvent):void
		{
			var watch:Sprite = e.target as Sprite;
			this.rotateDebug.text = String(e.rotation);
			watch.rotation += e.rotation;
		}

		private function onPan(e:TransformGestureEvent):void
		{
			var watch:Sprite = e.target as Sprite;
			var watchBitmap:Bitmap = watch.getChildAt(0) as Bitmap;
			watchBitmap.x += e.offsetX;
			watchBitmap.y += e.offsetY;
			this.positionDebug.text = watchBitmap.x + " , " + watchBitmap.y;
		}
	}
}