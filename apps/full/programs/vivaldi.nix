{ pkgs, ... }:
{
  home.sessionVariables = {
    CHROME_PATH = "${pkgs.vivaldi}/bin/vivaldi";
  };
  programs.vivaldi = {
    enable = true;
    package = pkgs.vivaldi.override { proprietaryCodecs = true; };
    dictionaries = with pkgs; [
      hunspellDictsChromium.en_US
    ];
    extensions = [
      { id = "joaffhoebddkohkafembmdkfmmcgmepj"; } # better vrchat dot com
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "elfdpkmfllnhhgnicaaeacbilcallpbd"; } # flow chat for youtube live
      { id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi"; } # google docs offline
      { id = "neebplgakaahbhdphmkckjjcegoiijjo"; } # keepa
      { id = "ophjlpahpchlmihnnnihgmmeilfjmjjc"; } # line
      { id = "chphlpgkkbolifaimnlloiipkdnihall"; } # one tab
      { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; } # privacy badger
      { id = "mheleidccioamimekojienbdfclcbaan"; } # q accelerator
      { id = "ejcfdikabeebbgbopoagpabbdokepnff"; } # rajiko
      { id = "niloccemoadcdkdjlinkgdfekeahmflj"; } # save to pocket
      { id = "pncfbmialoiaghdehhbnbhkkgmjanfhe"; } # ublock list
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "nffaoalbilbmmfgbnbgppjihopabppdk"; } # video speed controller
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "diapeboihmphompedonjjbmkbhflmcek"; } # vrc url pasteExtension
      { id = "ekhagklcjbdpajgpjgmbionohlpdbjgc"; } # zotero connector
      {
        id = "bolggfoncklhniejomgplkjcllmnonbh";
        updateUrl = "https://raw.githubusercontent.com/FilipePS/Traduzir-paginas-web/master/updates.xml";
      } # translate web pages
      {
        id = "ajdlpmoffekghhblfajmiacgbdknmbpa";
        updateUrl = "https://raw.githubusercontent.com/misumisumi/Chromium-Extensions-auto-packer/main/BetterTweetDeckOTD/updates.xml";
      } # Better TweetDeck (OldTweetDeck-compatible)
      {
        id = "bjcdldglejahkljjcjhpdclapfpiphhf";
        updateUrl = "https://raw.githubusercontent.com/misumisumi/Chromium-Extensions-auto-packer/main/OldTweetDeck/updates.xml";
      } # OldTweetDeck
    ];
  };
}
