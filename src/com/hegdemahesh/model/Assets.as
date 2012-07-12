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
	import flash.media.Sound;
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
		
		[Embed(source="media/smokeParticle.pex", mimeType="application/octet-stream")]
		public static const SmokeConfig:Class;
		
		// particle textures
		
		[Embed(source = "media/drugs_particle.png")]
		public static const DrugsParticle:Class;
		
		[Embed(source = "media/fire_particle.png")]
		public static const FireParticle:Class;
		
		[Embed(source = "media/sun_particle.png")]
		public static const SunParticle:Class;
		
		[Embed(source = "media/smokeTexture.png")]
		public static const SmokeParticle:Class;
		
		[Embed(source = "media/jellyfish_particle.png")]
		public static const JellyfishParticle:Class;
		
		
		[Embed(source="assets/hanuman.png")]
		public static const hanumanTexture:Class;
		
		
		[Embed(source="assets/bg.png")]
		public static const bg:Class;
		
		[Embed(source="assets/hanuman.xml",mimeType="application/octet-stream")]
		public static const hanumanTextureXML:Class;
		
		[Embed(source="assets/level1.xml",mimeType="application/octet-stream")]
		public static const level1XML:Class;
		
		[Embed(source="assets/level3.xml",mimeType="application/octet-stream")]
		public static const level2XML:Class;
		
		[Embed(source="assets/level5.xml",mimeType="application/octet-stream")]
		public static const level3XML:Class;
		
		[Embed(source="assets/level8.xml",mimeType="application/octet-stream")]
		public static const level4XML:Class;
		
		[Embed(source="assets/level11.xml",mimeType="application/octet-stream")]
		public static const level5XML:Class;
		
		[Embed(source="assets/level2.xml",mimeType="application/octet-stream")]
		public static const level6XML:Class;
		
		[Embed(source="assets/level7.xml",mimeType="application/octet-stream")]
		public static const level7XML:Class;
		
		[Embed(source="assets/level6.xml",mimeType="application/octet-stream")]
		public static const level8XML:Class;
		
		[Embed(source="assets/level13.xml",mimeType="application/octet-stream")]
		public static const level9XML:Class;
		
		[Embed(source="assets/level14.xml",mimeType="application/octet-stream")]
		public static const level10XML:Class;
		
		[Embed(source="assets/level15.xml",mimeType="application/octet-stream")]
		public static const level11XML:Class;
		
		[Embed(source="assets/level12.xml",mimeType="application/octet-stream")]
		public static const level12XML:Class;
		
		[Embed(source="assets/level10.xml",mimeType="application/octet-stream")]
		public static const level13XML:Class;
		
		[Embed(source="assets/level4.xml",mimeType="application/octet-stream")]
		public static const level14XML:Class;
		
		[Embed(source="assets/level9.xml",mimeType="application/octet-stream")]
		public static const level15XML:Class;
		
		/*[Embed(source="assets/level16.xml",mimeType="application/octet-stream")]
		public static const level16XML:Class;
		
		[Embed(source="assets/level17.xml",mimeType="application/octet-stream")]
		public static const level17XML:Class;
		
		[Embed(source="assets/level18.xml",mimeType="application/octet-stream")]
		public static const level18XML:Class;*/
		
		[Embed(source="assets/levelDetails.xml",mimeType="application/octet-stream")]
		public static const levelDetails:Class;
		
		
		
		[Embed(source="assets/hanumanActors.xml",mimeType="application/octet-stream")]
		public static const hanumanActorsXML:Class;
		
		[Embed(source="assets/ShowCardGothic.fnt", mimeType="application/octet-stream")]
		public static const ShowCardGothicXML:Class;
		
		[Embed(source="assets/ShowCardGothic_0.png")]
		public static const ShowCardGothicBitmap:Class;
		
		[Embed(source="assets/music/scream1.mp3")]
		public static const scream1:Class;
		
		[Embed(source="assets/music/background1.mp3")]
		public static const background1:Class;
		
		[Embed(source="assets/music/background2.mp3")]
		public static const background2:Class;
		
		[Embed(source="assets/music/background3.mp3")]
		public static const background3:Class;
		
		[Embed(source="assets/music/background4.mp3")]
		public static const background4:Class;
		
		[Embed(source="assets/music/crash.mp3")]
		public static const crash:Class;
		
		[Embed(source="assets/music/crash2.mp3")]
		public static const crash2:Class;
		
		[Embed(source="assets/music/crash3.mp3")]
		public static const crash3:Class;
		
		[Embed(source="assets/music/crash4.mp3")]
		public static const crash4:Class;
		
		/*[Embed(source="assets/music/scream2.mp3")]
		public static const scream2:Class;*/
		
		[Embed(source="assets/music/laugh.mp3")]
		public static const laugh:Class;
		
		[Embed(source="assets/music/victory.mp3")]
		public static const victory:Class;
		
		[Embed(source="assets/music/victory1.mp3")]
		public static const victory1:Class;
		
		/*[Embed(source="assets/music/scream3.mp3")]
		public static const scream3:Class;
		
		[Embed(source="assets/music/scream4.mp3")]
		public static const scream4:Class;*/
		
		public static var xml:XML = XML(new Assets.hanumanActorsXML());
		
		private static var gameTextures:Dictionary =new Dictionary();
		private static var gameSounds:Dictionary =new Dictionary();
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
				gameTextures[name] = Texture.fromBitmap(bitmap,false);
			}
			return gameTextures[name];
		}
		
		public static function getSound(name:String):Sound {
			
			if (gameSounds[name] == undefined){
				var sound:Sound = new Assets[name]();
				gameSounds[name] = sound;
			}
			return gameSounds[name];
		}
		public function Assets()
		{
			
			
		}
	}
}