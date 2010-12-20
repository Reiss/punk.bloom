package  
{
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Graphic;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Reiss
	 */
	public class BloomWrapper extends Graphic
	{
		public var bloomCanvas:BitmapData = null;
		private var _graphic:Graphic;
		
		public function BloomWrapper(g:Graphic)
		{
			super();
			_graphic = g;
		}
		
		public function get wrappedGraphic():Graphic
		{
			return _graphic;
		}
		
		override public function render(target:BitmapData, point:Point, camera:Point):void
		{
			if (bloomCanvas)
				_graphic.render(bloomCanvas, point, camera);
			_graphic.render(target, point, camera);
			
		}
		
	}

}