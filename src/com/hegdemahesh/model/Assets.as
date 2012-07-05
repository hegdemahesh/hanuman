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
package com.hegdemahesh.model
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import nape.geom.GeomPoly;
	import nape.geom.GeomPolyList;
	import nape.geom.Vec2;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		
		[Embed(source="media/drugs.pex", mimeType="application/octet-stream")]
		public static const DrugsConfig:Class;
		
		[Embed(source="media/fire.pex", mimeType="application/octet-stream")]
		public static const FireConfig:Class;
		
		[Embed(source="media/sun.pex", mimeType="application/octet-stream")]
		public static const SunConfig:Class;
		
		[Embed(source="media/jellyfish.pex", mimeType="application/octet-stream")]
		public static const JellyfishConfig:Class;
		
		// particle textures
		
		[Embed(source = "media/drugs_particle.png")]
		public static const DrugsParticle:Class;
		
		[Embed(source = "media/fire_particle.png")]
		public static const FireParticle:Class;
		
		[Embed(source = "media/sun_particle.png")]
		public static const SunParticle:Class;
		
		[Embed(source = "media/jellyfish_particle.png")]
		public static const JellyfishParticle:Class;
		
		
		[Embed(source="assets/hanuman.png")]
		public static const hanumanTexture:Class;
		
		[Embed(source="assets/hanuman.xml",mimeType="application/octet-stream")]
		public static const hanumanTextureXML:Class;
		
		[Embed(source="assets/level1.xml",mimeType="application/octet-stream")]
		public static const level1XML:Class;
		
		[Embed(source="assets/level2.xml",mimeType="application/octet-stream")]
		public static const level2XML:Class;
		
		[Embed(source="assets/level3.xml",mimeType="application/octet-stream")]
		public static const level3XML:Class;
		
		[Embed(source="assets/levelDetails.xml",mimeType="application/octet-stream")]
		public static const levelDetails:Class;
		
		[Embed(source="assets/hanumanActors.xml",mimeType="application/octet-stream")]
		public static const hanumanActorsXML:Class;
		
		[Embed(source="assets/ShowCardGothic.fnt", mimeType="application/octet-stream")]
		public static const ShowCardGothicXML:Class;
		
		[Embed(source="assets/ShowCardGothic_0.png")]
		public static const ShowCardGothicBitmap:Class;
		
		public static var xml:XML = XML(new Assets.hanumanActorsXML());
		
		private static var gameTextures:Dictionary =new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		public static function getShapes(name1:String):GeomPolyList {
			var geomPolyList:GeomPolyList =  new GeomPolyList();
			var k:int = xml.body.(@name == name1).fixture.polygon.length();
			var tName:String = xml.body.(@name == name1).@name;
			for (var i:int = 0 ; i < xml.body.(@name == name1).fixture.polygon.length(); i++){
				var geomPoly:GeomPoly =  new GeomPoly();
				for (var j:int = 0; j < xml.body.(@name == name1).fixture.polygon[i].vertex.length(); j ++){
					var xCoord:int = xml.body.(@name == name1).fixture.polygon[i].vertex[j].@x;
					var yCoord:int = xml.body.(@name == name1).fixture.polygon[i].vertex[j].@y;
					var vertex:Vec2 =  new Vec2(xCoord,yCoord);
					geomPoly.push(vertex);
				}
				geomPolyList.push(geomPoly);
			}
			return geomPolyList;
		}
		
		
		public static function getAtlas():TextureAtlas {
			if (gameTextureAtlas == null){
				var texture:Texture = getTexture("hanumanTexture");
				var xml:XML = XML(new hanumanTextureXML());
				gameTextureAtlas =  new TextureAtlas(texture,xml);
			}
			return gameTextureAtlas;
		}
		
		public static function getTexture(name:String):Texture {
			if (gameTextures[name] == undefined){
				var bitmap:Bitmap =  new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		public function Assets()
		{
			
			
		}
	}
}