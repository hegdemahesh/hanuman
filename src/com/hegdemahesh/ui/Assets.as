package com.hegdemahesh.ui
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
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
		
		private static var gameTextures:Dictionary =new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
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