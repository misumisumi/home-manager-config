{ lib, withExtra, ... }:
{
  home.shellAliases = {
    ls = "ls --color=auto";
    grep = "grep --color=auto";
    fgrep = "grep -F --color=auto";
    egrep = "grep -E --color=auto";
  } // lib.optionalAttrs withExtra {
    tty-clock = "tty-clock -s -c -C 6";
  };
}
