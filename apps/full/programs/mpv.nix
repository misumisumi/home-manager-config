{
  programs.mpv = {
    enable = true;
    config = {
      osd-fractions = true;
      osd-level = 2;
      no-keepaspect-window = true;
      ytdl-format = "bestvideo+bestaudio";
    };
  };
}
