{ lib
, withExtra ? false
, withTmux ? false
}:
with lib;
[
  ./fzf
  ./git
  ./man
  ./ranger
]
++ (import ./shell)
++ optionals withExtra [
  ./direnv
  ./editorconfig
  ./latexmk
  ./navi
  ./neovim
]
++ optional withTmux ./tmux
