{ pkgs
, ...
}:
{
  home = {
    packages = with pkgs;[
      ffmpeg # Multi media solution
      graphicsmagick # CLI Image Editor
      sox # CLI Sound Editor
    ];
  };
}
