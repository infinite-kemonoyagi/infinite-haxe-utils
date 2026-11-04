package infinite.assets;

import haxe.ds.StringMap;

/**
 * Class to storage all your loaded assets with some useful features
 *
 * @author Infinite KemonoYagi
 */
@:nullSafety
class InfiAssetsMemory
{
  /**
	 * Stored data images
	 */
	public var storedImages:StringMap<Graphic>;

	/**
	 * Stored permanent data images
	 *
	 * these images won't be deleted while memory had to delete all their stored files
	 *
	 * BE AWARE TO ONLY STORE NECESSARY IMAGES TO DON'T OVERLOAD RAM FOR LOWER-END COMPUTERS
	 */
	public var permanentImages:Array<String>;

	/**
	 * Stored data audios
	 */
	public var storedAudios:StringMap<Sound>;

	/**
	 * Stored permanent data audios
	 *
	 * these audios won't be deleted while memory had to delete all their stored files
	 *
	 * BE AWARE TO ONLY STORE NECESSARY AUDIOS TO DON'T OVERLOAD RAM FOR LOWER-END COMPUTERS
	 */
	public var permanentAudios:Array<String>;

	/**
	 * Stored data files (useful for big files)
	 */
	public var storedFiles:StringMap<String>;

	/**
	 * Stored permanent data files
	 *
	 * these files won't be deleted while memory had to delete all their stored files
	 *
	 * BE AWARE TO ONLY STORE NECESSARY FILES TO DON'T OVERLOAD RAM FOR LOWER-END COMPUTERS
	 */
	public var permanentFiles:Array<String>;

  public function new()
  {
    storedImages    = new StringMap();
    storedAudios    = new StringMap();
    storedFiles     = new StringMap();

    permanentImages = [];
    permanentAudios = [];
    permanentFiles  = [];
  }

  /**
   * Store an image, set it as permanent or not and return the graphic data
   *
   * @param directory image's directory (you can also put an `FlxGraphic` object)
   * @param permanent the image won't be deleted
   */
  public function loadImage(directory:FlxGraphicAsset, permanent:Bool = false):Void
  {
    function getDirectory():String return (directory is Graphic) ? (directory : Graphic).assetsKey : directory;
    function addToPermanent():Void permanentImages.push(getDirectory());

    final graphic:Graphic = if (directory is Graphic) cast directory;
    else FlxG.bitmap.add(directory, true, directory);

    graphic.persist = true;
    storedImages.set(graphic.assetsKey, graphic);

    if (permanent) addToPermanent();
  }

  /**
   * Get stored image
   */
  public function getImage(directory:FlxGraphicAsset):Null<Graphic>
    return storedImages.get((directory is Graphic) ? (directory : Graphic).assetsKey : directory);

  /**
   * Is the `directory` image already stored
   */
  public function hasImage(directory:FlxGraphicAsset):Bool
    return storedImages.exists((directory is Graphic) ? (directory : Graphic).assetsKey : directory);

  /**
   * Store an audio, set it as permanent or not and return the sound data
   *
   * @param directory audio's directory
   * @param permanent the audio won't be deleted
   */
  public function loadAudio(directory:String, permanent:Bool = false):Void
  {
    function addToPermanent():Void permanentAudios.push(directory);

    final sound:Sound = Assets.getSound(directory);
    storedAudios.set(directory, sound);

    if (permanent) addToPermanent();
  }

  /**
   * Get stored audio
   */
  public function getAudio(directory:String):Null<Sound> return storedAudios.get(directory);

  /**
   * Is the `directory` audio already stored
   */
  public function hasAudio(directory:String):Bool return storedAudios.exists(directory);

  /**
   * Store an file, set it as permanent or not and return the file text data
   *
   * @param directory file's directory
   * @param permanent the file won't be deleted
   */
  public function loadFile(directory:String, permanent:Bool = false):Void
  {
    function addToPermanent():Void permanentFiles.push(directory);

    final file:String = Assets.getText(directory);
    storedFiles.set(directory, file);

    if (permanent) addToPermanent();
  }

  /**
   * Get stored audio
   */
  public function getFile(directory:String):Null<String> return storedFiles.get(directory);

  /**
   * Is the `directory` file already stored
   */
  public function hasFile(directory:String):Bool return storedFiles.exists(directory);

  /**
   * Clear all the stored data
   */
  public function clear():Void
  {
    for (directory => graphic in storedImages)
    {
      if (permanentImages.contains(directory)) continue;

      graphic.persist = false;
      graphic.destroy();
      storedImages.remove(directory);
    }

    for (directory => audio in storedAudios)
    {
      if (permanentAudios.contains(directory)) continue;

      audio.close();
      storedAudios.remove(directory);
    }

    for (directory => _ in storedFiles)
    {
      if (permanentFiles.contains(directory)) continue;
      storedFiles.remove(directory);
    }
  }
}
