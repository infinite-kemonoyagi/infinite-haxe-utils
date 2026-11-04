package infinite.state;

#if flixel
import flixel.FlxState;

import infinite.assets.InfiAssets;
import infinite.assets.InfiAssetsMemory;

class InfiState extends FlxState
{
  /**
   * load and cache your assets
   */
  public var assets(get, never):InfiAssets;

  /**
   * store all your loaded assets with some useful features
   *
   * ```haxe
   * // load a new file (for example an image)
   * memory.loadImage("assets/images/cool guy.png", true);
   *
   * // you have also a shortcut in your assets field, but it have some limitations (read documentation of each funcion)
   * assets.getSound("assets/music/cool guy theme.ogg"); // returns the sound data to use for a new FlxSound
  */
  public var memory(get, never):InfiAssetsMemory;

  public function new() super();

  @:noCompletion
  private function get_assets():InfiAssets return InfiAssets.instance;

  @:noCompletion
  private function get_memory():InfiAssetsMemory return InfiAssets.instance.memory;
}
#end
