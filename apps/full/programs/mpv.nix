{
  programs.mpv = {
    enable = true;
    config = {
      keepaspect = false;
      osd-fractions = true;
      osd-level = 2;
      ytdl-format = "bestvideo+bestaudio";
    };
  };
}
