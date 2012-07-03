/**
 * The Hanuman Game V1.0
 * Copyright (c) 2012 Maheshchandra hegde, http://www.hegdemahesh.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
package com.hegdemahesh.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	
	import nape.geom.AABB;
	import nape.geom.GeomPoly;
	import nape.geom.GeomPolyList;
	import nape.geom.MarchingSquares;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.Material;
	import nape.shape.Polygon;
	
	import starling.display.Sprite;
	import starling.display.Stage;
	import com.hegdemahesh.ui.components.Actor;
	
	public class BodyFromGraphic extends starling.display.Sprite
	{
		
		
		public static function starlingToBody(bodyTemp:Body,material:Material,granularity:Vec2=null):Body {
			var body:Body = bodyTemp;
			var graphic:Actor = body.graphic as Actor;
			
			graphic.x = graphic.y = graphic.rotation = 0;
			
			var bounds:AABB = AABB.fromRect(graphic.image.getBounds(graphic.image));
			var iso:Function = function(x:Number,y:Number):Number {
				//canot really do a more complex iso-function
				//with hitTestPoint. return inside iso-surface
				//if we hit at the point, otherwise outside
				return (graphic.image.hitTest(new Point(x,y))) ? -1.0 : 1.0;
			}
			
			var grain:Vec2 = (granularity==null) ? new Vec2(4,4) : granularity;
			var polys:GeomPolyList = MarchingSquares.run(iso, bounds, grain,2);
			polys.foreach(function (p:GeomPoly):void {
				var qolys:GeomPolyList = p.simplify(1).convex_decomposition();
				qolys.foreach(function (q:GeomPoly):void {
					body.shapes.add(new Polygon(q,material));
				});
			});
			
			var anchor:Vec2 = body.localCOM.mul(-1);
			body.align();
			
			body.graphic = graphic;
			body.graphicOffset = anchor;
			
			return body;
		}
		
		//take a graphical object on which hitTestPoint will work
		//and produce a nape body with the exact same positions and shapes
		//with input graphic assigned to the body and display appropriately
		
		
		public function BodyFromGraphic()
		{
		}
	}
}