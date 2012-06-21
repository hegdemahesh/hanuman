package com.hegdemahesh.ui.components
{
	import com.hegdemahesh.model.Assets;
	
	import flash.display.Bitmap;
	
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class LevelMenu extends Sprite
	{
		// creates the embedded bitmap (spritesheet file)
		var bitmap:Bitmap = Bitmap(new com.hegdemahesh.model.Assets());
		// creates a texture out of it
		var texture:Texture = Texture.fromBitmap(bitmap);
		// create the XML file describing the glyphes position on the spritesheet
		var xml:XML = XML(new com.hegdemahesh.model.Assets());
		// register the bitmap font to make it available to TextField
		TextField.registerBitmapFont(new BitmapFont(texture, xml));
		// create the TextField object
		var bmpFontTF:TextField = new TextField(400, 400, "Here is some text, using
			an embedded font!", "Showcard Gothic",12);
		// the native bitmap font size, no scaling
		bmpFontTF.fontSize = BitmapFont.NATIVE_SIZE;
		// use white to use the texture as it is (no tinting)
		bmpFontTF.color = Color.WHITE;
		// centers the text on stage
		//bmpFontTF.x = stage.stageWidth - bmpFontTF.width >> 1;
		//bmpFontTF.y = stage.stageHeight - bmpFontTF.height >> 1;
		this.addChild(bmpFontTF);
		public function LevelMenu()
		{
			super();
		}
	}
}