package punk.bloom
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Graphic;
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
			active = g.active;
			visible = g.visible;
			relative = g.relative;
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
		
		override public function update():void
		{
			_graphic.update();
		}
		
	}

}