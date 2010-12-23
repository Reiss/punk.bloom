package punk.bloom
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import net.flashpunk.Graphic;
	
	/**
	 * ...
	 * @author Reiss
	 */
	public class BloomLighting extends Entity
	{
		//buffers and filters for creating the bloom
		private var _canvas:BitmapData = new BitmapData(FP.width, FP.height, false, 0xff000000);
		private var _postprocess:BitmapData = new BitmapData(FP.width, FP.height, false, 0xff000000);
		private var _filter:BlurFilter;
		
		//screen size, location
		private var _screenrect:Rectangle = new Rectangle(0, 0, FP.width, FP.height);
		private var _screenpoint:Point = new Point();
		
		//tinting data
		private var _color:uint = 0x00FFFFFF;
		protected var _tint:ColorTransform = null;
		
		
		public function BloomLighting(bloom:Number, quality:int)
		{
			super();
			_filter = new BlurFilter(bloom, bloom, quality);
		}
		
		//tinting accessors
		public function get color():uint { return _color; }
		public function set color(value:uint):void
		{
			value &= 0xFFFFFF;
			if (_color == value) return;
			_color = value;
			if (_color == 0xFFFFFF)
			{
				_tint = null;
				return;
			}
			_tint = new ColorTransform();
			_tint.redMultiplier = (_color >> 16 & 0xFF) / 255;
			_tint.greenMultiplier = (_color >> 8 & 0xFF) / 255;
			_tint.blueMultiplier = (_color & 0xFF) / 255;
		}
		
		//register an entity as casting bloom lighting
		public function register(g:BloomWrapper):void
		{
			g.bloomCanvas = _canvas;
		}
		
		//unregister and entity as casting bloom lighting
		public function unregister(g:BloomWrapper):void
		{
			g.bloomCanvas = null;
		}
		
		//returns the bloom canvas, in case you want to draw to it without using a bloom wrapper
		public function get buffer():BitmapData
		{
			return _canvas;
		}
		
		override public function render():void
		{
			super.render();
			
			//calculate the blur from the canvas
			_postprocess.applyFilter(_canvas, _screenrect, _screenpoint, _filter);
			
			//draw the blur to the buffer using SCREEN blending, to simulate bloom lighting
			FP.buffer.draw(_postprocess,null,_tint,BlendMode.SCREEN);
			
			//clear the canvas after drawing
			_canvas.fillRect(_screenrect, 0xff000000);
		}
		
	}

}