package infinite.assets;

#if sys
import sys.FileSystem;
#else
import openfl.utils.Assets;
#end

#if flixel
import flixel.system.FlxAssets.FlxGraphicAsset;
#end

/**
 * Utility class to load and cache your assets
 *
 * @author Infinite KemonoYagi
 */
class InfiAssets
{
  public static var instance:InfiAssets;

  public static inline function initialize():Void instance = new InfiAssets();

  /**
   * store all your loaded assets with some useful features
   *
   * ```haxe
   * // load a new file (for example an image)
   * assets.memory.loadImage("assets/images/cool guy.png", true);
   *
   * // you have also a shortcut in your assets field, but it have some limitations (read documentation of each funcion)
   * assets.getSound("assets/music/cool guy theme.ogg"); // returns the sound data to use for a new FlxSound
   * ```
   */
  public var memory:InfiAssetsMemory;

  public function new()
  {
    memory = new InfiAssetsMemory();
  }

  /**
   * Returns whether a specific asset exists
   */
  public function exists(directory:String):Bool
  {
    #if sys
    return FileSystem.exists(directory);
    #else
    return Assets.exists(directory);
    #end
  }

  /**
   * Get a stored image file from its `directory` and return the graphic data.
   * If the file doesn't exist it loads it instead of getting it from the `StringMap`
   *
   * ```haxe
   * var sprite:FlxSprite = new FlxSprite().loadImage(assets.getImage("assets/images/cool guy.png"));
   * ```
   *
   * But in the case file needs to be loaded you can't load it as a permanent file if you're not loading it in `memory`.
   * This is to make the code more intuitive and accesible.
   *
   * If you want to load a permanent file use `loadImage` from `memory` field and set `permanent` argument as true
   *
   * ```haxe
   * // load image file
   * assets.memory.loadImage("assets/images/important and cool guy.png", true);
   *
   * // using it for a new FlxSprite
   * var sprite:FlxSprite = new FlxSprite().loadImage(assets.getImage("assets/images/important and cool guy.png"));
   * ```
   *
   * @param directory image's directory (you can also put an `FlxGraphic` object)
   */
  #if flixel
  public function getImage(directory:FlxGraphicAsset):Graphic
  #else
  public function getImage(directory:String):Graphic
  #end
  {
    if (!exists(directory)) throw 'The image file from $directory doesn\'t exists';

    if (!memory.hasImage(directory)) memory.loadImage(directory);
    return memory.getImage(directory);
  }

  /**
   * Get a stored audio file from its `directory` and return the sound data.
   * If the file doesn't exist it loads it instead of getting it from the `StringMap`
   *
   * ```haxe
   * var sound:FlxSound = new FlxSound().load(assets.getAudio("assets/music/cool guy theme.ogg"));
   * ```
   *
   * But in the case file needs to be loaded you can't load it as a permanent file if you're not loading it in `memory`.
   * This is to make the code more intuitive and accesible.
   *
   * If you want to load a permanent file use `loadAudio` from `memory` field and set `permanent` argument as true
   *
   * ```haxe
   * // load image file
   * assets.memory.loadAudio("assets/music/important and cool guy theme.ogg", true);
   *
   * // using it for a new FlxSound
   * var sound:FlxSound = new FlxSound().load(assets.getAudio("assets/music/important and cool guy theme.ogg"));
   * ```
   *
   * @param directory audio's directory
   */
  public function getAudio(directory:String):Sound
  {
    if (!exists(directory)) throw 'The audio file from $directory doesn\'t exists';

    if (!memory.hasAudio(directory)) memory.loadAudio(directory);
    return memory.getAudio(directory);
  }

  /**
   * Get a stored file from its `directory` and return the text data.
   * If the file doesn't exist it loads it instead of getting it from the `StringMap`
   *
   * ```haxe
   * var data:String = assets.getFile("assets/data/cool guy information.txt");
   * ```
   *
   * But in the case file needs to be loaded you can't load it as a permanent file if you're not loading it in `memory`.
   * This is to make the code more intuitive and accesible.
   *
   * If you want to load a permanent file use `loadAudio` from `memory` field and set `permanent` argument as true
   *
   * ```haxe
   * // load image file
   * assets.memory.loadFile("assets/data/important and cool guy information.json", true);
   *
   * // using it for a new FlxSound
   * var information:Dynamic = Json.parse(assets.getFile("assets/data/important and cool guy information.json"));
   * ```
   *
   * @param directory audio's directory
   */
  public function getFile(directory:String):String
  {
    if (!exists(directory)) throw 'The file from $directory doesn\'t exists';

    if (!memory.hasFile(directory)) memory.loadFile(directory);
    return memory.getFile(directory);
  }
}
