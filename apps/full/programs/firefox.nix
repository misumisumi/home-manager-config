{ username, nur, ... }:
{
  programs.firefox = {
    enable = true;
    profiles."${username}".extensions = with nur.repos.rycee.firefox-addons; [
      bitwarden
      darkreader
      onetab
      privacy-badger
      ublock-origin
      ublocklist
      vimium
    ];
  };
}
